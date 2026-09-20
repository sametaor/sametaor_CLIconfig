import QtQuick
import QtQuick.Shapes

// A slanted button box in the same design as the tray frame.
//   slantLeft / slantRight choose which sides lean (the last box in the bar
//   turns slantRight off because it touches the end of the bar):
//        (slant,0) ______________ (W,0)          slantRight: false
//                 /              /   ->          ______________ (W,0)
//        (0,H)   /______________/ (W-slant,H)              |  (W,H)
// Anything declared inside a BarBox is laid out in its content row
// (icon, text, ...). Non-visual children (popups) are fine too.
Item {
    id: root

    property bool slantLeft: true
    property bool slantRight: true
    property real slant: 15
    property real frameTop: 6
    property real frameHeight: 18
    property real contentHeight: 14
    property real padding: 6
    property real contentSpacing: 4

    property bool active: false      // e.g. its popup is open  -> yellow
    property bool alert: false       // e.g. battery low        -> magenta

    property color borderColor: "#36F8EC"
    property color fillColor: "#1a00ffcc"
    property color hoverFill: "#3300ffcc"
    property color activeColor: "#FEF709"
    property color alertColor: "#f809c9"
    property string fontFamily: "Iosevka SciFi"

    readonly property color accent: active ? activeColor : (alert ? alertColor : borderColor)
    readonly property bool hovered: area.containsMouse

    default property alias content: contentRow.data

    signal clicked(var mouse)
    signal wheelMoved(var wheel)

    // how far the slanted edges intrude at the content's top/bottom rows
    readonly property real edgeInset: slant * (frameHeight - (frameHeight - contentHeight) / 2) / frameHeight
    readonly property real leftInset: (slantLeft ? edgeInset : 0) + padding
    readonly property real rightInset: (slantRight ? edgeInset : 0) + padding

    implicitWidth: leftInset + contentRow.implicitWidth + rightInset
    implicitHeight: frameTop + frameHeight

    // The layer is 1px larger on every side so the outline isn't clipped in half
    // where it sits exactly on the box edge.
    Item {
        x: -1
        y: root.frameTop - 1
        width: root.width + 2
        height: root.frameHeight + 2
        layer.enabled: true
        layer.samples: 4

        Shape {
            x: 1
            y: 1
            width: root.width
            height: root.frameHeight

            ShapePath {
                strokeColor: root.accent
                strokeWidth: 1
                fillColor: root.hovered ? root.hoverFill : root.fillColor
                joinStyle: ShapePath.MiterJoin

                startX: 0
                startY: root.frameHeight
                PathLine {
                    x: root.slantLeft ? root.slant : 0
                    y: 0
                }
                PathLine {
                    x: root.width
                    y: 0
                }
                PathLine {
                    x: root.slantRight ? root.width - root.slant : root.width
                    y: root.frameHeight
                }
                PathLine {
                    x: 0
                    y: root.frameHeight
                }
            }
        }
    }

    Row {
        id: contentRow
        x: root.leftInset
        y: root.frameTop + (root.frameHeight - root.contentHeight) / 2
        height: root.contentHeight
        spacing: root.contentSpacing
    }

    MouseArea {
        id: area
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
        cursorShape: Qt.PointingHandCursor

        // Neighbouring boxes overlap by a few px (their slanted edges nest), so
        // only accept the pointer inside this box's actual parallelogram.
        containmentMask: QtObject {
            function contains(p: point): bool {
                const y = p.y - root.frameTop;
                if (y < 0 || y > root.frameHeight)
                    return false;
                const t = y / root.frameHeight;
                const l = root.slantLeft ? root.slant * (1 - t) : 0;
                const r = root.slantRight ? root.width - root.slant * t : root.width;
                return p.x >= l && p.x <= r;
            }
        }

        onClicked: mouse => root.clicked(mouse)
        onWheel: wheel => root.wheelMoved(wheel)
    }
}
