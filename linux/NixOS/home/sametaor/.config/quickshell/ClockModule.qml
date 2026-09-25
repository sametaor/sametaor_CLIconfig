import QtQuick
import QtQuick.Layouts

// Time + date box. Click it to open DateFlyout (TO-DO list + MONTH calendar).
Item {
    id: root

    // Explicit sizing ensures the layout doesn't collapse. width/height must be
    // bound too, not just implicitWidth/Height - a plain Item doesn't do that on
    // its own, so without this the item's real geometry stays 0x0 even though its
    // content visually overflows past it (this bit DateFlyout's popup anchoring:
    // it anchored relative to this item's true - zero - width).
    implicitWidth: layout.implicitWidth
    implicitHeight: layout.implicitHeight
    width: implicitWidth
    height: implicitHeight

    property string currentTime: ""
    property string currentDate: ""
    readonly property bool open: flyout.visible

    function updateTime() {
        let d = new Date();
        currentTime = d.toLocaleTimeString(Qt.locale(), "HH:mm");
        currentDate = d.toLocaleDateString(Qt.locale(), "ddd, dd.MM.yyyy");
    }

    // Fetches the time instantly on launch to prevent placeholder flashing
    Component.onCompleted: updateTime()

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: root.updateTime()
    }

    RowLayout {
        id: layout
        anchors.fill: parent
        // A wider gap ensures the background cyan slash doesn't touch the text
        spacing: 30

        Text {
            text: root.currentTime
            color: root.open ? "#FEF709" : (area.containsMouse ? "#9DFBF5" : "white")
            font.family: "Iosevka SciFi"
            font.pixelSize: 20
            font.letterSpacing: 1 // Adds a slightly stretched, digital look
            Layout.alignment: Qt.AlignVCenter
        }

        Text {
            text: root.currentDate
            color: root.open ? "#FEF709" : (area.containsMouse ? "#9DFBF5" : "white")
            font.family: "Iosevka SciFi"
            font.pixelSize: 16
            Layout.alignment: Qt.AlignVCenter
        }
    }

    MouseArea {
        id: area
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: flyout.toggle()
    }

    DateFlyout {
        id: flyout
        target: root
    }
}
