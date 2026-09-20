import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets
import "overviewLayout.js" as OvLayout

// One workspace shown as a row of window pills inside one trapezium frame.
// Everything here is in BAR coordinates (same numbers as CyberBar.qml), so the
// pane must be placed at (0,0) of a bar-sized parent. The geometry properties
// describe the slot the pills may occupy; they never leave it, however many
// windows are open (extra windows collapse into a "+N" chip).
Item {
    id: pane

    property int workspaceId: 1

    // ---- slot geometry (bar coordinates) ----
    property real spanLeft: 428       // x of the first pill's TOP-left corner
    property real spanWidth: 115      // room along the pills' top edge
    property real pillTop: 9
    property real pillHeight: 27      // == shear, so pills lean at exactly 45°

    // ---- tuning ----
    property real gap: 3
    property real minPillWidth: 22    // narrower than this -> overflow into the chip
    property real chipWidth: 24
    property real iconMax: 16
    property string previewMode: "focused"   // "icon" | "focused" | "all"
    property real previewMinWidth: 24

    property color lineColor: "#36F8EC"
    property color accentColor: "#FEF709"
    property color alertColor: "#f809c9"
    property color pillFill: "#337a7f8c"
    property string fontFamily: "Iosevka SciFi"

    // Preview refresh: 0 = true live video (smoothest but heaviest), otherwise a
    // still frame every N ms. Each capture allocates a buffer, so longer is lighter.
    property int previewInterval: 2000

    signal pillEntered(var pill, var tl)
    signal pillExited(var pill)

    // ------------------------------------------------------------- data
    function windowsHere() {
        const src = Hyprland.toplevels.values;
        const out = [];
        for (let i = 0; i < src.length; i++) {
            const t = src[i];
            if (!t || !t.address)
                continue;
            const ws = t.workspace;
            if (!ws || ws.id !== pane.workspaceId)
                continue;
            out.push({
                    "key": t.address,
                    "ref": t,
                    "focused": t === Hyprland.activeToplevel
                });
        }
        return out;
    }

    // Hyprland pokes its toplevel objects constantly (titles, geometry, refreshes).
    // This string only changes when the set of windows here or the focus changes,
    // so nothing downstream is recomputed for unrelated churn.
    readonly property string signature: {
        const w = windowsHere();
        let s = "";
        for (let i = 0; i < w.length; i++)
            s += w[i].key + (w[i].focused ? "*" : "") + ",";
        return s;
    }

    // Snapshot of the windows, refreshed only when `signature` changes. Reading
    // toplevels inside a signal handler (not a binding) creates no dependencies.
    property var windows: []
    onSignatureChanged: windows = windowsHere()
    Component.onCompleted: windows = windowsHere()

    readonly property var plan: OvLayout.plan(windows, {
            "spanLeft": pane.spanLeft,
            "spanWidth": pane.spanWidth,
            "gap": pane.gap,
            "minWidth": pane.minPillWidth,
            "chipWidth": pane.chipWidth
        })

    function hyprAddress(tl) {
        const a = tl ? tl.address : "";
        if (!a)
            return "";
        return a.startsWith("0x") ? a : "0x" + a;
    }

    function focusWindow(tl) {
        const a = hyprAddress(tl);
        if (a !== "")
            Hyprland.dispatch("focuswindow address:" + a);
    }

    // desktop-entry + icon-theme lookups are slow-ish: do each class once
    property var iconCache: ({})

    function iconFor(cls) {
        if (cls === "")
            return Quickshell.iconPath("application-x-executable", true);
        const hit = iconCache[cls];
        if (hit !== undefined)
            return hit;
        const entry = DesktopEntries.heuristicLookup(cls);
        const name = (entry && entry.icon) ? entry.icon : cls.toLowerCase();
        const path = Quickshell.iconPath(name, "application-x-executable");
        iconCache[cls] = path;   // plain mutation on purpose: no notification needed
        return path;
    }

    // ------------------------------------------------------- empty workspace
    Item {
        visible: pane.plan.count === 0
        x: pane.spanLeft - pane.pillHeight
        y: pane.pillTop
        width: pane.spanWidth + pane.pillHeight
        height: pane.pillHeight

        PillShape {
            pillHeight: pane.pillHeight
            topWidth: pane.spanWidth
            fillColor: "transparent"
            lineColor: "#3336F8EC"
            dashed: true
        }
        Text {
            anchors.centerIn: parent
            text: "WS " + pane.workspaceId
            color: "#5536F8EC"
            font.family: pane.fontFamily
            font.pixelSize: 10
            font.bold: true
        }
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            containmentMask: QtObject {
                function contains(p: point): bool {
                    const t = p.y / pane.pillHeight;
                    return p.x >= pane.pillHeight * (1 - t) && p.x <= pane.pillHeight + pane.spanWidth - pane.pillHeight * t;
                }
            }
            onClicked: Hyprland.dispatch("workspace " + pane.workspaceId)
        }
    }

    // ------------------------------------------------------------ window pills
    Repeater {
        model: ScriptModel {
            values: pane.plan.items
            objectProp: "key"
        }

        delegate: Item {
            id: pill

            required property var modelData
            readonly property var tl: modelData.ref
            readonly property real pw: modelData.w
            readonly property bool focused: modelData.focused
            readonly property real h: pane.pillHeight
            readonly property bool hot: area.containsMouse

            // strings compare equal across refreshes, so these only re-run on a real change
            readonly property string appId: (tl && tl.wayland && tl.wayland.appId) ? tl.wayland.appId : ""
            readonly property string cls: appId !== "" ? appId : ((tl && tl.lastIpcObject && tl.lastIpcObject.class) ? tl.lastIpcObject.class : "")
            readonly property string iconSource: pane.iconFor(cls)

            // preview thumbnail lives in the rectangle inscribed in the parallelogram
            readonly property real previewH: h - 6
            readonly property real previewBoxW: pw - previewH - 4
            // Capture lifecycle: `armed` lets the capture context exist; a stream that
            // the compositor ends disarms it, and it is retried with backoff (see below).
            property int previewFailures: 0
            property bool armed: true
            onFocusedChanged: {
                previewFailures = 0;
                armed = true;
            }

            readonly property bool wantPreview: previewFailures <= 3 && pane.previewMode !== "icon" && (pane.previewMode === "all" || focused) && previewBoxW >= pane.previewMinWidth
            readonly property bool showingPreview: wantPreview && shot.hasContent
            // a square icon of side s fits the parallelogram when pw - s >= s
            readonly property real iconSize: Math.max(8, Math.min(pane.iconMax, Math.floor(pw / 2)))

            x: modelData.x - h
            y: pane.pillTop
            // displayed width eases toward the target width; the drawn shape follows it
            property real dispW: modelData.w
            width: dispW + h
            height: h

            Behavior on x  {
                NumberAnimation {
                    duration: 120
                    easing.type: Easing.OutCubic
                }
            }
            Behavior on dispW  {
                NumberAnimation {
                    duration: 120
                    easing.type: Easing.OutCubic
                }
            }

            PillShape {
                pillHeight: pill.h
                topWidth: pill.dispW
                lineWidth: pill.focused ? 1.5 : 1
                fillColor: pill.focused ? "#33FEF709" : (pill.hot ? "#557a7f8c" : pane.pillFill)
                lineColor: pill.tl && pill.tl.urgent ? pane.alertColor : (pill.focused ? pane.accentColor : (pill.hot ? pane.lineColor : "#6636F8EC"))
            }

            // ---- live preview (focused / wide pills) ----
            ScreencopyView {
                id: shot
                visible: pill.wantPreview
                anchors.centerIn: parent
                captureSource: pill.wantPreview && pill.armed && pill.tl ? pill.tl.wayland : null
                live: pane.previewInterval <= 0 && pill.wantPreview && pill.armed

                // The compositor ended the stream (e.g. a failed cross-GPU buffer).
                // Drop the dead capture context and retry later instead of poking it.
                onStopped: {
                    pill.previewFailures++;
                    pill.armed = false;
                    if (pill.previewFailures <= 3)
                        retryTimer.restart();
                }
                constraintSize.width: pill.previewBoxW
                constraintSize.height: pill.previewH
                opacity: hasContent ? 1 : 0
            }
            // One still frame per interval while a preview is wanted. The first capture
            // waits 300ms so the capture context exists (capturing earlier just warns
            // "no recording context is ready").
            Timer {
                interval: shot.hasContent ? Math.max(1, pane.previewInterval) : 300
                running: pane.previewInterval > 0 && pill.wantPreview && pill.armed
                repeat: true
                onTriggered: shot.captureFrame()
            }
            Timer {
                id: retryTimer
                interval: 2000 * Math.max(1, pill.previewFailures)
                onTriggered: pill.armed = true
            }
            Rectangle {
                visible: pill.showingPreview
                x: shot.x
                y: shot.y
                width: shot.width
                height: shot.height
                color: "transparent"
                border.width: 1
                border.color: "#5536F8EC"
            }

            // ---- app icon: centred normally, small badge on the thumbnail when previewing ----
            IconImage {
                visible: !pill.showingPreview
                anchors.centerIn: parent
                width: pill.iconSize
                height: pill.iconSize
                source: pill.iconSource
                asynchronous: true
                mipmap: true
            }
            Rectangle {
                visible: pill.showingPreview
                x: shot.x + shot.width - width + 2
                y: shot.y + shot.height - height + 2
                width: 12
                height: 12
                color: "#e01a1030"
                border.width: 1
                border.color: pane.lineColor

                IconImage {
                    anchors.centerIn: parent
                    width: 9
                    height: 9
                    source: pill.iconSource
                    asynchronous: true
                    mipmap: true
                }
            }

            MouseArea {
                id: area
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                // only the parallelogram itself is clickable (neighbours' boxes overlap)
                containmentMask: QtObject {
                    function contains(p: point): bool {
                        const t = p.y / pill.h;
                        return p.x >= pill.h * (1 - t) && p.x <= pill.h + pill.pw - pill.h * t;
                    }
                }

                onEntered: pane.pillEntered(pill, pill.tl)
                onExited: pane.pillExited(pill)
                onClicked: pane.focusWindow(pill.tl)
            }
        }
    }

    // --------------------------------------------------------- "+N" overflow chip
    Item {
        id: chip
        visible: pane.plan.hidden > 0
        x: pane.plan.chipX - pane.pillHeight
        y: pane.pillTop
        width: pane.chipWidth + pane.pillHeight
        height: pane.pillHeight

        PillShape {
            pillHeight: pane.pillHeight
            topWidth: pane.chipWidth
            fillColor: "#22f809c9"
            lineColor: pane.alertColor
        }
        Text {
            anchors.centerIn: parent
            text: "+" + pane.plan.hidden
            color: pane.alertColor
            font.family: pane.fontFamily
            font.pixelSize: 11
            font.bold: true
        }
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            containmentMask: QtObject {
                function contains(p: point): bool {
                    const t = p.y / pane.pillHeight;
                    return p.x >= pane.pillHeight * (1 - t) && p.x <= pane.pillHeight + pane.chipWidth - pane.pillHeight * t;
                }
            }
            // jump to the first window that doesn't fit in the row
            onClicked: {
                const all = pane.windowsHere();
                const shown = {};
                for (let i = 0; i < pane.plan.items.length; i++)
                    shown[pane.plan.items[i].key] = true;
                for (let j = 0; j < all.length; j++) {
                    if (!shown[all[j].key]) {
                        pane.focusWindow(all[j].ref);
                        return;
                    }
                }
            }
        }
    }
}
