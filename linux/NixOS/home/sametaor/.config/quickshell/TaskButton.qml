import QtQuick

// One task row: chamfered top-left + bottom-right, like the media buttons.
// Selecting it plugs the bottom-right chamfer solid, as an indicator that its
// detail card (TaskDetailFlyout) is open and anchored to that corner.
// A small "x" appears on hover to delete the task.
Item {
    id: root

    property string label: ""
    property bool selected: false
    property real cut: 9

    property color lineColor: "#36F8EC"
    property color hoverFill: "#3300ffcc"
    property color fillColor: "#1a1030"
    property color accentColor: "#FEF709"
    property color alertColor: "#f809c9"
    property string fontFamily: "Iosevka SciFi"

    signal clicked
    signal deleteRequested

    implicitHeight: 34
    readonly property bool hot: area.containsMouse

    ChamferBox {
        anchors.fill: parent
        cutTL: root.cut
        cutBR: root.cut
        lineColor: root.selected ? root.accentColor : (root.hot ? "#9DFBF5" : root.lineColor)
        lineWidth: root.selected ? 1.5 : 1
        fillColor: root.hot || root.selected ? root.hoverFill : root.fillColor
        plugCorners: root.selected ? ["br"] : []
        plugColor: root.accentColor
    }

    MouseArea {
        id: area
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        containmentMask: QtObject {
            function contains(p: point): bool {
                if (p.x < 0 || p.y < 0 || p.x > root.width || p.y > root.height)
                    return false;
                if (p.x + p.y < root.cut)
                    return false;
                if ((root.width - p.x) + (root.height - p.y) < root.cut)
                    return false;
                return true;
            }
        }
        onClicked: root.clicked()
    }

    Text {
        anchors.left: parent.left
        anchors.leftMargin: root.cut + 6
        anchors.right: del.left
        anchors.rightMargin: 4
        anchors.verticalCenter: parent.verticalCenter
        text: root.label
        color: root.selected ? root.accentColor : "#EFEEFF"
        font.family: root.fontFamily
        font.pixelSize: 14
        elide: Text.ElideRight
    }

    Text {
        id: del
        visible: root.hot
        anchors.right: parent.right
        anchors.rightMargin: root.cut + 4
        anchors.verticalCenter: parent.verticalCenter
        text: "\u00D7"
        color: delArea.containsMouse ? root.alertColor : "#8a7fa8"
        font.family: root.fontFamily
        font.pixelSize: 16
        font.bold: true

        MouseArea {
            id: delArea
            anchors.fill: parent
            anchors.margins: -6
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: root.deleteRequested()
        }
    }
}
