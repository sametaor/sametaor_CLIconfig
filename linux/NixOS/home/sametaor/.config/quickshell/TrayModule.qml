import QtQuick
import QtQuick.Shapes
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Services.SystemTray

// ============================================================================
//  TrayModule.qml — StatusNotifier system tray inside an adjustable frame.
//  Frame shape (a parallelogram, both sides lean the same way as the bar's own
//  45° cuts). `slant` is the x-offset between the bottom and top corners:
//            (slant,0) ________________ (W,0)
//                     /               /
//                    /               /
//           (0,H)   /_______________/  (W-slant,H)
//  The frame's RIGHT edge is fixed by the anchor you give it in shell.qml, so
//  it grows/shrinks toward the LEFT as icons are shown or hidden.
//  Layout inside the frame, left -> right:  [ v ] [icon] [icon] [icon] ...
//  The "v" overflow button only exists when something is hidden (or when it
//  doesn't fit). Behaviour follows DankMaterialShell's tray:
//    * left click   -> activate()        (or open the menu for onlyMenu items)
//    * middle click -> secondaryActivate()
//    * right click  -> custom-rendered DBusMenu, with a Hide/Show row on top
//    * scroll       -> item.scroll()     (e.g. volume on a mixer applet)
//    * hidden icons live in the overflow popup, persisted to disk
// ============================================================================
Item {
    id: root

    // ---------------------------------------------------------------- geometry
    property real iconSize: 14
    property real iconSpacing: 6
    property real padding: 6          // extra inner gap between slanted edge and first/last icon
    property real slant: 15           // top corners sit this much further right than bottom corners
    property real frameTop: 6         // y of the frame's top edge inside the bar
    property real frameHeight: 18     // frame height (bar ledge is at y=30, so 6 + 18 + 6)
    property real maxWidth: 430       // widest the frame may get; extra icons auto-overflow
    property real popupGap: -10        // extra distance between the frame and menus/tooltips

    // --------------------------------------------------------------- behaviour
    property bool hideWhenEmpty: true         // collapse the whole frame with zero icons
    property bool alwaysShowOverflow: false   // show the "v" even if nothing is hidden
    property bool hidePassive: false          // drop items reporting Status.Passive
    property bool tintIcons: false            // flatten every icon to `tintColor`

    // ------------------------------------------------------------------ colours
    property color borderColor: "#36F8EC"
    property color fillColor: "#1a00ffcc"
    property color hoverFill: "#3300ffcc"
    property color accentColor: "#FEF709"
    property color iconColor: "#36F8EC"       // chevron + fallback letter
    property color tintColor: "#36F8EC"
    property color menuBackground: "#f01a1030"
    property color menuText: "#EFEEFF"
    property color menuDim: "#8a7fa8"
    property string fontFamily: "Iosevka SciFi"

    // ------------------------------------------------------------ menu metrics
    property real menuWidth: 240
    property real menuMaxHeight: 420
    property real menuMargin: 4
    property real cutSize: 12          // 45° chamfer on the top-left and bottom-right of menus/tooltips
    property real rowHeight: 24

    // ================================================================ derived
    readonly property real pitch: iconSize + iconSpacing
    // How far the slanted edges intrude at the icons' top/bottom rows, so an
    // icon never touches the diagonal.
    readonly property real edgeInset: slant * (frameHeight - (frameHeight - iconSize) / 2) / frameHeight
    readonly property real sideInset: edgeInset + padding

    // ---------------------------------------------------------------- items
    // Same key scheme as DMS: id, disambiguated by tooltipTitle (Electron apps
    // all report "chrome_status_icon_1", so id alone is not unique).
    function keyOf(item) {
        const id = item ? (item.id || "") : "";
        const tt = item ? (item.tooltipTitle || "") : "";
        return (!tt || tt === id) ? id : id + "::" + tt;
    }

    function keyFor(item) {
        for (let i = 0; i < allEntries.length; i++) {
            if (allEntries[i].item === item)
                return allEntries[i].key;
        }
        return keyOf(item);
    }

    function titleOf(item) {
        return item ? (item.tooltipTitle || item.title || item.id || "") : "";
    }

    readonly property var hiddenKeys: prefs.hidden

    readonly property var allEntries: {
        const out = [];
        const seen = {};
        const src = SystemTray.items.values;
        for (let i = 0; i < src.length; i++) {
            const it = src[i];
            if (!it)
                continue;
            if (root.hidePassive && it.status === Status.Passive)
                continue;
            let k = root.keyOf(it);
            if (seen[k] !== undefined) {
                seen[k]++;
                k = k + "#" + seen[k];
            } else {
                seen[k] = 1;
            }
            out.push({
                "key": k,
                "item": it
            });
        }
        return out;
    }

    readonly property var manualHidden: allEntries.filter(e => root.hiddenKeys.indexOf(e.key) !== -1)
    readonly property var shownCandidates: allEntries.filter(e => root.hiddenKeys.indexOf(e.key) === -1)

    // Auto-overflow: how many icons fit inside maxWidth.
    readonly property int rawSlots: Math.max(1, Math.floor((maxWidth - 2 * sideInset + iconSpacing) / pitch))
    readonly property bool showOverflowButton: alwaysShowOverflow || manualHidden.length > 0 || shownCandidates.length > rawSlots
    readonly property int barSlots: Math.max(1, rawSlots - (showOverflowButton ? 1 : 0))
    readonly property var barEntries: shownCandidates.slice(0, barSlots)
    readonly property var overflowEntries: {
        const onBar = {};
        for (let i = 0; i < barEntries.length; i++)
            onBar[barEntries[i].key] = true;
        return allEntries.filter(e => !onBar[e.key]);
    }

    // ---------------------------------------------------------- frame sizing
    readonly property int cellCount: barEntries.length + (showOverflowButton ? 1 : 0)
    readonly property real contentWidth: cellCount > 0 ? cellCount * iconSize + (cellCount - 1) * iconSpacing : 0
    readonly property real frameWidth: contentWidth + 2 * sideInset

    visible: !hideWhenEmpty || cellCount > 0
    width: frameWidth
    height: frameTop + frameHeight
    Behavior on width {
        NumberAnimation {
            duration: 140
            easing.type: Easing.OutCubic
        }
    }

    // ================================================================ state
    property var menuItem: null
    property string menuKey: ""
    property var stack: []               // submenu entry stack (QsMenuEntry objects)
    property var hoverItem: null
    property var hoverCell: null
    property double overflowClosedAt: 0
    readonly property bool menuItemHidden: hiddenKeys.indexOf(menuKey) !== -1

    onAllEntriesChanged: {
        if (menuPopup.visible && menuItem && !allEntries.some(e => e.item === menuItem))
            menuPopup.visible = false;
    }
    onShowOverflowButtonChanged: {
        if (!showOverflowButton)
            overflowPopup.visible = false;
    }

    // ---------------------------------------------------- persisted hide list
    FileView {
        id: store
        path: Quickshell.stateDir + "/systray.json"
        watchChanges: true
        onFileChanged: reload()
        onAdapterUpdated: writeAdapter()
        onLoadFailed: error => {
            if (error === FileViewError.FileNotFound)
                writeAdapter();
        }
        adapter: JsonAdapter {
            id: prefs
            property list<string> hidden: []
        }
    }

    function setHidden(key, hide) {
        if (!key)
            return;
        const cur = root.hiddenKeys.slice();
        const i = cur.indexOf(key);
        if (hide && i === -1)
            cur.push(key);
        else if (!hide && i !== -1)
            cur.splice(i, 1);
        else
            return;
        prefs.hidden = cur;
    }

    // ============================================================== actions
    function openMenu(item, anchorItem) {
        if (!item || !anchorItem)
            return;
        tip.visible = false;
        tipTimer.stop();
        overflowPopup.visible = false;
        menuPopup.visible = false;
        root.stack = [];
        root.menuItem = item;
        root.menuKey = root.keyFor(item);
        menuPopup.anchor.item = anchorItem;
        menuPopup.visible = true;
    }

    // Items that don't export a DBusMenu: ask the app for its own context menu.
    function fallbackContextMenu(itemId, gx, gy) {
        const script = ['ITEMS=$(dbus-send --session --print-reply --dest=org.kde.StatusNotifierWatcher /StatusNotifierWatcher org.freedesktop.DBus.Properties.Get string:org.kde.StatusNotifierWatcher string:RegisteredStatusNotifierItems 2>/dev/null)', 'while IFS= read -r line; do', '  line="${line#*\\\"}"', '  line="${line%\\\"*}"', '  [ -z "$line" ] && continue', '  BUS="${line%%/*}"', '  OBJ="/${line#*/}"', '  ID=$(dbus-send --session --print-reply --dest="$BUS" "$OBJ" org.freedesktop.DBus.Properties.Get string:org.kde.StatusNotifierItem string:Id 2>/dev/null | grep -oP "(?<=\\\")(.*?)(?=\\\")" | tail -1)', '  if [ "$ID" = "$1" ]; then', '    dbus-send --session --type=method_call --dest="$BUS" "$OBJ" org.kde.StatusNotifierItem.ContextMenu int32:"$2" int32:"$3"', '    exit 0', '  fi', 'done <<< "$ITEMS"',].join("\n");
        Quickshell.execDetached(["bash", "-c", script, "_", itemId, String(gx), String(gy)]);
    }

    function handleClick(item, cell, mouse, anchorItem) {
        if (!item)
            return;
        if (mouse.button === Qt.MiddleButton) {
            item.secondaryActivate();
            return;
        }
        if (mouse.button === Qt.RightButton) {
            if (item.hasMenu) {
                openMenu(item, anchorItem);
            } else {
                const gp = cell.mapToGlobal(mouse.x, mouse.y);
                fallbackContextMenu(item.id, Math.round(gp.x), Math.round(gp.y));
            }
            return;
        }
        if (!item.onlyMenu) {
            item.activate();
            return;
        }
        if (item.hasMenu)
            openMenu(item, anchorItem);
    }

    function handleWheel(item, wheel) {
        if (!item)
            return;
        if (wheel.angleDelta.y !== 0)
            item.scroll(wheel.angleDelta.y, false);
        if (wheel.angleDelta.x !== 0)
            item.scroll(wheel.angleDelta.x, true);
    }

    function toggleOverflow() {
        if (overflowPopup.visible) {
            overflowPopup.visible = false;
            return;
        }
        // A click on the chevron while the popup is open first dismisses it via
        // the focus grab; don't let that same click re-open it.
        if (Date.now() - root.overflowClosedAt < 250)
            return;
        tip.visible = false;
        tipTimer.stop();
        menuPopup.visible = false;
        overflowPopup.visible = true;
    }

    function hoverStart(cell, item) {
        root.hoverCell = cell;
        root.hoverItem = item;
        tipTimer.restart();
    }

    function hoverEnd(cell) {
        if (root.hoverCell !== cell)
            return;
        root.hoverCell = null;
        tipTimer.stop();
        tip.visible = false;
    }

    // ============================================================ icon glyph
    // Self-contained (inline components can't see the outer file's ids).
    component TrayGlyph: Item {
        id: glyph
        property var trayItem: null
        property real size: 14
        property bool tint: false
        property color tintColor: "#36F8EC"
        property color letterColor: "#36F8EC"
        property string fontFamily: ""

        implicitWidth: size
        implicitHeight: size

        // Same normalisation DMS does: Quickshell hands out
        // "image://icon/<name>?path=<dir>" for themed icons that live in an
        // app-provided directory, which Image can't resolve on its own.
        function sourceFor(item) {
            const icon = item ? item.icon : "";
            if (typeof icon !== "string" || icon === "")
                return "";
            if (icon.includes("?path=")) {
                const split = icon.split("?path=");
                if (split.length !== 2)
                    return icon;
                const name = split[0];
                const path = split[1];
                let fileName = name.substring(name.lastIndexOf("/") + 1);
                if (fileName.startsWith("dropboxstatus"))
                    fileName = "hicolor/16x16/status/" + fileName;
                return "file://" + path + "/" + fileName;
            }
            if (icon.startsWith("/") && !icon.startsWith("file://"))
                return "file://" + icon;
            return icon;
        }

        IconImage {
            id: img
            anchors.centerIn: parent
            width: glyph.size
            height: glyph.size
            source: glyph.sourceFor(glyph.trayItem)
            asynchronous: true
            smooth: true
            mipmap: true
            visible: status === Image.Ready
            layer.enabled: glyph.tint
            layer.effect: MultiEffect {
                saturation: -1.0
                colorization: 1.0
                colorizationColor: glyph.tintColor
            }
        }

        Text {
            anchors.centerIn: parent
            visible: !img.visible
            text: (glyph.trayItem && glyph.trayItem.id) ? glyph.trayItem.id.charAt(0).toUpperCase() : "?"
            color: glyph.letterColor
            font.family: glyph.fontFamily
            font.pixelSize: Math.max(8, glyph.size - 4)
            font.bold: true
        }
    }

    // Popup background with 45° cut corners (top-left and bottom-right).
    // Self-contained like TrayGlyph: everything comes in through properties.
    component CutFrame: Item {
        id: cf
        property real cut: 12
        property color fillColor: "#f01a1030"
        property color lineColor: "#36F8EC"
        property real lineWidth: 1
        // inset by half the stroke so the outline isn't clipped by the window edge
        readonly property real o: lineWidth / 2

        Shape {
            anchors.fill: parent
            layer.enabled: true
            layer.samples: 4

            ShapePath {
                strokeColor: cf.lineColor
                strokeWidth: cf.lineWidth
                fillColor: cf.fillColor
                joinStyle: ShapePath.MiterJoin
                startX: cf.o + cf.cut
                startY: cf.o
                PathLine {
                    x: cf.width - cf.o
                    y: cf.o
                }
                PathLine {
                    x: cf.width - cf.o
                    y: cf.height - cf.o - cf.cut
                }
                PathLine {
                    x: cf.width - cf.o - cf.cut
                    y: cf.height - cf.o
                }
                PathLine {
                    x: cf.o
                    y: cf.height - cf.o
                }
                PathLine {
                    x: cf.o
                    y: cf.o + cf.cut
                }
                PathLine {
                    x: cf.o + cf.cut
                    y: cf.o
                }
            }
        }
    }

    // ================================================================ frame
    Item {
        id: frame
        // 1px larger on every side so the outline isn't clipped in half at the edge
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
                strokeColor: root.borderColor
                strokeWidth: 1
                fillColor: root.fillColor
                joinStyle: ShapePath.MiterJoin

                // bottom-left -> top-left is offset +slant in x, same on the right.
                startX: 0
                startY: root.frameHeight
                PathLine {
                    x: root.slant
                    y: 0
                }
                PathLine {
                    x: root.width
                    y: 0
                }
                PathLine {
                    x: root.width - root.slant
                    y: root.frameHeight
                }
                PathLine {
                    x: 0
                    y: root.frameHeight
                }
            }
        }
    }

    // ================================================================ icons
    Row {
        id: cells
        x: root.sideInset
        y: root.frameTop + (root.frameHeight - root.iconSize) / 2
        spacing: root.iconSpacing

        // ---- visible tray icons ----
        Repeater {
            model: ScriptModel {
                values: root.barEntries
                objectProp: "key"
            }

            delegate: Item {
                id: cell
                required property var modelData
                readonly property var trayItem: modelData.item

                width: root.iconSize
                height: root.iconSize

                Rectangle {
                    anchors.fill: parent
                    color: area.containsMouse ? root.hoverFill : "transparent"
                    border.width: area.containsMouse ? 1 : 0
                    border.color: root.borderColor
                }

                TrayGlyph {
                    anchors.fill: parent
                    trayItem: cell.trayItem
                    size: root.iconSize
                    tint: root.tintIcons
                    tintColor: root.tintColor
                    letterColor: root.iconColor
                    fontFamily: root.fontFamily
                }

                MouseArea {
                    id: area
                    anchors.fill: parent
                    hoverEnabled: true
                    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                    cursorShape: Qt.PointingHandCursor
                    onEntered: root.hoverStart(cell, cell.trayItem)
                    onExited: root.hoverEnd(cell)
                    onClicked: mouse => root.handleClick(cell.trayItem, cell, mouse, cell)
                    onWheel: wheel => root.handleWheel(cell.trayItem, wheel)
                }
            }
        }

        // ---- overflow chevron, right-most ----
        Item {
            id: chevronCell
            visible: root.showOverflowButton
            width: root.iconSize
            height: root.iconSize

            Rectangle {
                anchors.fill: parent
                color: chevronArea.containsMouse ? root.hoverFill : "transparent"
                border.width: (chevronArea.containsMouse || overflowPopup.visible) ? 1 : 0
                border.color: root.borderColor
            }

            Shape {
                anchors.centerIn: parent
                width: 10
                height: 6
                rotation: overflowPopup.visible ? 180 : 0
                Behavior on rotation {
                    NumberAnimation {
                        duration: 120
                    }
                }

                ShapePath {
                    strokeColor: root.manualHidden.length > 0 || overflowPopup.visible ? root.accentColor : root.iconColor
                    strokeWidth: 1.6
                    fillColor: "transparent"
                    capStyle: ShapePath.FlatCap
                    joinStyle: ShapePath.MiterJoin
                    startX: 0
                    startY: 0
                    PathLine {
                        x: 5
                        y: 5
                    }
                    PathLine {
                        x: 10
                        y: 0
                    }
                }
            }

            MouseArea {
                id: chevronArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: root.toggleOverflow()
            }
        }
    }

    // ============================================================== tooltip
    Timer {
        id: tipTimer
        interval: 450
        onTriggered: {
            if (root.hoverCell && root.hoverItem && !menuPopup.visible && !overflowPopup.visible) {
                tip.anchor.item = root.hoverCell;
                tip.visible = true;
            }
        }
    }

    PopupWindow {
        id: tip
        visible: false
        color: "transparent"
        implicitWidth: tipColumn.implicitWidth + 2 * root.cutSize
        implicitHeight: tipColumn.implicitHeight + 12
        anchor.edges: Edges.Bottom
        anchor.gravity: Edges.Bottom
        anchor.adjustment: PopupAdjustment.Slide
        anchor.margins.bottom: root.popupGap

        CutFrame {
            anchors.fill: parent
            cut: root.cutSize
            fillColor: root.menuBackground
            lineColor: root.borderColor

            Column {
                id: tipColumn
                anchors.centerIn: parent
                spacing: 1

                Text {
                    text: root.titleOf(root.hoverItem)
                    color: root.menuText
                    font.family: root.fontFamily
                    font.pixelSize: 12
                }
                Text {
                    visible: text !== ""
                    text: root.hoverItem ? (root.hoverItem.tooltipDescription || "") : ""
                    color: root.menuDim
                    font.family: root.fontFamily
                    font.pixelSize: 11
                }
            }
        }
    }

    // ============================================================ context menu
    QsMenuOpener {
        id: rootOpener
        menu: root.menuItem ? root.menuItem.menu : null
    }

    QsMenuOpener {
        id: subOpener
        menu: root.stack.length > 0 ? root.stack[root.stack.length - 1] : null
    }

    Timer {
        id: closeTimer
        interval: 60
        onTriggered: menuPopup.visible = false
    }

    PopupWindow {
        id: menuPopup
        visible: false
        color: "transparent"
        grabFocus: true
        implicitWidth: root.menuWidth
        implicitHeight: Math.min(root.menuMaxHeight, menuColumn.implicitHeight + 2 * root.cutSize + 2)
        anchor.edges: Edges.Bottom
        anchor.gravity: Edges.Bottom
        anchor.adjustment: PopupAdjustment.Slide
        anchor.margins.bottom: root.popupGap

        onVisibleChanged: {
            if (!visible)
                root.stack = [];
        }

        CutFrame {
            anchors.fill: parent
            cut: root.cutSize
            fillColor: root.menuBackground
            lineColor: root.borderColor
            focus: true

            Keys.onEscapePressed: {
                if (root.stack.length > 0)
                    root.stack = root.stack.slice(0, -1);
                else
                    menuPopup.visible = false;
            }

            Flickable {
                id: menuFlick
                anchors.fill: parent
                anchors.leftMargin: root.menuMargin
                anchors.rightMargin: root.menuMargin
                anchors.topMargin: root.cutSize
                anchors.bottomMargin: root.cutSize
                contentWidth: width
                contentHeight: menuColumn.implicitHeight
                clip: true
                boundsBehavior: Flickable.StopAtBounds
                interactive: contentHeight > height

                Column {
                    id: menuColumn
                    width: menuFlick.width
                    spacing: 0

                    // --- app title (root level only) ---
                    Item {
                        visible: root.stack.length === 0
                        width: parent.width
                        height: root.rowHeight

                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: 8
                            anchors.right: parent.right
                            anchors.rightMargin: 8
                            anchors.verticalCenter: parent.verticalCenter
                            text: root.titleOf(root.menuItem)
                            color: root.menuDim
                            font.family: root.fontFamily
                            font.pixelSize: 11
                            elide: Text.ElideMiddle
                        }
                    }

                    // --- hide / show toggle (root level only) ---
                    Rectangle {
                        visible: root.stack.length === 0
                        width: parent.width
                        height: root.rowHeight
                        color: toggleArea.containsMouse ? root.hoverFill : "transparent"

                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: 8
                            anchors.verticalCenter: parent.verticalCenter
                            text: root.menuItemHidden ? "Show in tray" : "Hide from tray"
                            color: root.accentColor
                            font.family: root.fontFamily
                            font.pixelSize: 12
                        }

                        MouseArea {
                            id: toggleArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                root.setHidden(root.menuKey, !root.menuItemHidden);
                                menuPopup.visible = false;
                            }
                        }
                    }

                    Rectangle {
                        visible: root.stack.length === 0
                        width: parent.width
                        height: 1
                        color: root.borderColor
                        opacity: 0.5
                    }

                    // --- back row (inside a submenu) ---
                    Rectangle {
                        visible: root.stack.length > 0
                        width: parent.width
                        height: root.rowHeight
                        color: backArea.containsMouse ? root.hoverFill : "transparent"

                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: 8
                            anchors.verticalCenter: parent.verticalCenter
                            text: "‹  Back"
                            color: root.menuText
                            font.family: root.fontFamily
                            font.pixelSize: 12
                        }

                        MouseArea {
                            id: backArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: root.stack = root.stack.slice(0, -1)
                        }
                    }

                    Rectangle {
                        visible: root.stack.length > 0
                        width: parent.width
                        height: 1
                        color: root.borderColor
                        opacity: 0.5
                    }

                    // --- the app's own DBusMenu entries ---
                    Repeater {
                        model: root.stack.length > 0 ? subOpener.children : rootOpener.children

                        delegate: Rectangle {
                            id: entryRow
                            required property var modelData
                            readonly property var entry: modelData
                            readonly property bool isSep: entry ? entry.isSeparator : false

                            width: menuColumn.width
                            height: isSep ? 7 : root.rowHeight
                            color: (!isSep && entryArea.containsMouse && !!entry && entry.enabled) ? root.hoverFill : "transparent"

                            // separator line
                            Rectangle {
                                visible: entryRow.isSep
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                height: 1
                                color: root.borderColor
                                opacity: 0.35
                            }

                            MouseArea {
                                id: entryArea
                                anchors.fill: parent
                                hoverEnabled: true
                                enabled: !entryRow.isSep && !!entryRow.entry && entryRow.entry.enabled
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    const e = entryRow.entry;
                                    if (!e || e.isSeparator)
                                        return;
                                    if (e.hasChildren) {
                                        root.stack = root.stack.concat([e]);
                                        return;
                                    }
                                    e.triggered();
                                    closeTimer.restart();
                                }
                            }

                            Row {
                                visible: !entryRow.isSep
                                anchors.left: parent.left
                                anchors.leftMargin: 8
                                anchors.right: parent.right
                                anchors.rightMargin: 8
                                anchors.verticalCenter: parent.verticalCenter
                                spacing: 6

                                // check box / radio button (QsMenuButtonType: 0 none, 1 check, 2 radio)
                                Rectangle {
                                    visible: !!entryRow.entry && entryRow.entry.buttonType !== 0
                                    width: 12
                                    height: 12
                                    anchors.verticalCenter: parent.verticalCenter
                                    radius: (entryRow.entry && entryRow.entry.buttonType === 2) ? 6 : 0
                                    color: "transparent"
                                    border.width: 1
                                    border.color: root.borderColor

                                    Rectangle {
                                        anchors.centerIn: parent
                                        width: 6
                                        height: 6
                                        radius: parent.radius > 0 ? 3 : 0
                                        color: root.accentColor
                                        visible: !!entryRow.entry && entryRow.entry.checkState === 2   // Qt.Checked
                                    }
                                }

                                Image {
                                    visible: !!entryRow.entry && entryRow.entry.icon !== ""
                                    width: 14
                                    height: 14
                                    anchors.verticalCenter: parent.verticalCenter
                                    source: entryRow.entry ? entryRow.entry.icon : ""
                                    sourceSize.width: 14
                                    sourceSize.height: 14
                                    fillMode: Image.PreserveAspectFit
                                    smooth: true
                                }

                                Text {
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: parent.width - x - (entryRow.entry && entryRow.entry.hasChildren ? 14 : 0)
                                    text: entryRow.entry ? entryRow.entry.text : ""
                                    color: (entryRow.entry && entryRow.entry.enabled) ? root.menuText : root.menuDim
                                    font.family: root.fontFamily
                                    font.pixelSize: 12
                                    elide: Text.ElideRight
                                }
                            }

                            Text {
                                visible: !entryRow.isSep && !!entryRow.entry && entryRow.entry.hasChildren
                                anchors.right: parent.right
                                anchors.rightMargin: 8
                                anchors.verticalCenter: parent.verticalCenter
                                text: "›"
                                color: root.menuText
                                font.family: root.fontFamily
                                font.pixelSize: 14
                            }
                        }
                    }
                }
            }
        }
    }

    // ============================================================ overflow popup
    PopupWindow {
        id: overflowPopup
        visible: false
        color: "transparent"
        grabFocus: true
        implicitWidth: 220
        implicitHeight: Math.min(root.menuMaxHeight, overflowColumn.implicitHeight + 2 * root.cutSize + 2)
        anchor.item: chevronCell
        anchor.edges: Edges.Bottom
        anchor.gravity: Edges.Bottom
        anchor.adjustment: PopupAdjustment.Slide
        anchor.margins.bottom: root.popupGap

        onVisibleChanged: {
            if (!visible)
                root.overflowClosedAt = Date.now();
        }

        CutFrame {
            anchors.fill: parent
            cut: root.cutSize
            fillColor: root.menuBackground
            lineColor: root.borderColor
            focus: true
            Keys.onEscapePressed: overflowPopup.visible = false

            Flickable {
                id: overflowFlick
                anchors.fill: parent
                anchors.leftMargin: root.menuMargin
                anchors.rightMargin: root.menuMargin
                anchors.topMargin: root.cutSize
                anchors.bottomMargin: root.cutSize
                contentWidth: width
                contentHeight: overflowColumn.implicitHeight
                clip: true
                boundsBehavior: Flickable.StopAtBounds
                interactive: contentHeight > height

                Column {
                    id: overflowColumn
                    width: overflowFlick.width
                    spacing: 0

                    Item {
                        visible: root.overflowEntries.length === 0
                        width: parent.width
                        height: root.rowHeight

                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: 8
                            anchors.verticalCenter: parent.verticalCenter
                            text: "Nothing hidden"
                            color: root.menuDim
                            font.family: root.fontFamily
                            font.pixelSize: 12
                        }
                    }

                    Repeater {
                        model: ScriptModel {
                            values: root.overflowEntries
                            objectProp: "key"
                        }

                        delegate: Rectangle {
                            id: ovRow
                            required property var modelData
                            readonly property var trayItem: modelData.item
                            readonly property bool pinnedHidden: root.hiddenKeys.indexOf(modelData.key) !== -1

                            width: overflowColumn.width
                            height: root.rowHeight + 2
                            color: ovArea.containsMouse ? root.hoverFill : "transparent"

                            MouseArea {
                                id: ovArea
                                anchors.fill: parent
                                hoverEnabled: true
                                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                                cursorShape: Qt.PointingHandCursor
                                onClicked: mouse => {
                                    // The overflow popup closes first; menus anchor to the chevron.
                                    const it = ovRow.trayItem;
                                    if (!it)
                                        return;
                                    if (mouse.button !== Qt.MiddleButton)
                                        overflowPopup.visible = false;
                                    root.handleClick(it, ovRow, mouse, chevronCell);
                                }
                                onWheel: wheel => root.handleWheel(ovRow.trayItem, wheel)
                            }

                            TrayGlyph {
                                x: 8
                                anchors.verticalCenter: parent.verticalCenter
                                trayItem: ovRow.trayItem
                                size: root.iconSize
                                tint: root.tintIcons
                                tintColor: root.tintColor
                                letterColor: root.iconColor
                                fontFamily: root.fontFamily
                            }

                            Text {
                                anchors.left: parent.left
                                anchors.leftMargin: 8 + root.iconSize + 8
                                anchors.right: parent.right
                                anchors.rightMargin: ovRow.pinnedHidden ? 28 : 8
                                anchors.verticalCenter: parent.verticalCenter
                                text: root.titleOf(ovRow.trayItem)
                                color: root.menuText
                                font.family: root.fontFamily
                                font.pixelSize: 12
                                elide: Text.ElideRight
                            }

                            // "put back on the bar" button (manually hidden items only)
                            Rectangle {
                                visible: ovRow.pinnedHidden
                                anchors.right: parent.right
                                anchors.rightMargin: 6
                                anchors.verticalCenter: parent.verticalCenter
                                width: 18
                                height: 18
                                color: showArea.containsMouse ? root.hoverFill : "transparent"
                                border.width: 1
                                border.color: root.accentColor

                                Text {
                                    anchors.centerIn: parent
                                    text: "+"
                                    color: root.accentColor
                                    font.family: root.fontFamily
                                    font.pixelSize: 13
                                    font.bold: true
                                }

                                MouseArea {
                                    id: showArea
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: root.setHidden(ovRow.modelData.key, false)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
