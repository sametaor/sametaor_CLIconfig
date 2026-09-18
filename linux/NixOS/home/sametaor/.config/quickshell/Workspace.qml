import QtQuick
import Quickshell.Hyprland

Item {
    id: root
    width: 280 // Widen container to fit long rectangles
    height: 60

    property int activeId: Hyprland.focusedMonitor && Hyprland.focusedMonitor.activeWorkspace ? Hyprland.focusedMonitor.activeWorkspace.id : 1
    property int bank: Math.floor(Math.max(0, activeId - 1) / 10)
    property int localWs: ((Math.max(1, activeId) - 1) % 10) + 1

    Row {
        anchors.verticalCenter: parent.verticalCenter
        spacing: 4
        Repeater {
            model: 10
            Rectangle {
                property int targetWs: (root.bank * 10) + (index + 1)
                property bool isActive: (activeId === targetWs)
                width: 31
                height: 10
                color: "transparent"
                border.color: isActive ? "#36F8EC" : "#36F8EC"
                border.width: isActive ? 1.6 : 1.0

                // Filled cyan inner indicator for active workspace
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 4
                    color: parent.isActive ? "#FEF709" : "transparent"
                }
            }
        }
    }
}
