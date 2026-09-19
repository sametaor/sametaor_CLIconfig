import QtQuick
import Quickshell.Io

Item {
    id: root

    // Explicitly define the physical size so QML never collapses it
    width: 150
    height: 24

    property string trackInfo: "-"

    Process {
        id: playerProc
        command: ["playerctl", "-F", "metadata", "--format", "{{ title }} - {{ artist }}"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                let trimmed = data.trim();
                root.trackInfo = trimmed.length > 0 ? trimmed : "-";
            }
        }
    }

    Item {
        anchors.fill: parent
        clip: true

        Text {
            id: scrollingText
            text: root.trackInfo
            color: root.trackInfo === "-" ? "#631B87" : "#36F8EC"
            font.family: "Iosevka SciFi"
            font.pixelSize: 16
            anchors.verticalCenter: parent.verticalCenter

            // Explicitly lock the starting X coordinate
            x: 0

            // Trigger the animation natively when the text updates
            onTextChanged: {
                x = 0; // Snap back to start when the song changes
                if (implicitWidth > parent.width) {
                    marqueeAnim.restart();
                } else {
                    marqueeAnim.stop();
                }
            }
            SequentialAnimation {
                id: marqueeAnim
                loops: Animation.Infinite

                // 1. Pause at the beginning
                PauseAnimation {
                    duration: 2000
                }

                // 2. Scroll to the left
                NumberAnimation {
                    target: scrollingText
                    property: "x"
                    from: 0
                    to: Math.min(0, scrollingText.parent.width - scrollingText.implicitWidth - 20)
                    duration: Math.max(1000, (scrollingText.implicitWidth - scrollingText.parent.width) * 40)
                }

                // 3. Pause at the end
                PauseAnimation {
                    duration: 2000
                }

                // 4. Smoothly scroll back to the right (original position)
                NumberAnimation {
                    target: scrollingText
                    property: "x"
                    to: 0
                    // Uses the exact same duration formula for a consistent scroll speed
                    duration: Math.max(1000, (scrollingText.implicitWidth - scrollingText.parent.width) * 40)
                    easing.type: Easing.InOutQuad // Adds a slight deceleration as it reaches home
                }
            }
        }
    }
}
