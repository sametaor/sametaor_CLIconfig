import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

// Volume button + menu via Quickshell's PipeWire service.
//   left click  : open menu       middle click : mute / unmute
//   scroll      : volume +/- 5%
BarBox {
    id: box

    property real volumeStep: 0.05

    readonly property var sink: Pipewire.defaultAudioSink
    readonly property var sinks: Pipewire.nodes.values.filter(n => n.audio && n.isSink && !n.isStream)
    readonly property bool ready: sink !== null && sink !== undefined && sink.audio !== null && sink.audio !== undefined
    readonly property real volume: ready ? sink.audio.volume : 0
    readonly property bool muted: ready ? sink.audio.muted : false
    readonly property int shownLevel: muted ? 0 : (volume <= 0.001 ? 0 : (volume < 0.5 ? 1 : 2))

    active: popup.visible

    // audio properties are only valid on tracked (bound) nodes
    PwObjectTracker {
        objects: box.sinks
    }

    function setVolume(v) {
        if (!ready)
            return;
        if (sink.audio.muted && v > 0)
            sink.audio.muted = false;
        sink.audio.volume = Math.max(0, Math.min(1, v));
    }

    function toggleMute() {
        if (ready)
            sink.audio.muted = !sink.audio.muted;
    }

    function nameOf(node) {
        return node ? (node.description || node.nickname || node.name || "") : "";
    }

    onClicked: mouse => {
        if (mouse.button === Qt.MiddleButton)
            toggleMute();
        else if (mouse.button === Qt.LeftButton)
            popup.toggle();
    }
    onWheelMoved: wheel => {
        if (wheel.angleDelta.y > 0)
            setVolume(volume + volumeStep);
        else if (wheel.angleDelta.y < 0)
            setVolume(volume - volumeStep);
    }

    BarIcon {
        kind: "sound"
        color: box.accent
        level: box.shownLevel
        flag: box.muted
    }

    // fixed width so the box doesn't jitter between "5%" and "100%"
    TextMetrics {
        id: widest
        text: "100%"
        font.family: box.fontFamily
        font.pixelSize: 10
        font.bold: true
    }
    Text {
        width: widest.width
        height: box.contentHeight
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
        text: box.muted ? "MUTE" : Math.round(box.volume * 100) + "%"
        color: box.accent
        font.family: box.fontFamily
        font.pixelSize: 10
        font.bold: true
    }

    BarPopup {
        id: popup
        target: box
        popupWidth: 300

        PopupRow {
            text: "Output"
            detail: box.nameOf(box.sink)
            clickable: false
            dim: true
        }
        PopupSlider {
            width: parent.width
            value: box.volume
            active: !box.muted
            onMoved: v => box.setVolume(v)
        }
        PopupRow {
            text: box.muted ? "Unmute" : "Mute"
            accent: true
            onClicked: box.toggleMute()
        }
        PopupRow {
            separator: true
        }
        PopupRow {
            visible: box.sinks.length === 0
            clickable: false
            dim: true
            text: "No output devices"
        }
        Repeater {
            model: box.sinks
            delegate: PopupRow {
                required property var modelData
                text: box.nameOf(modelData)
                marked: modelData === box.sink
                onClicked: Pipewire.preferredDefaultAudioSink = modelData
            }
        }
    }
}
