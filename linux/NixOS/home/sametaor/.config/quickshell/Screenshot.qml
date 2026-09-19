import QtQuick
import Quickshell.Io

Item {
    id: root
    width: 38
    height: 27

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onClicked: shotProcess.running = true

        // Sci-fi hover/active highlight fill
        Rectangle {
            anchors.fill: parent
            color: mouseArea.containsMouse ? "#36F8EC" : "transparent"
            opacity: mouseArea.containsMouse ? 0.18 : 0.0
            Behavior on opacity {
                NumberAnimation {
                    duration: 150
                }
            }
        }

        // Cybernetic border outline accent on hover
        Rectangle {
            anchors.fill: parent
            color: "transparent"
            border.color: "#36F8EC"
            border.width: 1
            opacity: mouseArea.containsMouse ? 0.8 : 0.0
            Behavior on opacity {
                NumberAnimation {
                    duration: 150
                }
            }
        }

        Text {
            anchors.centerIn: parent
            text: mouseArea.containsMouse ? "󰞢" : "󰞤"
            color: mouseArea.containsMouse ? "#FEF709" : "#36F8EC"
            font.family: "Iosevka SciFi"
            font.pixelSize: 28
        }
    }

    Process {
        id: shotProcess
        // High quality uncompressed regional capture via hyprshot
        command: ["hyprshot", "-m", "region", "--freeze"]
        running: false
    }
}
