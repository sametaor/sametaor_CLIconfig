import QtQuick
import QtQuick.Shapes

// Diagonal "////" hatch fill (the striped end-cap in the media concept).
// Clipped to its own rectangle, so it can be dropped into any box.
Item {
    id: root

    property color color: "#5536F8EC"
    property real step: 6
    property real lineWidth: 1

    clip: true

    readonly property string d: {
        let s = "";
        const h = height;
        for (let x = -h; x < width; x += step)
            s += "M" + x + " " + h + " L" + (x + h) + " 0 ";
        return s;
    }

    Shape {
        anchors.fill: parent
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            strokeColor: root.color
            strokeWidth: root.lineWidth
            fillColor: "transparent"
            capStyle: ShapePath.FlatCap
            PathSvg {
                path: root.d
            }
        }
    }
}
