import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

RowLayout {
    id: root
    spacing: 10

    // Hexagon Logo
    Text {
        text: "󰛡"
        color: "#ffcc00"
        font.pixelSize: 32
        Layout.alignment: Qt.AlignVCenter
    }

    ColumnLayout {
        spacing: 0
        Layout.alignment: Qt.AlignVCenter
        // Limits the width so window titles don't bleed into the angled geometric cuts
        Layout.maximumWidth: 280

        Text {
            text: Hyprland.focusedMonitor ? "Workspace " + Hyprland.focusedMonitor.activeWorkspace.id : "Workspace 0"
            color: "white"
            font.bold: true
            font.family: "Iosevka SciFi"
            font.pixelSize: 14
        }
        Text {
            // Actively tracks the focused window title
            text: Hyprland.activeToplevel ? Hyprland.activeToplevel.title : "System Idle"
            color: "#7a7f8c"
            font.family: "Iosevka SciFi"
            font.pixelSize: 12
            // These two properties must be paired for QML to truncate the text properly
            Layout.fillWidth: true
            elide: Text.ElideRight
        }
    }
}
