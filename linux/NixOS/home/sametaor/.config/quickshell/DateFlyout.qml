import QtQuick
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
    readonly property real spineW: 24
    readonly property real calW: 330

    property color lineColor: "#36F8EC"
    property color stripeColor: "#f809c9"
    property color fillColor: "#f00a0612"
    property real cardCut: 28
    readonly property real spineNotch: 22   // how tall the wedge's own chamfer cuts are

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

        // Divider between the two panels: a narrow strip chamfered on its own
        // top-left and bottom-left corners, with the concept's diagonal-stripe
        // accent filling each notch. No fill of its own - it sits on the shared
        // card background above, it's not a separate panel.
        ChamferBox {
            id: spine
            x: todo.x + todo.width
            width: root.spineW
            height: cal.implicitHeight
            cutTL: root.spineNotch
            cutBL: root.spineNotch
            fillColor: "transparent"
            lineColor: root.lineColor
            stripeCorners: ["tl", "bl"]
            stripeColor: root.stripeColor
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
