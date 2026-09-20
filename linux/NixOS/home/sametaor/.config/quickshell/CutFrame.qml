import QtQuick
import QtQuick.Shapes

// Popup background with 45° cut corners (top-left and bottom-right).
Item {
    id: cf

    property real cut: 12
    property color fillColor: "#f01a1030"
    property color lineColor: "#36F8EC"
    property real lineWidth: 1
    // inset by half the stroke so the outline isn't clipped by the window edge
    readonly property real o: lineWidth / 2

    Shape {
        anchors.fill: parent
        layer.enabled: true
        layer.samples: 4

        ShapePath {
            strokeColor: cf.lineColor
            strokeWidth: cf.lineWidth
            fillColor: cf.fillColor
            joinStyle: ShapePath.MiterJoin

            startX: cf.o + cf.cut
            startY: cf.o
            PathLine {
                x: cf.width - cf.o
                y: cf.o
            }
            PathLine {
                x: cf.width - cf.o
                y: cf.height - cf.o - cf.cut
            }
            PathLine {
                x: cf.width - cf.o - cf.cut
                y: cf.height - cf.o
            }
            PathLine {
                x: cf.o
                y: cf.height - cf.o
            }
            PathLine {
                x: cf.o
                y: cf.o + cf.cut
            }
            PathLine {
                x: cf.o + cf.cut
                y: cf.o
            }
        }
    }
}
