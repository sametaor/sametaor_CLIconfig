import QtQuick
import QtQuick.Shapes

// A rectangle with any of its four corners cut at 45°.
// Two independent looks share this shape in the bar:
//   - "popup" style (tray menus, media card): corners cut TOP-LEFT + BOTTOM-RIGHT
//   - "side-panel" style (SysMon, this date flyout): corners cut TOP-RIGHT +
//     BOTTOM-LEFT, usually with the cut notch filled by a striped accent instead
//     of being left open (see `stripeCorners`)
// `plugCorners` fills a normally-open notch with a solid triangle - used for a
// task button's selected state ("complete" the chamfer instead of leaving it cut).
Item {
    id: root

    property real cutTL: 0
    property real cutTR: 0
    property real cutBL: 0
    property real cutBR: 0

    property color fillColor: "#1a00ffcc"
    property color lineColor: "#36F8EC"
    property real lineWidth: 1

    // Corners listed here (any of "tl","tr","bl","br") get Hatch stripes instead
    // of plain fill in their cut notch, e.g. ["tr", "bl"] for the side-panel look.
    property var stripeCorners: []
    property color stripeColor: "#f809c9"
    property real stripeStep: 6
    property real stripeWidth: 2

    // Corners listed here get a solid plugColor triangle filling their cut notch
    // (e.g. ["br"] once a task button is selected).
    property var plugCorners: []
    property color plugColor: "#FEF709"

    function has(list, name) {
        return list.indexOf(name) !== -1;
    }

    readonly property string outline: {
        const w = width, h = height;
        const tl = cutTL, tr = cutTR, bl = cutBL, br = cutBR;
        let d = "M" + tl + " 0";
        d += " L" + (w - tr) + " 0";
        if (tr > 0)
            d += " L" + w + " " + tr;
        d += " L" + w + " " + (h - br);
        if (br > 0)
            d += " L" + (w - br) + " " + h;
        d += " L" + bl + " " + h;
        if (bl > 0)
            d += " L0 " + (h - bl);
        d += " L0 " + tl;
        if (tl > 0)
            d += " L" + tl + " 0";
        return d;
    }

    Shape {
        anchors.fill: parent
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            strokeColor: root.lineColor
            strokeWidth: root.lineWidth
            fillColor: root.fillColor
            joinStyle: ShapePath.MiterJoin
            PathSvg {
                path: root.outline
            }
        }
    }

    // ---- striped notches (e.g. the side-panel corner accent) ----
    Repeater {
        model: [
            {
                "name": "tl",
                "cut": root.cutTL
            },
            {
                "name": "tr",
                "cut": root.cutTR
            },
            {
                "name": "bl",
                "cut": root.cutBL
            },
            {
                "name": "br",
                "cut": root.cutBR
            }
        ]
        delegate: Item {
            required property var modelData
            readonly property bool active: modelData.cut > 0 && root.has(root.stripeCorners, modelData.name)
            visible: active
            width: active ? modelData.cut : 0
            height: active ? modelData.cut : 0
            x: modelData.name === "tl" || modelData.name === "bl" ? 0 : root.width - modelData.cut
            y: modelData.name === "tl" || modelData.name === "tr" ? 0 : root.height - modelData.cut

            Hatch {
                anchors.fill: parent
                color: root.stripeColor
                step: root.stripeStep
                lineWidth: root.stripeWidth
                // stripes run parallel to whichever diagonal this corner cuts
                startSum: modelData.name === "tl" || modelData.name === "br" ? 0 : -parent.width
            }
        }
    }

    // ---- filled plug notches (e.g. selected-task corner) ----
    Shape {
        anchors.fill: parent
        visible: root.plugCorners.length > 0
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            strokeColor: "transparent"
            fillColor: root.plugColor
            PathSvg {
                path: {
                    let d = "";
                    if (root.has(root.plugCorners, "tl") && root.cutTL > 0)
                        d += "M0 0 L" + root.cutTL + " 0 L0 " + root.cutTL + " Z ";
                    if (root.has(root.plugCorners, "tr") && root.cutTR > 0)
                        d += "M" + (root.width - root.cutTR) + " 0 L" + root.width + " 0 L" + root.width + " " + root.cutTR + " Z ";
                    if (root.has(root.plugCorners, "bl") && root.cutBL > 0)
                        d += "M0 " + (root.height - root.cutBL) + " L0 " + root.height + " L" + root.cutBL + " " + root.height + " Z ";
                    if (root.has(root.plugCorners, "br") && root.cutBR > 0)
                        d += "M" + (root.width - root.cutBR) + " " + root.height + " L" + root.width + " " + root.height + " L" + root.width + " " + (root.height - root.cutBR) + " Z ";
                    return d;
                }
            }
        }
    }
}
