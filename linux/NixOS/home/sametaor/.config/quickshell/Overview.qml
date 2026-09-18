import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Item {
    id: root
    width: 260
    height: 28

    property int activeWs: {
        return (Hyprland.focusedMonitor && Hyprland.focusedMonitor.activeWorkspace) ? Hyprland.focusedMonitor.activeWorkspace.id : 1;
    }

    Row {
        anchors.fill: parent
        spacing: 16

        Repeater {
            model: [root.activeWs, root.activeWs + 1]
            delegate: Item {
                id: pane
                required property var modelData
                property int targetWs: modelData
                width: 120
                height: 26
                clip: true // Hard bounds overflow when window density spikes

                // Track matching count for dynamic high-density compression
                readonly property int matchingCount: {
                    let c = 0;
                    let tops = Hyprland.toplevels;
                    if (!tops)
                        return 0;
                    for (let i = 0; i < tops.length; ++i) {
                        let t = tops[i];
                        let wid = (t.workspace && t.workspace.id !== undefined) ? t.workspace.id : -1;
                        if (wid === pane.targetWs)
                            c++;
                    }
                    return c;
                }

                Row {
                    anchors.centerIn: parent
                    spacing: pane.matchingCount > 4 ? 2 : 6

                    // Direct reactive binding to Hyprland.toplevels model
                    Repeater {
                        model: Hyprland.toplevels
                        delegate: Item {
                            id: pillWrapper
                            required property var modelData
                            readonly property var ws: modelData.workspace
                            readonly property int wsId: ws && ws.id !== undefined ? ws.id : -1
                            readonly property bool belongs: wsId === pane.targetWs
                            readonly property bool isFocused: Hyprland.activeToplevel === modelData

                            visible: belongs
                            // Proportional shrink factor when >4 windows share the 120px slot
                            readonly property real scaleFactor: pane.matchingCount > 4 ? Math.max(0.45, 4.5 / pane.matchingCount) : 1.0
                            width: belongs ? (isFocused ? 48 * scaleFactor : 12 * scaleFactor) : 0
                            height: 26

                            Behavior on width {
                                NumberAnimation {
                                    duration: 160
                                    easing.type: Easing.OutQuad
                                }
                            }

                            // Clean valid 45-degree parallelogram shear matrix (m12 = -1.0)
                            Item {
                                anchors.fill: parent
                                transform: Matrix4x4 {
                                    matrix: Qt.matrix4x4(1, -1.0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
                                }

                                Rectangle {
                                    anchors.fill: parent
                                    radius: 1
                                    color: isFocused ? "#FEF709" : "#7a7f8c"
                                    opacity: isFocused ? 1.0 : 0.6
                                    border.color: isFocused ? "#36F8EC" : "transparent"
                                    border.width: 4
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
