import QtQuick
import QtQuick.Layouts
import Quickshell.Io

Item {
    id: root

    // Must match the 'bars = 16' setting in your cava config
    property int barCount: 6

    // Stores the latest frame of audio values (0-100)
    property var audioLevels: new Array(16).fill(0)

    Process {
        id: cavaProc
        // Using sh -c ensures the ~ path expands correctly
        command: ["sh", "-c", "cava -p ~/.config/cava/bar.conf"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                let frame = data.trim().split(";");
                let newLevels = [];
                for (let i = 0; i < root.barCount; i++) {
                    let val = parseInt(frame[i]);
                    newLevels.push(isNaN(val) ? 0 : val);
                }
                // Completely reassigning the array forces QML to update the UI bindings
                root.audioLevels = newLevels;
            }
        }
    }

    Row {
        anchors.centerIn: parent
        spacing: 4
        height: 24 // Max height of the visualizer bars

        Repeater {
            model: root.barCount
            Rectangle {
                width: 6
                // Map the 0-100 Cava value to a 2px-24px height range
                height: Math.max(2, (root.audioLevels[index] / 100) * parent.height)
                color: "#36F8EC"
                anchors.bottom: parent.bottom

                // Adds a slight smoothing effect so the bars don't jitter unnaturally
                Behavior on height {
                    NumberAnimation {
                        duration: 40
                        easing.type: Easing.OutQuad
                    }
                }
            }
        }
    }
}
