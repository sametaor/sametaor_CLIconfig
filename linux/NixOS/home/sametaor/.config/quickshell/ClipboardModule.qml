import QtQuick
import Quickshell
import Quickshell.Io

// Clipboard history button. Quickshell has no clipboard service, so this uses
// cliphist + wl-clipboard (same approach DankMaterialShell's clipboard history uses).
//   needs:  cliphist  wl-clipboard   (nixpkgs: cliphist, wl-clipboard)
BarBox {
    id: box

    // Start the wl-paste watchers that feed cliphist. Set to false if you
    // already run them yourself (exec-once in Hyprland).
    property bool manageWatcher: true
    property int maxEntries: 40
    property var entries: []           // [{ id, label }]
    property bool listFailed: false

    active: popup.visible
    onClicked: mouse => {
        if (mouse.button === Qt.LeftButton)
            popup.toggle();
    }

    function refresh() {
        lister.running = true;
    }

    function parse(text) {
        const out = [];
        const lines = text.split("\n");
        for (let i = 0; i < lines.length && out.length < box.maxEntries; i++) {
            const line = lines[i];
            const tab = line.indexOf("\t");
            if (tab <= 0)
                continue;
            let label = line.substring(tab + 1).replace(/\s+/g, " ").trim();
            if (label.startsWith("[[ binary data")) {
                label = "[image] " + label.replace("[[ binary data", "").replace("]]", "").trim();
            }
            out.push({
                    "id": line.substring(0, tab),
                    "label": label
                });
        }
        box.entries = out;
    }

    function paste(id) {
        Quickshell.execDetached(["sh", "-c", "cliphist decode \"$1\" | wl-copy", "_", id]);
        popup.visible = false;
    }

    function clearAll() {
        Quickshell.execDetached(["cliphist", "wipe"]);
        box.entries = [];
    }

    BarIcon {
        kind: "clipboard"
        color: box.accent
    }

    Process {
        id: lister
        command: ["cliphist", "list"]
        stdout: StdioCollector {
            onStreamFinished: {
                box.listFailed = false;
                box.parse(text);
            }
        }
        onExited: (code, status) => {
            if (code !== 0)
                box.listFailed = true;
        }
    }

    Process {
        command: ["wl-paste", "--type", "text", "--watch", "cliphist", "store"]
        running: box.manageWatcher
    }
    Process {
        command: ["wl-paste", "--type", "image", "--watch", "cliphist", "store"]
        running: box.manageWatcher
    }

    BarPopup {
        id: popup
        target: box
        popupWidth: 340
        onVisibleChanged: {
            if (visible)
                box.refresh();
        }

        PopupRow {
            text: "Clipboard history"
            clickable: false
            dim: true
        }
        PopupRow {
            separator: true
        }
        PopupRow {
            visible: box.entries.length === 0
            clickable: false
            dim: true
            text: box.listFailed ? "cliphist not available" : "Nothing copied yet"
        }
        Repeater {
            model: box.entries
            delegate: PopupRow {
                required property var modelData
                text: modelData.label
                onClicked: box.paste(modelData.id)
            }
        }
        PopupRow {
            separator: true
            visible: box.entries.length > 0
        }
        PopupRow {
            visible: box.entries.length > 0
            text: "Clear history"
            accent: true
            onClicked: box.clearAll()
        }
    }
}
