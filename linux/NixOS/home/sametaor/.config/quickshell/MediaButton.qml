import QtQuick
import QtQuick.Shapes

// Small square transport button with 45° chamfers on the top-left and
// bottom-right corners (same treatment as the flyout, cover art and popups).
//   kind: "prev" | "play" | "pause" | "next" | "shuffle" | "loop"
//   toggled: lit (yellow) state for shuffle / loop
//   badge:   tiny overlay text, e.g. "1" for repeat-one
Item {
    id: root

    property string kind: "play"
    property bool toggled: false
    property string badge: ""

    property real cut: 6
    property real btnWidth: 24
    property real btnHeight: 24

    property color lineColor: "#36F8EC"
    property color accentColor: "#FEF709"
    property color fillColor: "#1a00ffcc"
    property color hoverFill: "#3300ffcc"
    property string fontFamily: "Iosevka SciFi"

    signal clicked

    readonly property bool hot: area.containsMouse && enabled
    readonly property color ink: toggled ? accentColor : lineColor

    readonly property var fills: ({
            "prev": "M1.5 2 H3 V10 H1.5 Z M10.5 2 V10 L4.5 6 Z",
            "next": "M1.5 2 L7.5 6 L1.5 10 Z M9 2 H10.5 V10 H9 Z",
            "play": "M3 1.5 L10.5 6 L3 10.5 Z",
            "pause": "M2.5 2 H5 V10 H2.5 Z M7 2 H9.5 V10 H7 Z"
        })
    readonly property var strokes: ({
            "shuffle": "M1 3.5 H3.5 L8 8.5 H9.5 M1 8.5 H3.5 L8 3.5 H9.5 M8.8 2 L10.5 3.5 L8.8 5 M8.8 7 L10.5 8.5 L8.8 10",
            "loop": "M2 4 H10 V7 M10 8.5 H2 V5.5 M8.5 5.5 L10 7 L11.5 5.5 M0.5 7 L2 5.5 L3.5 7"
        })

    width: btnWidth
    height: btnHeight
    opacity: enabled ? 1 : 0.35

    Shape {
        anchors.fill: parent
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            strokeColor: root.toggled ? root.accentColor : (root.hot ? root.lineColor : "#8836F8EC")
            strokeWidth: 1
            fillColor: root.hot ? root.hoverFill : root.fillColor
            joinStyle: ShapePath.MiterJoin

            // top-left and bottom-right corners cut
            startX: root.cut
            startY: 0
            PathLine {
                x: root.width
                y: 0
            }
            PathLine {
                x: root.width
                y: root.height - root.cut
            }
            PathLine {
                x: root.width - root.cut
                y: root.height
            }
            PathLine {
                x: 0
                y: root.height
            }
            PathLine {
                x: 0
                y: root.cut
            }
            PathLine {
                x: root.cut
                y: 0
            }
        }
    }

    // 12x12 icon, centred
    Shape {
        x: (root.width - 12) / 2
        y: (root.height - 12) / 2
        width: 12
        height: 12
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            strokeColor: "transparent"
            fillColor: root.ink
            PathSvg {
                path: root.fills[root.kind] || ""
            }
        }
        ShapePath {
            strokeColor: root.ink
            strokeWidth: 1.2
            fillColor: "transparent"
            capStyle: ShapePath.FlatCap
            joinStyle: ShapePath.MiterJoin
            PathSvg {
                path: root.strokes[root.kind] || ""
            }
        }
    }

    Text {
        visible: root.badge !== ""
        anchors.centerIn: parent
        text: root.badge
        color: root.ink
        font.family: root.fontFamily
        font.pixelSize: 8
        font.bold: true
    }

    MouseArea {
        id: area
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        // the cut corners aren't clickable
        containmentMask: QtObject {
            function contains(p: point): bool {
                if (p.x < 0 || p.y < 0 || p.x > root.width || p.y > root.height)
                    return false;
                if (p.x + p.y < root.cut)
                    return false;
                if ((root.width - p.x) + (root.height - p.y) < root.cut)
                    return false;
                return true;
            }
        }
        onClicked: root.clicked()
    }
}
