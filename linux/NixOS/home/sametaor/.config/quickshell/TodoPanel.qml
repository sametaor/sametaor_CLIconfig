import QtQuick

// Manual TO-DO list: add a task by typing a title and pressing Enter (or the
// "+"), click a task to open its detail card and edit its notes, hover a task
// for a delete "x". Purely local state for now - `tasks` is a plain list of
// {title, body}, and every mutation goes through addTask/removeTask/updateBody,
// so pointing this at a real to-do service later just means redirecting those
// three functions instead of reassigning `tasks` by hand everywhere.
Item {
    id: root

    implicitWidth: 190
    width: implicitWidth
    implicitHeight: content.implicitHeight + 28

    property var tasks: []   // [{title, body}]
    property int selectedIndex: -1

    property color lineColor: "#36F8EC"
    property color stripeColor: "#f809c9"
    property color fillColor: "#f00a0612"   // near-opaque - the concept is solid black, not see-through
    property string fontFamily: "Iosevka SciFi"

    // exposes each row's Item so the flyout can anchor the detail card to it
    property var buttonItems: []

    signal taskClicked(int index, var buttonItem)
    signal taskChanged  // selection or list content changed in a way the flyout should react to

    function addTask(title) {
        const t = title.trim();
        if (t === "")
            return;
        root.tasks = root.tasks.concat([{
                    "title": t,
                    "body": ""
                }]);
    }

    function removeTask(index) {
        if (index < 0 || index >= root.tasks.length)
            return;
        const arr = root.tasks.slice();
        arr.splice(index, 1);
        root.tasks = arr;
        if (root.selectedIndex === index)
            root.selectedIndex = -1;
        else if (root.selectedIndex > index)
            root.selectedIndex--;
        root.taskChanged();
    }

    function updateBody(index, body) {
        if (index < 0 || index >= root.tasks.length)
            return;
        const arr = root.tasks.slice();
        arr[index] = {
            "title": arr[index].title,
            "body": body
        };
        root.tasks = arr;
    }

    function select(index, buttonItem) {
        root.selectedIndex = root.selectedIndex === index ? -1 : index;
        root.taskClicked(root.selectedIndex, root.selectedIndex === index ? buttonItem : null);
    }

    // matches the app's TL+BR chamfer convention (tray frame, media card, buttons)
    property real panelCut: 16
    // Set false when a parent (DateFlyout) draws one unified card behind both
    // panels instead - matches the concept, where TO-DO and the calendar share a
    // single outlined shape rather than each having its own separate frame.
    property bool standalone: true
    ChamferBox {
        visible: root.standalone
        anchors.fill: parent
        cutTL: root.panelCut
        cutBR: root.panelCut
        fillColor: root.fillColor
        lineColor: root.lineColor
        lineWidth: 2
    }

    Column {
        id: content
        x: 14
        y: 14
        width: parent.width - 28
        spacing: 10

        Text {
            text: "TO-DO"
            color: root.lineColor
            font.family: root.fontFamily
            font.pixelSize: 21
            font.bold: true
            font.letterSpacing: 1
        }

        Column {
            width: parent.width
            spacing: 8

            Repeater {
                model: root.tasks
                delegate: TaskButton {
                    id: btn
                    required property var modelData
                    required property int index
                    width: parent.width
                    label: modelData.title
                    selected: root.selectedIndex === index
                    lineColor: root.lineColor
                    Component.onCompleted: {
                        const arr = root.buttonItems.slice();
                        arr[index] = btn;
                        root.buttonItems = arr;
                    }
                    onClicked: root.select(index, btn)
                    onDeleteRequested: root.removeTask(index)
                }
            }

            // ---- add-task row ----
            Item {
                width: parent.width
                height: 34

                ChamferBox {
                    anchors.fill: parent
                    cutTL: 9
                    cutBR: 9
                    lineColor: input.activeFocus ? root.lineColor : "#5536F8EC"
                    fillColor: "#140f22"
                }

                TextInput {
                    id: input
                    anchors.left: parent.left
                    anchors.leftMargin: 15
                    anchors.right: addBtn.left
                    anchors.rightMargin: 6
                    anchors.verticalCenter: parent.verticalCenter
                    color: "#EFEEFF"
                    font.family: root.fontFamily
                    font.pixelSize: 13
                    clip: true
                    selectByMouse: true
                    onAccepted: {
                        root.addTask(text);
                        text = "";
                    }
                }
                Text {
                    visible: input.text === "" && !input.activeFocus
                    anchors.left: input.left
                    anchors.verticalCenter: parent.verticalCenter
                    text: "+ new task"
                    color: "#5a5470"
                    font.family: root.fontFamily
                    font.pixelSize: 13
                }
                Text {
                    id: addBtn
                    anchors.right: parent.right
                    anchors.rightMargin: 12
                    anchors.verticalCenter: parent.verticalCenter
                    text: "+"
                    color: addArea.containsMouse ? "#FEF709" : root.lineColor
                    font.family: root.fontFamily
                    font.pixelSize: 18
                    font.bold: true

                    MouseArea {
                        id: addArea
                        anchors.fill: parent
                        anchors.margins: -8
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            root.addTask(input.text);
                            input.text = "";
                            input.forceActiveFocus();
                        }
                    }
                }
            }
        }

        // live clock under the task list, as in the concept sketch
        Text {
            text: Qt.formatTime(root.clockNow, "HH:mm")
            color: root.lineColor
            font.family: root.fontFamily
            font.pixelSize: 22
            font.bold: true
        }
    }

    property date clockNow: new Date()
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: root.clockNow = new Date()
    }

    // small decorative accent (a couple of angled lines, not a filled hatch)
    // at the panel's bottom-left corner, echoing the concept sketch
    // no separate corner accent needed anymore - the real TL/BR chamfer (above)
    // is the accent now, matching the tray frame / media card convention
}
