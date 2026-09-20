import QtQuick
import Quickshell

// Shared popup for every bar button: cut-corner frame, drops below `target`,
// closes when you click elsewhere. Put rows (PopupRow, PopupSlider, ...) inside it.
PopupWindow {
    id: root

    property Item target: null
    property real popupWidth: 260
    property real maxHeight: 420
    property real cut: 12          // 45° chamfer size (top-left + bottom-right)
    property real gap: -10          // distance below the bar button
    property real sideMargin: 4
    property color fillColor: "#f01a1030"
    property color lineColor: "#36F8EC"
    property double closedAt: 0

    default property alias content: body.data

    // Toggle helper. A click on the button while the popup is open first
    // dismisses it via the focus grab; don't let that same click re-open it.
    function toggle() {
        if (visible) {
            visible = false;
            return;
        }
        if (Date.now() - closedAt < 250)
            return;
        visible = true;
    }

    visible: false
    color: "transparent"
    grabFocus: true
    implicitWidth: popupWidth
    implicitHeight: Math.min(maxHeight, body.implicitHeight + 2 * cut + 2)
    anchor.item: target
    anchor.edges: Edges.Bottom
    anchor.gravity: Edges.Bottom
    anchor.adjustment: PopupAdjustment.Slide
    anchor.margins.bottom: gap

    onVisibleChanged: {
        if (!visible)
            closedAt = Date.now();
    }

    CutFrame {
        anchors.fill: parent
        cut: root.cut
        fillColor: root.fillColor
        lineColor: root.lineColor
        focus: true
        Keys.onEscapePressed: root.visible = false

        Flickable {
            id: flick
            anchors.fill: parent
            anchors.leftMargin: root.sideMargin
            anchors.rightMargin: root.sideMargin
            // rows start below the top-left cut and end above the bottom-right cut
            anchors.topMargin: root.cut
            anchors.bottomMargin: root.cut
            contentWidth: width
            contentHeight: body.implicitHeight
            clip: true
            boundsBehavior: Flickable.StopAtBounds
            interactive: contentHeight > height

            Column {
                id: body
                width: flick.width
                spacing: 0
            }
        }
    }
}
