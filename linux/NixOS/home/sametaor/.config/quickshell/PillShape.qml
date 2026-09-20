import QtQuick
import QtQuick.Shapes

// One 45° parallelogram ("/" lean, same as the bar's frames).
// Bounding box is (topWidth + pillHeight) x pillHeight:
//        (H,0) ________ (H+topWidth,0)
//             /        /
//      (0,H) /________/ (topWidth,H)
// Rendering: Shape.CurveRenderer (Qt 6.6+) anti-aliases on the GPU, so there is
// no per-pill multisampled offscreen layer to re-render on every animation frame.
// Dashed strokes aren't supported by it, so only the dashed placeholder uses the
// geometry renderer.
Item {
    id: root

    property real pillHeight: 27
    property real topWidth: 40
    property color fillColor: "#337a7f8c"
    property color lineColor: "#6636F8EC"
    property real lineWidth: 1
    property bool dashed: false

    width: topWidth + pillHeight
    height: pillHeight

    Shape {
        anchors.fill: parent
        preferredRendererType: root.dashed ? Shape.GeometryRenderer : Shape.CurveRenderer

        ShapePath {
            strokeColor: root.lineColor
            strokeWidth: root.lineWidth
            fillColor: root.fillColor
            joinStyle: ShapePath.MiterJoin
            strokeStyle: root.dashed ? ShapePath.DashLine : ShapePath.SolidLine
            dashPattern: [3, 2]

            startX: root.pillHeight
            startY: 0
            PathLine {
                x: root.pillHeight + root.topWidth
                y: 0
            }
            PathLine {
                x: root.topWidth
                y: root.pillHeight
            }
            PathLine {
                x: 0
                y: root.pillHeight
            }
            PathLine {
                x: root.pillHeight
                y: 0
            }
        }
    }
}
