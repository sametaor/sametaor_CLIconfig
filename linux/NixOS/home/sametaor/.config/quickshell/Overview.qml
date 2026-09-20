import QtQuick
import Quickshell
import Quickshell.Hyprland

// Workspace overview for the two trapezium frames in CyberBar.qml:
// the current workspace in the left frame, the next one in the right frame.
// This item is BAR-sized and must sit at the bar's (0,0): all geometry below is
// in the same coordinates CyberBar.qml draws its frames in.
//   Left frame  (412,6) (390,28) (400,39) (516,39) (550,6)
//   Right frame (558,6) (524,39) (663,39) (674,28) (674,6)
// Both frames' slanted edges run at 45° ("/"), so pills are 45° parallelograms
// tiled parallel to them. spanLeft/spanWidth were derived so every pill stays
// >= 2px inside its frame, including the corner chamfers (left frame: the notch
// at bottom-left; right frame: the cut at bottom-right).
Item {
    id: root

    width: 700
    height: 60

    // "icon"    - app icons only
    // "focused" - live thumbnail for the focused window (icons elsewhere)
    // "all"     - thumbnails on every pill wide enough (heavier: one capture each)
    property string previewMode: "focused"

    // 0 = live video; otherwise refresh the thumbnail every N ms (lighter)
    property int previewInterval: 2000

    readonly property int activeWs: (Hyprland.focusedMonitor && Hyprland.focusedMonitor.activeWorkspace) ? Hyprland.focusedMonitor.activeWorkspace.id : 1

    OverviewPane {
        workspaceId: root.activeWs
        spanLeft: 428
        spanWidth: 115
        previewMode: root.previewMode
        previewInterval: root.previewInterval
        onPillEntered: (pill, tl) => root.hoverStart(pill, tl)
        onPillExited: pill => root.hoverEnd(pill)
    }

    OverviewPane {
        workspaceId: root.activeWs + 1
        spanLeft: 558
        spanWidth: 113
        previewMode: root.previewMode
        previewInterval: root.previewInterval
        onPillEntered: (pill, tl) => root.hoverStart(pill, tl)
        onPillExited: pill => root.hoverEnd(pill)
    }

    // ------------------------------------------------------------- tooltip
    property var hoverPill: null
    property var hoverTl: null

    function hoverStart(pill, tl) {
        hoverPill = pill;
        hoverTl = tl;
        tipTimer.restart();
    }

    function hoverEnd(pill) {
        if (hoverPill !== pill)
            return;
        hoverPill = null;
        hoverTl = null;
        tipTimer.stop();
        tip.visible = false;
    }

    function tipTitle() {
        if (!hoverTl)
            return "";
        const t = hoverTl.title || "";
        return t.length > 46 ? t.substring(0, 45) + "…" : t;
    }

    function tipClass() {
        if (!hoverTl)
            return "";
        if (hoverTl.wayland && hoverTl.wayland.appId)
            return hoverTl.wayland.appId;
        return (hoverTl.lastIpcObject && hoverTl.lastIpcObject.class) ? hoverTl.lastIpcObject.class : "";
    }

    Timer {
        id: tipTimer
        interval: 400
        onTriggered: {
            if (root.hoverPill) {
                tip.anchor.item = root.hoverPill;
                tip.visible = true;
            }
        }
    }

    PopupWindow {
        id: tip
        visible: false
        color: "transparent"
        implicitWidth: tipCol.implicitWidth + 24
        implicitHeight: tipCol.implicitHeight + 12
        anchor.edges: Edges.Bottom
        anchor.gravity: Edges.Bottom
        anchor.adjustment: PopupAdjustment.Slide
        anchor.margins.bottom: 14   // clear the bar's lower border

        CutFrame {
            anchors.fill: parent
            cut: 8

            Column {
                id: tipCol
                anchors.centerIn: parent
                spacing: 1

                Text {
                    text: root.tipTitle()
                    color: "#EFEEFF"
                    font.family: "Iosevka SciFi"
                    font.pixelSize: 12
                }
                Text {
                    visible: text !== ""
                    text: root.tipClass()
                    color: "#8a7fa8"
                    font.family: "Iosevka SciFi"
                    font.pixelSize: 11
                }
            }
        }
    }
}
