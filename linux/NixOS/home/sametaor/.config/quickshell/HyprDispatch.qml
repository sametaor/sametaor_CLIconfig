import QtQuick
import Quickshell.Io
import Quickshell.Hyprland

// Sends Hyprland dispatch requests in whichever syntax the running config uses.
// With a Lua config (hyprland.lua) Hyprland treats the dispatch string as the
// argument of hl.dispatch(...), so the old "workspace 2" text form is a syntax
// error there. With a classic hyprland.conf the old form is still right.
// `hyprctl status` reports which one is running ("configProvider: lua").
QtObject {
    id: root

    // "unknown" until detected (a fraction of a second after startup), then "lua" or "hyprlang"
    property string provider: "unknown"
    readonly property bool lua: provider === "lua"

    // Parse the output of `hyprctl status`
    function applyStatus(text) {
        const lines = String(text).split("\n");
        for (let i = 0; i < lines.length; i++) {
            const line = lines[i].trim();
            if (line.startsWith("configProvider:")) {
                root.provider = line.substring("configProvider:".length).trim() === "lua" ? "lua" : "hyprlang";
                return;
            }
        }
        // Older Hyprland has no `configProvider` line (and predates Lua configs)
        root.provider = "hyprlang";
    }

    // quote a string as a Lua string literal
    function luaStr(s) {
        return "\"" + String(s).replace(/\\/g, "\\\\").replace(/"/g, "\\\"").replace(/\n/g, "\\n") + "\"";
    }

    function focusWorkspace(id) {
        if (root.lua)
            Hyprland.dispatch("hl.dsp.focus({ workspace = " + luaStr(id) + " })");
        else
            Hyprland.dispatch("workspace " + id);
    }

    // `address` as reported by Hyprland; the 0x prefix is added if it's missing
    function focusWindow(address) {
        if (!address)
            return;
        const a = String(address).startsWith("0x") ? String(address) : "0x" + address;
        if (root.lua)
            Hyprland.dispatch("hl.dsp.focus({ window = " + luaStr("address:" + a) + " })");
        else
            Hyprland.dispatch("focuswindow address:" + a);
    }

    property Process detector: Process {
        command: ["hyprctl", "status"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.applyStatus(text)
        }
        // no hyprctl / not running under Hyprland: keep the classic syntax
        onExited: (code, status) => {
            if (code !== 0 && root.provider === "unknown")
                root.provider = "hyprlang";
        }
    }
}
