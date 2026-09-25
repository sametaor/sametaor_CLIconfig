import QtQuick
import "calendarLayout.js" as Cal

// "MONTH" grid: weekday header row + a fixed 6x7 day grid (so the panel never
// resizes as you page between months). Today is filled solid; days outside the
// shown month are dimmed.
Item {
    id: root
    clip: true

    implicitWidth: 330
    width: implicitWidth
    implicitHeight: content.implicitHeight + 2 * contentMargin

    // The Column below insets its content by this much on every side. cellSize
    // MUST be derived from the space actually left over after that inset, not
    // from root.width directly - using root.width was the real, long-standing
    // bug behind the calendar's right edge always getting cut off: it sized
    // every cell as if the full panel width were available to the grid, when
    // 2*contentMargin of it was always eaten by the Column's own margins. Every
    // row was quietly overflowing its clipped container by exactly that amount,
    // on every screen, regardless of the panel's overall width - which is why
    // narrowing the popup or fiddling with its anchor never actually fixed it.
    property real contentMargin: 14

    property int weekStart: 0     // 0 = Sunday first (as in the concept), 1 = Monday
    property date today: new Date()
    property int viewYear: today.getFullYear()
    property int viewMonth: today.getMonth()

    readonly property var weeks: Cal.weeksFor(viewYear, viewMonth, weekStart)
    readonly property var labels: Cal.weekdayLabels(weekStart)
    readonly property real cellSize: Math.max(1, (root.width - 2 * contentMargin - 6 * 4) / 7)
    // flattened 6x7 grid: index -> {day, inMonth, ...}; avoids Row/Column, which
    // in some Qt builds fail to position their children correctly (see DateFlyout.qml)
    readonly property var flatDays: {
        const out = [];
        for (let w = 0; w < weeks.length; w++)
            for (let d = 0; d < weeks[w].length; d++)
                out.push(weeks[w][d]);
        return out;
    }
    readonly property string monthName: Qt.locale().monthName(viewMonth, Locale.LongFormat)

    property color lineColor: "#36F8EC"
    property color accentColor: "#FEF709"
    property color textColor: "#EFEEFF"
    property color dimColor: "#4a4460"
    property color stripeColor: "#f809c9"
    property color fillColor: "#f00a0612"   // near-opaque - the concept is solid black, not see-through
    property color cellColor: "#0a0612"
    property string fontFamily: "Iosevka SciFi"

    function isToday(cell) {
        return Cal.sameDate(cell, today.getFullYear(), today.getMonth(), today.getDate());
    }

    function prevMonth() {
        const d = new Date(root.viewYear, root.viewMonth - 1, 1);
        root.viewYear = d.getFullYear();
        root.viewMonth = d.getMonth();
    }
    function nextMonth() {
        const d = new Date(root.viewYear, root.viewMonth + 1, 1);
        root.viewYear = d.getFullYear();
        root.viewMonth = d.getMonth();
    }
    function goToday() {
        root.viewYear = today.getFullYear();
        root.viewMonth = today.getMonth();
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

    // small decorative accent (a couple of angled lines) at the panel's top-right
    // corner, echoing the concept sketch - no heavy chamfer/hatch fill needed here
    // no separate corner accent needed anymore - the real TL/BR chamfer (above)
    // is the accent now, matching the tray frame / media card convention
    Column {
        id: content
        anchors.fill: parent
        anchors.margins: root.contentMargin
        spacing: 8

        // ---- header: <  MONTH YEAR  > ----
        Item {
            width: parent.width
            height: 26

            Text {
                anchors.centerIn: parent
                text: root.monthName.toUpperCase() + "  " + root.viewYear
                color: root.lineColor
                font.family: root.fontFamily
                font.pixelSize: 21
                font.bold: true
                font.letterSpacing: 1
            }
            Text {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: "\u2039"
                color: prevArea.containsMouse ? root.accentColor : root.lineColor
                font.pixelSize: 22
                font.bold: true
                MouseArea {
                    id: prevArea
                    anchors.fill: parent
                    anchors.margins: -6
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.prevMonth()
                }
            }
            Text {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: "\u203A"
                color: nextArea.containsMouse ? root.accentColor : root.lineColor
                font.pixelSize: 22
                font.bold: true
                MouseArea {
                    id: nextArea
                    anchors.fill: parent
                    anchors.margins: -6
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.nextMonth()
                }
            }
        }

        // ---- weekday row ----
        // NOTE: positioned explicitly (x: index * ...), not via Row - Row silently
        // fails to place children correctly in some Qt builds (see DateFlyout.qml's
        // note on the same issue). Explicit x/y is robust regardless of Qt version.
        Item {
            width: parent.width
            height: 22
            clip: true
            Repeater {
                model: root.labels
                delegate: Rectangle {
                    id: label
                    required property string modelData
                    required property int index
                    x: index * (root.cellSize + 4)
                    width: root.cellSize
                    height: 22
                    color: root.cellColor
                    border.width: 2
                    border.color: root.lineColor
                    Text {
                        anchors.centerIn: parent
                        text: label.modelData
                        color: root.lineColor
                        font.family: root.fontFamily
                        font.pixelSize: 12
                        font.bold: true
                    }
                }
            }
        }

        // ---- 6x7 day grid (flattened - see the weekday row's note above) ----
        Item {
            width: parent.width
            height: 6 * (root.cellSize + 4) - 4
            clip: true
            Repeater {
                model: root.flatDays
                delegate: Rectangle {
                    id: cell
                    required property var modelData
                    required property int index
                    readonly property bool isToday: root.isToday(modelData)
                    x: (index % 7) * (root.cellSize + 4)
                    y: Math.floor(index / 7) * (root.cellSize + 4)
                    width: root.cellSize
                    height: root.cellSize
                    color: isToday ? root.accentColor : root.cellColor
                    border.width: 2
                    border.color: modelData.inMonth ? root.lineColor : root.dimColor

                    Text {
                        anchors.centerIn: parent
                        text: (cell.modelData.day < 10 ? "0" : "") + cell.modelData.day
                        color: cell.isToday ? "#1a1030" : (cell.modelData.inMonth ? root.textColor : root.dimColor)
                        font.family: root.fontFamily
                        font.pixelSize: 14
                        font.bold: true
                    }
                }
            }
        }
    }
}
