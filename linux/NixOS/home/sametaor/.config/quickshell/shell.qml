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
        }

        // 3. RIGHT SIDE: button boxes at the very end of the bar, tray to their left.
        //    ControlStrip = clipboard, wifi, sound, battery (laptops only), control panel.
        ControlStrip {
            id: controls
            anchors.right: parent.right
            anchors.rightMargin: 18
            anchors.top: parent.top
        }

        // The tray's slanted right edge nests against the strip's first box, keeping
        // the same `gap` as between the boxes. It may grow leftward only as far as
        // the bar's y=30 ledge starts (x=1458 in CyberBar.qml, +12 of breathing room).
        TrayModule {
            id: tray
            anchors.right: controls.left
            anchors.rightMargin: controls.gap - controls.slant
            anchors.top: parent.top
            maxWidth: Math.max(60, controls.x + controls.slant - controls.gap - 1470)
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
                anchors.verticalCenterOffset: -15
            }
        }
        Item {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            // Align x coordinates with your dual trapezoidal frames on the left/middle bar zone
            x: 412
            width: 260

            Overview {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -6
                anchors.horizontalCenterOffset: 16
            }
        }
        Item {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            x: 1294 // Adjust to fit safely next to Overview/Cava
            width: 140

            SysMon {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -8
            }
        }
    }
}
