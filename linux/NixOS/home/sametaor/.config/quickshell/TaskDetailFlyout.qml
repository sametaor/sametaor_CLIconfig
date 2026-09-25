import QtQuick
import Quickshell

// The small card that opens off a selected task's bottom-right corner (see the
// concept sketch: chamfered top-left + bottom-right, title row, divider, body).
PopupWindow {
    id: root

    property Item anchorItem: null
    property string taskTitle: ""
    property string taskBody: ""

    signal bodyEdited(string text)

    property real panelWidth: 220
    property real cut: 14
    property real gap: 6

    property color fillColor: "#f01a1030"
    property color lineColor: "#36F8EC"
    property color textColor: "#EFEEFF"
    property color dimColor: "#8a7fa8"
    property string fontFamily: "Iosevka SciFi"

    visible: anchorItem !== null
    color: "transparent"
    implicitWidth: panelWidth
    implicitHeight: col.implicitHeight + 2 * cut

    // Hangs off the task button's bottom-right corner, which is where its chamfer
    // plug appears - the "anchored corner" the flyout visually grows out of.
    anchor.item: anchorItem
    anchor.edges: Edges.Bottom | Edges.Right
    anchor.gravity: Edges.Bottom | Edges.Right
    anchor.adjustment: PopupAdjustment.Slide
    anchor.margins.top: gap
    anchor.margins.left: gap

    ChamferBox {
        anchors.fill: parent
        cutTL: root.cut
        cutBR: root.cut
        fillColor: root.fillColor
        lineColor: root.lineColor
    }

    Column {
        id: col
        x: root.cut + 2
        y: root.cut - 4
        width: root.panelWidth - root.cut - 14
        spacing: 8

        Text {
            width: parent.width
            text: root.taskTitle
            color: root.lineColor
            font.family: root.fontFamily
            font.pixelSize: 15
            font.bold: true
            elide: Text.ElideRight
        }
        Rectangle {
            width: parent.width + 8
            x: -4
            height: 1
            color: root.lineColor
            opacity: 0.5
        }
        // editable notes for this task - plain TextEdit so it can wrap and grow
        Item {
            width: parent.width
            height: Math.max(60, body.implicitHeight)

            Text {
                visible: body.text === "" && !body.activeFocus
                anchors.fill: parent
                text: "notes..."
                color: "#5a5470"
                font.family: root.fontFamily
                font.pixelSize: 13
                font.italic: true
            }

            TextEdit {
                id: body
                width: parent.width
                color: root.textColor
                font.family: root.fontFamily
                font.pixelSize: 13
                wrapMode: TextEdit.WordWrap
                selectByMouse: true
                text: root.taskBody
                // reflect an outside change (e.g. switching tasks) without fighting
                // the user's own typing
                onTextChanged: if (text !== root.taskBody)
                    root.bodyEdited(text)
                Connections {
                    target: root
                    function onTaskBodyChanged() {
                        if (body.text !== root.taskBody)
                            body.text = root.taskBody;
                    }
                }
            }
        }
    }
}
