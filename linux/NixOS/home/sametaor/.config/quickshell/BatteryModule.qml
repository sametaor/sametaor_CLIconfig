import QtQuick
import Quickshell
import Quickshell.Services.UPower

// Battery button + menu. Only exists on machines with a laptop battery:
// on a desktop the box is hidden and the strip closes the gap.
BarBox {
    id: box

    // Debug switch: show the box even when no battery is detected (it will read 0%).
    // If the box appears with this on but shows 0%, Quickshell can't see a battery (UPower).
    property bool forceShow: false

    property real lowThreshold: 15     // % at which the box turns magenta (while discharging)

    readonly property var displayDev: UPower.displayDevice
    readonly property var laptopBattery: {
        const devs = UPower.devices.values;
        for (let i = 0; i < devs.length; i++) {
            if (devs[i].isLaptopBattery && devs[i].isPresent)
                return devs[i];
        }
        return null;
    }
    // DisplayDevice is UPower's combined view (correct for multi-battery laptops)
    readonly property var bat: (displayDev && displayDev.type === UPowerDeviceType.Battery && displayDev.isPresent) ? displayDev : laptopBattery
    readonly property bool present: bat !== null && bat !== undefined

    // Quickshell reports charge as 0..1; tolerate 0..100 too
    readonly property real percent: present ? Math.round(bat.percentage <= 1 ? bat.percentage * 100 : bat.percentage) : 0
    readonly property bool charging: present && bat.state === UPowerDeviceState.Charging
    readonly property bool full: present && bat.state === UPowerDeviceState.FullyCharged
    readonly property bool discharging: present && bat.state === UPowerDeviceState.Discharging

    visible: present || forceShow
    active: popup.visible
    alert: discharging && percent <= lowThreshold

    function fmt(sec) {
        if (!sec || sec <= 0)
            return "-";
        const h = Math.floor(sec / 3600);
        const m = Math.floor((sec % 3600) / 60);
        return h > 0 ? h + "h " + (m < 10 ? "0" : "") + m + "m" : m + "m";
    }

    function stateText() {
        if (charging)
            return "Charging";
        if (full)
            return "Full";
        if (discharging)
            return "Discharging";
        return "Idle";
    }

    onClicked: mouse => {
        if (mouse.button === Qt.LeftButton)
            popup.toggle();
    }

    BarIcon {
        kind: "battery"
        color: box.charging ? box.activeColor : box.accent
        level: box.percent / 100
        flag: box.charging
    }

    TextMetrics {
        id: widest
        text: "100%"
        font.family: box.fontFamily
        font.pixelSize: 10
        font.bold: true
    }
    Text {
        width: widest.width
        height: box.contentHeight
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
        text: box.percent + "%"
        color: box.charging ? box.activeColor : box.accent
        font.family: box.fontFamily
        font.pixelSize: 10
        font.bold: true
    }

    BarPopup {
        id: popup
        target: box
        popupWidth: 250

        PopupRow {
            text: "Battery"
            detail: box.percent + "%"
            clickable: false
            dim: true
        }
        PopupRow {
            text: "State"
            detail: box.stateText()
            clickable: false
        }
        PopupRow {
            visible: box.present && (box.charging || box.discharging)
            text: box.charging ? "Time to full" : "Time remaining"
            detail: box.present ? box.fmt(box.charging ? box.bat.timeToFull : box.bat.timeToEmpty) : ""
            clickable: false
        }
        PopupRow {
            visible: box.present && Math.abs(box.bat.changeRate) > 0.05
            text: "Power draw"
            detail: box.present ? Math.abs(box.bat.changeRate).toFixed(1) + " W" : ""
            clickable: false
        }
        PopupRow {
            visible: box.present && box.bat.healthSupported
            text: "Health"
            detail: box.present ? Math.round(box.bat.healthPercentage) + "%" : ""
            clickable: false
        }
        PopupRow {
            separator: true
        }
        PopupRow {
            text: "Power profile"
            clickable: false
            dim: true
        }
        Repeater {
            model: [{
                    "label": "Power saver",
                    "profile": PowerProfile.PowerSaver
                }, {
                    "label": "Balanced",
                    "profile": PowerProfile.Balanced
                }, {
                    "label": "Performance",
                    "profile": PowerProfile.Performance
                }]
            delegate: PopupRow {
                required property var modelData
                visible: modelData.profile !== PowerProfile.Performance || PowerProfiles.hasPerformanceProfile
                text: modelData.label
                marked: PowerProfiles.profile === modelData.profile
                onClicked: PowerProfiles.profile = modelData.profile
            }
        }
    }
}
