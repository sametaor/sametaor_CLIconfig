import QtQuick
import QtQuick.Layouts

Item {
    id: root

    // Explicit sizing ensures the layout doesn't collapse
    implicitWidth: layout.implicitWidth
    implicitHeight: layout.implicitHeight

    property string currentTime: ""
    property string currentDate: ""

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
        onTriggered: updateTime()
    }

    RowLayout {
        id: layout
        anchors.fill: parent
        // A wider gap ensures the background cyan slash doesn't touch the text
        spacing: 30

        Text {
            text: root.currentTime
            color: "white"
            font.family: "Iosevka SciFi"
            font.pixelSize: 20
            font.letterSpacing: 1 // Adds a slightly stretched, digital look
            Layout.alignment: Qt.AlignVCenter
        }

        Text {
            text: root.currentDate
            color: "white"
            font.family: "Iosevka SciFi"
            font.pixelSize: 16
            Layout.alignment: Qt.AlignVCenter
        }
    }
}
