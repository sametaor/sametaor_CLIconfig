import QtQuick

// 0..1 slider with a boxy cyber look. Emits moved(value) while dragging.
Item {
    id: root

    property real value: 0
    property color lineColor: "#36F8EC"
    property color fillColor: "#8036F8EC"
    property color accentColor: "#FEF709"
    property color textColor: "#EFEEFF"
    property string fontFamily: "Iosevka SciFi"
    property bool active: true     // false = dimmed (e.g. muted)

    signal moved(real value)

    height: 28

    Rectangle {
        id: track
        x: 10
        anchors.verticalCenter: parent.verticalCenter
        width: root.width - 10 - 46
        height: 8
        color: "transparent"
        border.width: 1
        border.color: root.lineColor
        opacity: root.active ? 1 : 0.45

        Rectangle {
            x: 1
            y: 1
            height: parent.height - 2
            width: Math.max(0, (parent.width - 2) * Math.max(0, Math.min(1, root.value)))
            color: root.fillColor
        }
    }

    Text {
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.verticalCenter: parent.verticalCenter
        text: Math.round(root.value * 100) + "%"
        color: root.active ? root.accentColor : root.textColor
        font.family: root.fontFamily
        font.pixelSize: 12
    }

    MouseArea {
        anchors.fill: parent
        preventStealing: true
        cursorShape: Qt.PointingHandCursor
        function update(mx) {
            root.moved(Math.max(0, Math.min(1, (mx - track.x) / track.width)));
        }
        onPressed: mouse => update(mouse.x)
        onPositionChanged: mouse => {
            if (pressed)
                update(mouse.x);
        }
    }
}
