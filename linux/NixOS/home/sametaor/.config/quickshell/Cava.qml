import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Services.Mpris

Item {
    id: root
    implicitWidth: 56
    implicitHeight: 24

    // Must match the 'bars = 16' setting in your cava config
    property int barCount: 6

    // Stores the latest frame of audio values (0-100)
    property var audioLevels: new Array(16).fill(0)

    // Hybrid check: Case-insensitive MPRIS check, with audio-level fallback for unlisted players
    property bool isPlaying: {
        let players = Mpris.players;
        if (players && players.length > 0) {
            for (let i = 0; i < players.length; i++) {
                let st = (players[i].playbackStatus || "").toString().toLowerCase();
                if (st === "playing")
                    return true;
            }
            return false;
        }
        // Fallback: if no MPRIS service sees the player, trust raw audio signal
        for (let i = 0; i < root.barCount; i++) {
            if (root.audioLevels[i] > 3)
                return true;
        }
        return false;
    }

    // Trigger idle/retro mode ONLY when explicitly not playing
    property bool isIdle: !isPlaying

    Process {
        id: cavaProc
        command: ["sh", "-c", "cava -p ~/.config/quickshell/bar.conf"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                let frame = data.trim().split(";");
                let newLevels = [];
                for (let i = 0; i < root.barCount; i++) {
                    let val = parseInt(frame[i]);
                    newLevels.push(isNaN(val) ? 0 : val);
                }
                root.audioLevels = newLevels;
            }
        }
    }

    // Retro car radio demo state machine
    property real demoTime: 0
    property int demoMode: 0

    Timer {
        interval: 35 // ~28fps VFD display refresh
        running: root.isIdle
        repeat: true
        onTriggered: {
            root.demoTime += 0.08;
            root.demoMode = Math.floor(root.demoTime / 4.2) % 4;
        }
    }

    // Visualizer Bars (Active audio OR Retro car-radio demo mode)
    Row {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 3
        spacing: 4
        height: 24

        Repeater {
            model: root.barCount
            Rectangle {
                width: 6
                readonly property real targetHeight: {
                    if (!root.isIdle) {
                        return Math.max(2, (root.audioLevels[index] / 100) * parent.height);
                    } else {
                        let t = root.demoTime;
                        let i = index;
                        let h = 2;
                        switch (root.demoMode) {
                        case 0: // Classic spectrum wave sweep
                            h = 4 + 16 * Math.abs(Math.sin(t * 2.2 + i * 0.7));
                            break;
                        case 1: // Symmetric VFD center-out ladder test
                            let dist = Math.abs(i - (root.barCount - 1) / 2);
                            h = 4 + 18 * Math.max(0, Math.cos(t * 2.5 - dist * 0.6));
                            break;
                        case 2: // Diagnostic peak-chase blocks
                            let step = Math.floor(t * 3) % (root.barCount * 2);
                            let active = (i === step || i === (root.barCount - 1 - (step % root.barCount)));
                            h = active ? 22 : 4;
                            break;
                        case 3: // Retro dual-peak bounce pulse
                            h = 6 + 15 * Math.abs(Math.sin(t * 3.0 + i * 0.9)) * (0.7 + 0.3 * Math.cos(t * 6));
                            break;
                        }
                        return Math.max(2, h);
                    }
                }
                height: targetHeight
                color: root.isIdle ? "#F809C9" : "#FEF709"
                opacity: root.isIdle ? 1.0 : 1.0
                anchors.bottom: parent.bottom

                Behavior on height {
                    NumberAnimation {
                        duration: root.isIdle ? 50 : 40
                        easing.type: Easing.OutQuad
                    }
                }
            }
        }
    }
}
