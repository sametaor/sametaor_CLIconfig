import QtQuick
import Quickshell
import Quickshell.Io

// Wi-Fi button + menu, driven by NetworkManager's nmcli.
//   needs:  networkmanager (nmcli)   optional: nm-connection-editor
BarBox {
    id: box

    property bool radioOn: true
    property string activeSsid: ""
    property int activeSignal: 0
    property var networks: []          // [{ ssid, signal, security, saved, active }]
    property var savedNames: []
    property string pendingSsid: ""    // secured network waiting for a password
    property string status: ""         // last error from nmcli
    property bool busy: false

    readonly property bool connected: activeSsid !== ""
    readonly property int level: !connected ? 0 : (activeSignal >= 67 ? 3 : (activeSignal >= 34 ? 2 : 1))

    active: popup.visible
    onClicked: mouse => {
        if (mouse.button === Qt.LeftButton)
            popup.toggle();
    }

    // ---------------------------------------------------------------- parsing
    // nmcli -t escapes ':' inside values as '\:'
    function splitTerse(line) {
        const parts = [];
        let cur = "";
        for (let i = 0; i < line.length; i++) {
            const c = line[i];
            if (c === "\\" && i + 1 < line.length) {
                cur += line[i + 1];
                i++;
            } else if (c === ":") {
                parts.push(cur);
                cur = "";
            } else {
                cur += c;
            }
        }
        parts.push(cur);
        return parts;
    }

    function parse(text) {
        let section = "";
        let radio = "enabled";
        const saved = [];
        const best = {};
        let active = "";
        let activeSig = 0;
        const lines = text.split("\n");
        for (let i = 0; i < lines.length; i++) {
            const line = lines[i];
            if (line === "")
                continue;
            if (line.startsWith("@")) {
                section = line;
                continue;
            }
            if (section === "@radio") {
                radio = line.trim();
            } else if (section === "@saved") {
                const f = splitTerse(line);
                if (f.length >= 2 && (f[1] === "802-11-wireless" || f[1] === "wifi"))
                    saved.push(f[0]);
            } else if (section === "@list") {
                const f = splitTerse(line);   // IN-USE, SSID, SIGNAL, SECURITY
                if (f.length < 4 || f[1] === "")
                    continue;
                const sig = parseInt(f[2]) || 0;
                const isActive = f[0] === "*";
                if (isActive) {
                    active = f[1];
                    activeSig = sig;
                }
                const cur = best[f[1]];
                if (!cur || isActive || (!cur.active && sig > cur.signal)) {
                    best[f[1]] = {
                        "ssid": f[1],
                        "signal": sig,
                        "security": f[3],
                        "active": isActive || (cur ? cur.active : false)
                    };
                }
            }
        }
        const list = Object.keys(best).map(k => best[k]);
        list.forEach(n => n.saved = saved.indexOf(n.ssid) !== -1);
        list.sort((a, b) => (b.active - a.active) || (b.signal - a.signal));
        box.radioOn = radio === "enabled";
        box.savedNames = saved;
        box.networks = list;
        box.activeSsid = active;
        box.activeSignal = activeSig;
    }

    function refresh() {
        scanner.running = true;
    }

    // ---------------------------------------------------------------- actions
    function run(label, cmd) {
        if (connector.running)
            return;
        box.busy = true;
        box.status = "";
        connector.label = label;
        connector.command = cmd;
        connector.running = true;
    }

    function activate(n) {
        if (n.active) {
            run("Disconnect", ["nmcli", "connection", "down", "id", n.ssid]);
        } else if (n.saved || n.security === "") {
            box.pendingSsid = "";
            run("Connect", n.saved ? ["nmcli", "connection", "up", "id", n.ssid] : ["nmcli", "device", "wifi", "connect", n.ssid]);
        } else {
            box.pendingSsid = (box.pendingSsid === n.ssid) ? "" : n.ssid;
        }
    }

    function connectWithPassword(ssid, password) {
        if (password === "")
            return;
        box.pendingSsid = "";
        run("Connect", ["nmcli", "device", "wifi", "connect", ssid, "password", password]);
    }

    BarIcon {
        kind: "wifi"
        color: box.accent
        level: box.level
        flag: !box.radioOn
    }

    Process {
        id: scanner
        command: ["sh", "-c", "echo @radio; nmcli -t -f WIFI radio 2>/dev/null; " + "echo @saved; nmcli -t -f NAME,TYPE connection show 2>/dev/null; " + "echo @list; nmcli -t -f IN-USE,SSID,SIGNAL,SECURITY device wifi list 2>/dev/null"]
        stdout: StdioCollector {
            onStreamFinished: box.parse(text)
        }
    }

    Process {
        id: connector
        property string label: ""
        stderr: StdioCollector {
            id: errOut
        }
        onExited: (code, status) => {
            box.busy = false;
            if (code !== 0)
                box.status = (errOut.text.trim() || (connector.label + " failed")).split("\n")[0];
            box.refresh();
        }
    }

    Timer {
        interval: 15000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: box.refresh()
    }

    // after asking NetworkManager to rescan, re-read the list once it settles
    Timer {
        id: rescanTimer
        interval: 2500
        onTriggered: box.refresh()
    }

    BarPopup {
        id: popup
        target: box
        popupWidth: 290
        onVisibleChanged: {
            if (visible) {
                box.pendingSsid = "";
                Quickshell.execDetached(["nmcli", "device", "wifi", "rescan"]);
                box.refresh();
                rescanTimer.restart();
            }
        }

        PopupRow {
            text: box.radioOn ? "Wi-Fi: on" : "Wi-Fi: off"
            detail: box.busy ? "working..." : (box.radioOn ? "turn off" : "turn on")
            accent: true
            onClicked: {
                Quickshell.execDetached(["nmcli", "radio", "wifi", box.radioOn ? "off" : "on"]);
                rescanTimer.restart();
            }
        }
        PopupRow {
            visible: box.status !== ""
            clickable: false
            dim: true
            text: box.status
        }
        PopupRow {
            separator: true
        }
        PopupRow {
            visible: box.radioOn && box.networks.length === 0
            clickable: false
            dim: true
            text: "No networks found"
        }
        Repeater {
            model: box.radioOn ? box.networks : []
            delegate: Column {
                id: netItem
                required property var modelData
                width: parent.width

                PopupRow {
                    text: netItem.modelData.ssid
                    detail: (netItem.modelData.security === "" ? "open" : netItem.modelData.security.split(" ")[0]) + "  " + netItem.modelData.signal + "%"
                    marked: netItem.modelData.active
                    onClicked: box.activate(netItem.modelData)
                }

                // inline password entry for secured networks we don't know yet
                Item {
                    visible: box.pendingSsid === netItem.modelData.ssid
                    width: parent.width
                    height: 30

                    Rectangle {
                        anchors.fill: parent
                        anchors.leftMargin: 16
                        anchors.rightMargin: 8
                        anchors.topMargin: 3
                        anchors.bottomMargin: 3
                        color: "#40000000"
                        border.width: 1
                        border.color: box.borderColor

                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: 6
                            anchors.verticalCenter: parent.verticalCenter
                            visible: pw.text === ""
                            text: "password, then Enter"
                            color: "#8a7fa8"
                            font.family: box.fontFamily
                            font.pixelSize: 11
                        }

                        TextInput {
                            id: pw
                            anchors.fill: parent
                            anchors.leftMargin: 6
                            anchors.rightMargin: 6
                            verticalAlignment: TextInput.AlignVCenter
                            echoMode: TextInput.Password
                            color: "#EFEEFF"
                            font.family: box.fontFamily
                            font.pixelSize: 12
                            clip: true
                            selectByMouse: true
                            onVisibleChanged: {
                                if (visible)
                                    forceActiveFocus();
                                else
                                    text = "";
                            }
                            onAccepted: {
                                box.connectWithPassword(netItem.modelData.ssid, text);
                                text = "";
                            }
                        }
                    }
                }
            }
        }
        PopupRow {
            separator: true
        }
        PopupRow {
            text: "Rescan"
            onClicked: {
                Quickshell.execDetached(["nmcli", "device", "wifi", "rescan"]);
                rescanTimer.restart();
            }
        }
        PopupRow {
            text: "Advanced settings..."
            onClicked: {
                Quickshell.execDetached(["nm-connection-editor"]);
                popup.visible = false;
            }
        }
    }
}
