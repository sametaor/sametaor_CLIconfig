import QtQuick
import Quickshell.Hyprland

// The 10-box workspace indicator.
//   click a box  -> switch straight to that workspace
//   scroll       -> previous / next workspace (wheel up = previous, down = next)
// Scrolling stays inside the ten boxes you can see (the current "bank" of 10);
// set `wrap: true` to loop from the last box back to the first.
Item {
    id: root
    width: 280 // Widen container to fit long rectangles
    height: 60

    // ---- behaviour ----
    property bool wrap: false             // scrolling past the last/first box loops around
    property bool invertScroll: false     // flip scroll direction
    property real wheelStep: 120          // wheel delta per workspace step (one notch = 120)

    // ---- geometry ----
    property real cellW: 31
    property real cellH: 10
    property real cellGap: 4

    property int activeId: Hyprland.focusedMonitor && Hyprland.focusedMonitor.activeWorkspace ? Hyprland.focusedMonitor.activeWorkspace.id : 1
    property int bank: Math.floor(Math.max(0, activeId - 1) / 10)
    property int localWs: ((Math.max(1, activeId) - 1) % 10) + 1

    property int hoverIndex: -1           // box under the pointer, -1 = none

    // Workspace switches are confirmed by an event a moment after we dispatch, so a
    // quick flick of the wheel would keep reading the OLD workspace and step from it
    // repeatedly. `pendingTarget` remembers where we're already heading until the
    // active workspace catches up.
    property int pendingTarget: -1
    property real wheelAcc: 0

    onActiveIdChanged: pendingTarget = -1

    // speaks whichever dispatch syntax the running Hyprland config expects (Lua or classic)
    HyprDispatch {
        id: hypr
    }

    Timer {
        id: pendingReset
        interval: 400
        onTriggered: root.pendingTarget = -1
    }

    function goTo(n) {
        if (n === root.activeId && root.pendingTarget === -1)
            return;
        if (n === root.pendingTarget)
            return;
        root.pendingTarget = n;
        pendingReset.restart();
        hypr.focusWorkspace(n);
    }

    function stepBy(dir) {
        const lo = root.bank * 10 + 1;
        const hi = lo + 9;
        const cur = root.pendingTarget !== -1 ? root.pendingTarget : root.activeId;
        let n = cur + dir;
        if (n > hi)
            n = root.wrap ? lo : hi;
        else if (n < lo)
            n = root.wrap ? hi : lo;
        if (n !== cur)
            root.goTo(n);
    }

    function handleWheel(deltaY, deltaX) {
        // mice send 120 per notch; touchpads send many small deltas, so accumulate
        root.wheelAcc += (deltaY !== 0 ? deltaY : deltaX);
        while (Math.abs(root.wheelAcc) >= root.wheelStep) {
            const up = root.wheelAcc > 0;
            root.wheelAcc += up ? -root.wheelStep : root.wheelStep;
            // wheel up = previous workspace, wheel down = next
            root.stepBy((up ? -1 : 1) * (root.invertScroll ? -1 : 1));
        }
    }

    Row {
        id: strip
        anchors.verticalCenter: parent.verticalCenter
        spacing: root.cellGap
        Repeater {
            model: 10
            Rectangle {
                property int targetWs: (root.bank * 10) + (index + 1)
                property bool isActive: (activeId === targetWs)
                property bool hovered: root.hoverIndex === index
                width: root.cellW
                height: root.cellH
                color: "transparent"
                border.color: hovered && !isActive ? "#9DFBF5" : "#36F8EC"
                border.width: isActive || hovered ? 1.6 : 1.0

                // Filled inner indicator: yellow for the active workspace, a faint cyan
                // wash while hovering another one
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 4
                    color: parent.isActive ? "#FEF709" : (parent.hovered ? "#5536F8EC" : "transparent")
                }
            }
        }
    }

    // One pointer area over the whole strip (a little taller than the 10px boxes so
    // they're easy to hit). It also catches the wheel anywhere over the strip.
    MouseArea {
        anchors.fill: strip
        anchors.topMargin: -4
        anchors.bottomMargin: -4
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        function indexAt(mx) {
            const i = Math.floor(mx / (root.cellW + root.cellGap));
            return Math.max(0, Math.min(9, i));
        }

        // Hover highlight. A HoverHandler reports the real pointer position even on the
        // very first event when the pointer enters (MouseArea.mouseX is stale then).
        HoverHandler {
            onPointChanged: root.hoverIndex = parent.indexAt(point.position.x)
            onHoveredChanged: {
                if (!hovered)
                    root.hoverIndex = -1;
            }
        }
        onClicked: mouse => root.goTo(root.bank * 10 + indexAt(mouse.x) + 1)
        onWheel: wheel => {
            root.handleWheel(wheel.angleDelta.y, wheel.angleDelta.x);
            wheel.accepted = true;
        }
    }
}
