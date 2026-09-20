import QtQuick
import Quickshell

// Control-panel button: the LAST box in the bar. It touches the end of the
// bar, so only its left side is slanted.
// Clicking toggles `panelOpen` and the placeholder popup below. Build the real
// control panel by replacing the placeholder rows inside BarPopup (or by
// reacting to `toggled(open)` and showing your own window).
BarBox {
    id: box

    slantRight: false

    readonly property bool panelOpen: popup.visible
    signal toggled(bool open)

    active: popup.visible
    onClicked: mouse => {
        if (mouse.button === Qt.LeftButton)
            popup.toggle();
    }

    BarIcon {
        kind: "control"
        color: box.accent
    }

    BarPopup {
        id: popup
        target: box
        popupWidth: 300
        onVisibleChanged: box.toggled(visible)

        // ---- placeholder content: replace with the real control panel ----
        PopupRow {
            text: "Control panel"
            clickable: false
            dim: true
        }
        PopupRow {
            separator: true
        }
        PopupRow {
            text: "Nothing here yet"
            clickable: false
            dim: true
        }
    }
}
