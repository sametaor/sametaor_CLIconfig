import QtQuick

// The row of button boxes at the right end of the bar:
//   [clipboard] [wifi] [sound] [battery - laptops only] [control panel]
// Boxes are parallelograms with the same slant, so they nest: spacing is
// (gap - slant), which keeps the horizontal distance between neighbouring
// slanted edges at exactly `gap` pixels.
Row {
    id: root

    property real slant: 15
    property real gap: 4

    spacing: gap - slant

    ClipboardModule {
    }
    WifiModule {
    }
    SoundModule {
    }
    BatteryModule {
    }
    ControlModule {
    }
}
