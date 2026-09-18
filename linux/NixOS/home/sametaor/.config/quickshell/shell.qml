import Quickshell
import QtQuick
import QtQuick.Layouts

ShellRoot {
    PanelWindow {
        anchors {
            top: true
            left: true
            right: true
        }
        implicitHeight: 60
        color: "transparent"

        CyberBar {
            id: barContainer
            anchors.fill: parent

            // 1. LEFT SIDE WIDGETS
            RowLayout {
                height: 30
                anchors.left: parent.left
                anchors.leftMargin: 15
                spacing: 10
            }
            HyprModule {
                anchors.left: parent.left
                anchors.leftMargin: 25
                // Perfectly centers the logo and two lines of text inside the 60px height
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -11
            }
            Workspace {
                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: +20
            }
            // 3. RIGHT SIDE WIDGETS
            RowLayout {
                height: 33
                anchors.right: parent.right
                anchors.rightMargin: 15
                spacing: 15
                Text {
                    text: "⬡ ⬡ ⬡"
                    color: "white"
                    font.pixelSize: 18
                }
            }
        }
        MediaModule {
            id: mediaTriggerBox
            height: 45
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -145
            anchors.verticalCenter: parent.verticalCenter
            // This formula pushes it down into the narrow cutout
            anchors.verticalCenterOffset: -5

            // Keeps your existing click-to-open logic intact
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: mediaPopup.visible = !mediaPopup.visible
            }
        }
        Item {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            // Map the exact geometric position calculated in CyberBar
            x: 935

            Cava {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -10
            }
        }
        Item {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            // Mapped to the precise geometric offset calculated in CyberBar.qml
            x: 1125
            width: barContainer.timeW

            ClockModule {
                anchors.centerIn: parent
                // Pushes the text perfectly into the vertical center of the cut frame
                anchors.verticalCenterOffset: -6
            }
        }
        Item {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            // Align x coordinate with your empty cyan-framed target box
            x: 633
            width: 140

            Screenshot {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -16
            }
        }
    }
}
