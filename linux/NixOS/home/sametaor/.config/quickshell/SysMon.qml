import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell.Io

Item {
    id: root
    width: 216
    height: 32.5

    property real cpu: 0.0
    property real temp: 0.0
    property real ram: 0.0

    // Robust telemetry loop
    Process {
        id: telemetryProc
        command: ["bash", "-c", "while true; do " + "cpu=$(vmstat 1 2 | tail -1 | awk '{print (100-$15)/100}'); " + "temp=$(cat /sys/class/thermal/thermal_zone0/temp 2>/dev/null || echo 0); " + "ram=$(free | awk '/Mem:/ {print ($2-$7)/$2}'); " + "echo \"$cpu $temp $ram\"; " + "done"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                let parts = data.trim().split(" ");
                if (parts.length >= 3) {
                    root.cpu = parseFloat(parts[0]) || 0;

                    let rawTemp = parseFloat(parts[1]) || 0;
                    let cTemp = rawTemp > 200 ? rawTemp / 1000.0 : rawTemp;
                    root.temp = Math.max(0, Math.min(cTemp / 100.0, 1.0));

                    root.ram = parseFloat(parts[2]) || 0;
                }
            }
        }
    }

    // =========================================================================
    // DYNAMIC PROGRESS FILLS
    // =========================================================================

    // CPU Fill (Top Bar)
    Item {
        x: 32
        y: 0
        width: Math.max(0, root.cpu * 184)
        height: 6
        clip: true
        Behavior on width {
            NumberAnimation {
                duration: 800
                easing.type: Easing.OutQuint
            }
        }
        Shape {
            width: 184
            height: 6
            antialiasing: true
            preferredRendererType: Shape.CurveRenderer
            ShapePath {
                fillColor: "#FEF709"
                strokeColor: "transparent"
                startX: 0
                startY: 0
                PathLine {
                    x: 184
                    y: 0
                }
                PathLine {
                    x: 178
                    y: 6
                }
                PathLine {
                    x: 0
                    y: 6
                }
            }
        }
    }

    // TEMP Fill (Middle Bar)
    Item {
        x: 32
        y: 13.5
        width: Math.max(0, root.temp * 172)
        height: 6
        clip: true
        Behavior on width {
            NumberAnimation {
                duration: 800
                easing.type: Easing.OutQuint
            }
        }
        Shape {
            width: 172
            height: 6
            antialiasing: true
            preferredRendererType: Shape.CurveRenderer
            ShapePath {
                fillColor: "#FEF709"
                strokeColor: "transparent"
                startX: 0
                startY: 0
                PathLine {
                    x: 172
                    y: 0
                }
                PathLine {
                    x: 166
                    y: 6
                }
                PathLine {
                    x: 0
                    y: 6
                }
            }
        }
    }

    // RAM Fill (Bottom Bar)
    Item {
        x: 32
        y: 26.5
        width: Math.max(0, root.ram * 160)
        height: 6
        clip: true
        Behavior on width {
            NumberAnimation {
                duration: 800
                easing.type: Easing.OutQuint
            }
        }
        Shape {
            width: 160
            height: 6
            antialiasing: true
            preferredRendererType: Shape.CurveRenderer
            ShapePath {
                fillColor: "#FEF709"
                strokeColor: "transparent"
                startX: 0
                startY: 0
                PathLine {
                    x: 160
                    y: 0
                }
                PathLine {
                    x: 154
                    y: 6
                }
                PathLine {
                    x: 0
                    y: 6
                }
            }
        }
    }

    // =========================================================================
    // STATIC GEOMETRY (Native Rectangles & Curve-Rendered Shapes)
    // =========================================================================

    // 1. Left PC Box (Native Rectangle for pristine pixel-hinting)
    Rectangle {
        x: 0
        y: 0
        width: 32
        height: 32.5
        color: "#1a00ffcc"
        border.color: "#29cbc0"
        border.width: 1
    }

    // 2. Slanted Bar Outlines (SVG-style CurveRenderer to bypass FBO bug)
    Shape {
        anchors.fill: parent
        antialiasing: true
        preferredRendererType: Shape.CurveRenderer

        // Top Bar Outline
        ShapePath {
            strokeColor: "#29cbc0"
            strokeWidth: 1
            fillColor: "transparent"
            joinStyle: ShapePath.MiterJoin
            startX: 32
            startY: 6.5
            PathLine {
                x: 210
                y: 6.5
            }
            PathLine {
                x: 216
                y: 0.5
            }
            PathLine {
                x: 32
                y: 0.5
            }
        }

        // Middle Bar Outline
        ShapePath {
            strokeColor: "#29cbc0"
            strokeWidth: 1
            fillColor: "transparent"
            joinStyle: ShapePath.MiterJoin
            startX: 32
            startY: 19.5
            PathLine {
                x: 198
                y: 19.5
            }
            PathLine {
                x: 204
                y: 13.5
            }
            PathLine {
                x: 32
                y: 13.5
            }
        }

        // Bottom Bar Outline
        ShapePath {
            strokeColor: "#29cbc0"
            strokeWidth: 1
            fillColor: "transparent"
            joinStyle: ShapePath.MiterJoin
            startX: 32
            startY: 32.5
            PathLine {
                x: 186
                y: 32.5
            }
            PathLine {
                x: 192
                y: 26.5
            }
            PathLine {
                x: 32
                y: 26.5
            }
        }
    }

    // --- PC GLYPH INTERIOR (Native Rectangles) ---
    Item {
        x: 0
        y: 0
        width: 32
        height: 33

        // Monitor Top
        Rectangle {
            x: 8
            y: 5
            width: 16
            height: 10
            color: "transparent"
            border.color: "#29cbc0"
            border.width: 1
            radius: 1
            Rectangle {
                anchors.centerIn: parent
                width: 10
                height: 4
                color: "#FEF709"
            }
        }

        // Base/Keyboard Bottom
        Rectangle {
            x: 6
            y: 20
            width: 20
            height: 6
            color: "transparent"
            border.color: "#29cbc0"
            border.width: 1
            radius: 1
            Row {
                anchors.centerIn: parent
                spacing: 3
                Rectangle {
                    width: 4
                    height: 2
                    color: "#29cbc0"
                }
                Rectangle {
                    width: 4
                    height: 2
                    color: "#29cbc0"
                }
            }
        }
    }
}
