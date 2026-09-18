import QtQuick
import QtQuick.Shapes

Item {
    id: root
    width: 1200 // Will adapt dynamically to PanelWindow width
    height: 60

    property color backgroundColor: "#b30b0c10"
    property color borderColor: "#f809c9"
    property real borderWidth: 1.5

    // Controlling properties based on the center of the bar
    property real centerWidth: 400   // Width of the narrow middle song section
    property real stepSize: 15       // The 45-degree angle transition size
    property real topStepY: 12       // How far down the top middle line drops
    property real bottomStepY: 12    // How far up the bottom middle line rises

    layer.enabled: true
    layer.samples: 4

    Shape {
        anchors.fill: parent

        ShapePath {
            strokeColor: root.borderColor
            strokeWidth: root.borderWidth
            fillColor: root.backgroundColor
            joinStyle: ShapePath.MiterJoin

            // ========================================================
            // TOP EDGE (Left to Right)
            // ========================================================
            // 1. Top left corner start (indented slightly for the slant)
            startX: 12
            startY: 0

            // 2. Line to the start of the center section's top drop down
            PathLine {
                //x: (root.width / 2) - (root.centerWidth / 2) - root.stepSize
                x: 12
                y: 0
            }

            // 6. Line to the top right edge (stopping short for the far-right slant)
            PathLine {
                x: root.width
                y: 0
            }

            // 7. Slant down at the very far-right edge
            PathLine {
                x: root.width
                y: 12
            }

            // ========================================================
            // RIGHT & BOTTOM EDGE (Right to Left)
            // ========================================================

            PathLine {
                x: 1920
                y: 20
            }

            PathLine {
                x: 1910
                y: 30
            }

            PathLine {
                //x: (root.width / 2) + (root.centerWidth / 2) + root.stepSize
                x: 1500
                y: 30
            }

            // 9. Line to the start of the center section's bottom step up
            PathLine {
                x: 1465
                y: 30
            }

            // 10. Slant up into the middle section
            PathLine {
                x: 1450
                y: 45
            }

            PathLine {
                x: 1000
                y: 45
            }

            PathLine {
                x: 985
                y: 30
            }

            // 11. Straight line across the bottom of the middle section
            PathLine {
                x: 970
                y: 45
            }

            // 12. Slant back down to the left section
            PathLine {
                x: 725
                y: 45
            }

            PathLine {
                x: 725
                y: 30
            }

            PathLine {
                x: 680
                y: 30
            }

            PathLine {
                x: 665
                y: 45
            }

            PathLine {
                x: 400
                y: 45
            }

            PathLine {
                x: 385
                y: root.height
            }

            // 13. Line to the bottom left corner
            PathLine {
                x: 0
                y: root.height
            }

            // 14. Straight vertical up on the leftmost edge
            PathLine {
                x: 0
                y: 12
            }

            // 15. Closes back to startX/startY creating the top-left slant
            PathLine {
                x: 12
                y: 0
            }
        }
        ShapePath {
            strokeColor: "#36F8EC" // Neon accent border color
            strokeWidth: 1
            fillColor: "#1a00ffcc"  // Tinted translucent background fill (optional)
            joinStyle: ShapePath.MiterJoin

            // Define the bounding box for the internal frame (relative to the center)
            // It sits 4 pixels inside the main cut lines for a layered look
            property real innerCenter: root.centerWidth - 8
            property real leftX: (root.width / 2) - (innerCenter / 2)
            property real rightX: (root.width / 2) + (innerCenter / 2)

            // 1. Top left corner of the inner box
            startX: 412
            startY: 6

            // 2. Line to top right corner
            PathLine {
                x: 390
                y: 28
            }

            // 3. Line down to bottom right corner
            PathLine {
                x: 400
                y: 39
            }

            // 4. Line across to bottom left corner
            PathLine {
                x: 450
                y: 39
            }

            // 5. Line back up to close the loop
            PathLine {
                x: 516
                y: 39
            }

            PathLine {
                x: 550
                y: 6
            }

            PathLine {
                x: 412
                y: 6
            }
        }
        ShapePath {
            strokeColor: "#36F8EC" // Neon accent border color
            strokeWidth: 1
            fillColor: "#1a00ffcc"  // Tinted translucent background fill (optional)
            joinStyle: ShapePath.MiterJoin

            // Define the bounding box for the internal frame (relative to the center)
            // It sits 4 pixels inside the main cut lines for a layered look
            property real innerCenter: root.centerWidth - 8
            property real leftX: (root.width / 2) - (innerCenter / 2)
            property real rightX: (root.width / 2) + (innerCenter / 2)

            // 1. Top left corner of the inner box
            startX: 558
            startY: 6

            // 3. Line down to bottom right corner
            PathLine {
                x: 524
                y: 39
            }

            // 5. Line back up to close the loop
            PathLine {
                x: 663
                y: 39
            }

            PathLine {
                x: 674
                y: 28
            }

            PathLine {
                x: 674
                y: 6
            }

            PathLine {
                x: 558
                y: 6
            }
        }
        // Place this directly inside the Shape component, below the first ShapePath
        ShapePath {
            strokeColor: "#36F8EC" // Neon accent border color
            strokeWidth: 1
            fillColor: "#1a00ffcc"  // Tinted translucent background fill (optional)
            joinStyle: ShapePath.MiterJoin

            // Define the bounding box for the internal frame (relative to the center)
            // It sits 4 pixels inside the main cut lines for a layered look
            property real innerCenter: root.centerWidth - 8
            property real leftX: (root.width / 2) - (innerCenter / 2)
            property real rightX: (root.width / 2) + (innerCenter / 2)

            // 1. Top left corner of the inner box
            startX: 731
            startY: 6

            // 2. Line to top right corner
            PathLine {
                x: 983
                y: 6
            }

            // 3. Line down to bottom right corner
            PathLine {
                x: 983
                y: 24
            }

            // 4. Line across to bottom left corner
            PathLine {
                x: 969
                y: 39
            }

            // 5. Line back up to close the loop
            PathLine {
                x: 731
                y: 39
            }

            PathLine {
                x: 731
                y: 6
            }
        }
        ShapePath {
            strokeColor: "#36F8EC" // Neon accent border color
            strokeWidth: 1
            fillColor: "#1a00ffcc"  // Tinted translucent background fill (optional)
            joinStyle: ShapePath.MiterJoin

            // Define the bounding box for the internal frame (relative to the center)
            // It sits 4 pixels inside the main cut lines for a layered look
            property real innerCenter: root.centerWidth - 8
            property real leftX: (root.width / 2) - (innerCenter / 2)
            property real rightX: (root.width / 2) + (innerCenter / 2)

            // 1. Top left corner of the inner box
            startX: 1250
            startY: 6

            // 2. Line to top right corner
            PathLine {
                x: 987
                y: 6
            }

            // 3. Line down to bottom right corner
            PathLine {
                x: 987
                y: 24
            }

            // 4. Line across to bottom left corner
            PathLine {
                x: 987
                y: 24
            }

            PathLine {
                x: 1001
                y: 39
            }

            // 5. Line back up to close the loop
            PathLine {
                x: 1250
                y: 39
            }

            PathLine {
                x: 1250
                y: 6
            }
        }
    }

    // ========================================================
    // DECORATIVE ACCENT LINES (Far Left Slanted Stripes)
    // ========================================================
    Row {
        x: 12
        y: 6
        spacing: 3
        Repeater {
            model: 1
            Rectangle {
                width: 2
                height: 20
                color: root.borderColor
                transform: Rotation {
                    angle: 45
                }
            }
        }
    }
    Row {
        x: 12
        y: 14
        spacing: 3
        Repeater {
            model: 1
            Rectangle {
                width: 2
                height: 20
                color: root.borderColor
                transform: Rotation {
                    angle: 45
                }
            }
        }
    }
    Row {
        x: 12
        y: 22
        spacing: 3
        Repeater {
            model: 1
            Rectangle {
                width: 2
                height: 20
                color: root.borderColor
                transform: Rotation {
                    angle: 45
                }
            }
        }
    }
    Row {
        x: 12
        y: 30
        spacing: 3
        Repeater {
            model: 1
            Rectangle {
                width: 2
                height: 20
                color: root.borderColor
                transform: Rotation {
                    angle: 45
                }
            }
        }
    }
    Row {
        x: 12
        y: 38
        spacing: 3
        Repeater {
            model: 1
            Rectangle {
                width: 2
                height: 20
                color: root.borderColor
                transform: Rotation {
                    angle: 45
                }
            }
        }
    }
    Row {
        x: 12
        y: 46
        spacing: 3
        Repeater {
            model: 1
            Rectangle {
                width: 2
                height: 20
                color: root.borderColor
                transform: Rotation {
                    angle: 45
                }
            }
        }
    }
    Row {
        x: 12
        y: 54
        spacing: 3
        Repeater {
            model: 1
            Rectangle {
                width: 2
                height: 20
                color: root.borderColor
                transform: Rotation {
                    angle: 45
                }
            }
        }
    }
    Row {
        x: 1920
        y: 11
        spacing: 3
        Repeater {
            model: 1
            Rectangle {
                width: 2
                height: 16
                color: root.borderColor
                transform: Rotation {
                    angle: 45
                }
            }
        }
    }
    Row {
        x: 1920
        y: 3
        spacing: 3
        Repeater {
            model: 1
            Rectangle {
                width: 2
                height: 16
                color: root.borderColor
                transform: Rotation {
                    angle: 45
                }
            }
        }
    }
    Row {
        x: 1920
        y: -5
        spacing: 3
        Repeater {
            model: 1
            Rectangle {
                width: 2
                height: 16
                color: root.borderColor
                transform: Rotation {
                    angle: 45
                }
            }
        }
    }

    Row {
        x: 11
        y: 0
        Repeater {
            model: 1
            Rectangle {
                width: 2
                height: 60
                color: root.borderColor
                transform: Rotation {
                    angle: 0
                }
            }
        }
    }
    Row {
        x: 1908
        y: 0
        Repeater {
            model: 1
            Rectangle {
                width: 2
                height: 30
                color: root.borderColor
                transform: Rotation {
                    angle: 0
                }
            }
        }
    }
    Row {
        x: 12
        y: 40
        Repeater {
            model: 1
            Rectangle {
                width: 2
                height: 360
                color: root.borderColor
                transform: Rotation {
                    angle: -90
                }
            }
        }
    }
    Row {
        x: 372
        y: 40
        Repeater {
            model: 1
            Rectangle {
                width: 2
                height: 55
                color: root.borderColor
                transform: Rotation {
                    angle: -135
                }
            }
        }
    }
    Row {
        x: 382
        y: 30
        Repeater {
            model: 1
            Rectangle {
                width: 2
                height: 24
                color: root.borderColor
                transform: Rotation {
                    angle: -45
                }
            }
        }
    }
    Row {
        x: 679
        y: 0
        Repeater {
            model: 1
            Rectangle {
                width: 2
                height: 30
                color: root.borderColor
                transform: Rotation {
                    angle: 0
                }
            }
        }
    }
    Row {
        x: 724
        y: 0
        Repeater {
            model: 1
            Rectangle {
                width: 2
                height: 30
                color: root.borderColor
                transform: Rotation {
                    angle: 0
                }
            }
        }
    }
    Row {
        x: 900
        y: 6
        Repeater {
            model: 1
            Rectangle {
                width: 1
                height: 24
                color: "#00ffcc"
                transform: Rotation {
                    angle: 0
                }
            }
        }
    }
    Row {
        x: 891
        y: 40
        Repeater {
            model: 1
            Rectangle {
                width: 1
                height: 14
                color: "#00ffcc"
                transform: Rotation {
                    angle: -135
                }
            }
        }
    }
    Row {
        x: 1091
        y: 6
        Repeater {
            model: 1
            Rectangle {
                width: 1
                height: 24
                color: "#00ffcc"
                transform: Rotation {
                    angle: 0
                }
            }
        }
    }
    Row {
        x: 1091
        y: 30
        Repeater {
            model: 1
            Rectangle {
                width: 1
                height: 14
                color: "#00ffcc"
                transform: Rotation {
                    angle: -45
                }
            }
        }
    }
}
