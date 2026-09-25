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

    // Where the first stripe sits, as x+y along the box (0 = through the top-left
    // corner). Stripes are then `step` apart. Lets a caller keep them clear of a
    // chamfered corner instead of having them start wherever the pattern begins.
    property real startSum: 0

    readonly property string d: {
        let s = "";
        const h = height;
        for (let sum = startSum; sum < width + h; sum += step)
            s += "M" + (sum - h) + " " + h + " L" + sum + " 0 ";
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
