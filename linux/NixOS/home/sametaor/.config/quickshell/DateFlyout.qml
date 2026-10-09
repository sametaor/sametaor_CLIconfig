import QtQuick
import QtQuick.Shapes
import Quickshell

// Opens under the clock/date box: a manual TO-DO list beside a MONTH calendar.
// Matches the concept: ONE unified card behind both panels (not two separately
// framed boxes), chamfered on the top-right and bottom-left - the opposite pair
// of corners from the TL/BR convention used by task buttons and the tray/media
// popups elsewhere - with a striped, chamfered wedge as the divider between the
// two halves instead of a plain line.
PopupWindow {
    id: root

    property Item target: null
    property real gap: 10
    property real padding: 14

    // Fixed panel widths, known immediately as plain arithmetic - not derived by
    // reading .width back off the instantiated TodoPanel/CalendarPanel/spine Items.
    // Some Wayland compositors size a popup's surface once, at its first commit,
    // and never resize it again; if implicitWidth were only resolved after those
    // child items exist and settle, the popup could get stuck at whatever (too
    // small) width was available on that first commit. These are compile-time-
    // constant sums instead, so the correct final width is available before the
    // popup is ever shown.
    readonly property real todoW: 190
    readonly property real spineW: 44   // thick, as in the concept
    readonly property real calW: 330

    property color lineColor: "#36F8EC"
    property color stripeColor: "#f809c9"
    property color fillColor: "#f00a0612"
    property real cardCut: 28

    property double closedAt: 0
    function toggle() {
        if (visible) {
            visible = false;
            return;
        }
        if (Date.now() - closedAt < 250)
            return;
        visible = true;
    }

    visible: false
    color: "transparent"
    grabFocus: true
    implicitWidth: root.todoW + root.spineW + root.calW + 2 * root.padding
    implicitHeight: body.implicitHeight + 2 * padding

    anchor.item: target
    anchor.edges: Edges.Bottom
    anchor.gravity: Edges.Bottom
    anchor.adjustment: PopupAdjustment.Slide
    anchor.margins.bottom: gap

    onVisibleChanged: {
        if (!visible) {
            closedAt = Date.now();
            todo.selectedIndex = -1;
            detail.anchorItem = null;
        }
    }

    // NOTE: deliberately NOT a Row. Positioners (Row/Column) in some Qt builds
    // fail to place children that are instances of a separately-defined component
    // type - width binds correctly but the assigned x stays 0. Chaining explicit
    // `x` bindings sidesteps that entirely and is no less readable here.
    ChamferBox {
        anchors.fill: parent
        cutTR: root.cardCut
        cutBL: root.cardCut
        fillColor: root.fillColor
        lineColor: root.lineColor
        stripeCorners: ["tr", "bl"]
        stripeColor: root.stripeColor
        stripeStep: 20   // tuned for cutSize 28: any denser and it reads as a hatch block
    }

    Item {
        id: body
        x: root.padding
        y: root.padding
        implicitWidth: cal.x + cal.width
        implicitHeight: cal.implicitHeight

        TodoPanel {
            id: todo
            x: 0
            width: root.todoW
            height: cal.implicitHeight
            standalone: false
            lineColor: root.lineColor
            stripeColor: root.stripeColor
            onTaskClicked: (index, buttonItem) => {
                if (index === -1 || !buttonItem) {
                    detail.anchorItem = null;
                    return;
                }
                detail.anchorItem = buttonItem;
                detail.taskTitle = todo.tasks[index].title;
                detail.taskBody = todo.tasks[index].body;
            }
            onTaskChanged: {
                if (todo.selectedIndex === -1)
                    detail.anchorItem = null;
            }
        }

        // Divider between the two panels: a thick strip whose LEFT edge (facing
        // TO-DO) runs fully straight, while its RIGHT edge (facing the calendar)
        // is chamfered near the top and bottom - matching the concept, where the
        // cut sits on the calendar-facing side. The notch height lines up with
        // where the calendar's own boxes start (CalendarPanel.gridStartY), so the
        // cut visually continues into the weekday row rather than landing at an
        // arbitrary height.
        // Divider between the two panels: a thick strip whose RIGHT edge (facing
        // the calendar) runs fully straight, while its LEFT edge (facing TO-DO)
        // is chamfered near the top and bottom - matching the concept, where the
        // cut sits on the TO-DO-facing side, densely filled with parallel lines.
        // The notch height lines up with where the calendar's own boxes start
        // (CalendarPanel.gridStartY), so the cut visually continues into the
        // weekday row rather than landing at an arbitrary height.
        Shape {
            id: spine
            x: todo.x + todo.width
            width: root.spineW
            height: cal.implicitHeight

            readonly property real notch: cal.gridStartY
            // parallel-line offsets within each notch, as a fraction of the way
            // from the actual cut (0) toward the fully-removed corner (1) - see
            // the comment below for the geometry this is based on
            readonly property var stripeParams: [0.2, 0.4, 0.6, 0.8]

            ShapePath {
                strokeColor: root.lineColor
                strokeWidth: 1
                fillColor: "transparent"
                joinStyle: ShapePath.MiterJoin
                startX: spine.width
                startY: 0
                PathLine {
                    x: 0
                    y: spine.notch
                }
                PathLine {
                    x: 0
                    y: spine.height - spine.notch
                }
                PathLine {
                    x: spine.width
                    y: spine.height
                }
                PathLine {
                    x: spine.width
                    y: 0
                }
            }

            // Stripe accents, drawn as lines parallel to the ACTUAL cut angle -
            // not with Hatch, which only draws true 45 degree lines and this
            // notch is far taller than it is wide. For a right triangle with the
            // removed corner at (0,0) and kept corners at (width,0) and
            // (0,notch), a line parallel to the hypotenuse at parameter s (0..1,
            // s=0 being the hypotenuse itself, s=1 the degenerate point at the
            // removed corner) runs from (width*(1-s), 0) to (0, notch*(1-s)).
            // The bottom notch mirrors this vertically. Unrolled explicitly
            // (4 per notch) since a Repeater of ShapePath isn't supported here.
            ShapePath {
                strokeColor: root.stripeColor
                strokeWidth: 2
                fillColor: "transparent"
                capStyle: ShapePath.FlatCap
                startX: spine.width * (1 - spine.stripeParams[0])
                startY: 0
                PathLine {
                    x: 0
                    y: spine.notch * (1 - spine.stripeParams[0])
                }
            }
            ShapePath {
                strokeColor: root.stripeColor
                strokeWidth: 2
                fillColor: "transparent"
                capStyle: ShapePath.FlatCap
                startX: spine.width * (1 - spine.stripeParams[1])
                startY: 0
                PathLine {
                    x: 0
                    y: spine.notch * (1 - spine.stripeParams[1])
                }
            }
            ShapePath {
                strokeColor: root.stripeColor
                strokeWidth: 2
                fillColor: "transparent"
                capStyle: ShapePath.FlatCap
                startX: spine.width * (1 - spine.stripeParams[2])
                startY: 0
                PathLine {
                    x: 0
                    y: spine.notch * (1 - spine.stripeParams[2])
                }
            }
            ShapePath {
                strokeColor: root.stripeColor
                strokeWidth: 2
                fillColor: "transparent"
                capStyle: ShapePath.FlatCap
                startX: spine.width * (1 - spine.stripeParams[3])
                startY: 0
                PathLine {
                    x: 0
                    y: spine.notch * (1 - spine.stripeParams[3])
                }
            }
            ShapePath {
                strokeColor: root.stripeColor
                strokeWidth: 2
                fillColor: "transparent"
                capStyle: ShapePath.FlatCap
                startX: 0
                startY: spine.height - spine.notch * (1 - spine.stripeParams[0])
                PathLine {
                    x: spine.width * (1 - spine.stripeParams[0])
                    y: spine.height
                }
            }
            ShapePath {
                strokeColor: root.stripeColor
                strokeWidth: 2
                fillColor: "transparent"
                capStyle: ShapePath.FlatCap
                startX: 0
                startY: spine.height - spine.notch * (1 - spine.stripeParams[1])
                PathLine {
                    x: spine.width * (1 - spine.stripeParams[1])
                    y: spine.height
                }
            }
            ShapePath {
                strokeColor: root.stripeColor
                strokeWidth: 2
                fillColor: "transparent"
                capStyle: ShapePath.FlatCap
                startX: 0
                startY: spine.height - spine.notch * (1 - spine.stripeParams[2])
                PathLine {
                    x: spine.width * (1 - spine.stripeParams[2])
                    y: spine.height
                }
            }
            ShapePath {
                strokeColor: root.stripeColor
                strokeWidth: 2
                fillColor: "transparent"
                capStyle: ShapePath.FlatCap
                startX: 0
                startY: spine.height - spine.notch * (1 - spine.stripeParams[3])
                PathLine {
                    x: spine.width * (1 - spine.stripeParams[3])
                    y: spine.height
                }
            }
        }

        CalendarPanel {
            id: cal
            x: spine.x + spine.width
            width: root.calW
            standalone: false
            lineColor: root.lineColor
            stripeColor: root.stripeColor
        }
    }

    // the task detail card, anchored to whichever task button is selected
    TaskDetailFlyout {
        id: detail
        lineColor: root.lineColor
        onBodyEdited: text => todo.updateBody(todo.selectedIndex, text)
    }
}
