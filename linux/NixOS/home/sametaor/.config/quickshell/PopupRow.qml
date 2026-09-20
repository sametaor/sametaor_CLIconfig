import QtQuick

// One row inside a BarPopup: label, optional right-aligned detail, optional
// marker (● current item). Set `separator: true` for a divider line instead.
Rectangle {
    id: row

    property string text: ""
    property string detail: ""
    property bool marked: false      // draws a small square marker (current/selected)
    property bool clickable: true
    property bool dim: false         // greyed-out text (headers, info rows)
    property bool accent: false      // yellow text (actions)
    property bool separator: false
    property real rowHeight: 24

    property color lineColor: "#36F8EC"
    property color hoverFill: "#3300ffcc"
    property color textColor: "#EFEEFF"
    property color dimColor: "#8a7fa8"
    property color accentColor: "#FEF709"
    property string fontFamily: "Iosevka SciFi"

    signal clicked(var mouse)

    width: parent ? parent.width : 200
    height: separator ? 7 : rowHeight
    color: (!separator && clickable && area.containsMouse) ? hoverFill : "transparent"

    Rectangle {
        visible: row.separator
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        height: 1
        color: row.lineColor
        opacity: 0.35
    }

    Rectangle {
        visible: !row.separator && row.marked
        x: 6
        anchors.verticalCenter: parent.verticalCenter
        width: 5
        height: 5
        color: row.accentColor
    }

    Text {
        visible: !row.separator
        anchors.left: parent.left
        anchors.leftMargin: 16
        anchors.right: detailText.visible ? detailText.left : parent.right
        anchors.rightMargin: 8
        anchors.verticalCenter: parent.verticalCenter
        text: row.text
        color: row.accent ? row.accentColor : (row.dim ? row.dimColor : row.textColor)
        font.family: row.fontFamily
        font.pixelSize: 12
        elide: Text.ElideRight
    }

    Text {
        id: detailText
        visible: !row.separator && row.detail !== ""
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.verticalCenter: parent.verticalCenter
        text: row.detail
        color: row.dimColor
        font.family: row.fontFamily
        font.pixelSize: 11
    }

    MouseArea {
        id: area
        anchors.fill: parent
        enabled: !row.separator && row.clickable
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
        cursorShape: Qt.PointingHandCursor
        onClicked: mouse => row.clicked(mouse)
    }
}
