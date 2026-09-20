import QtQuick
import QtQuick.Shapes

// Tiny 14x14 line-art icons drawn as vector paths (no icon font needed).
//   kind: "clipboard" | "wifi" | "sound" | "battery" | "control"
//   level: wifi/sound = 0..3 lit arcs (sound uses 0..2), battery = 0..1 fill
//   flag:  wifi = offline slash, sound = muted, battery = charging bolt
Item {
    id: root

    property string kind: "clipboard"
    property color color: "#36F8EC"
    property real level: 0
    property bool flag: false
    property real lineWidth: 1.3
    readonly property color dimColor: Qt.rgba(color.r, color.g, color.b, 0.28)

    implicitWidth: 14
    implicitHeight: 14

    // ---------------------------------------------------------------- clipboard
    Shape {
        anchors.fill: parent
        visible: root.kind === "clipboard"
        layer.enabled: visible
        layer.samples: 4

        ShapePath {
            strokeColor: root.color
            strokeWidth: root.lineWidth
            fillColor: "transparent"
            capStyle: ShapePath.FlatCap
            joinStyle: ShapePath.MiterJoin
            PathSvg {
                path: "M5 2.5 H2.5 V12.5 H11.5 V2.5 H9 M5 7 H9 M5 9.5 H9"
            }
        }
        ShapePath {
            strokeColor: root.color
            strokeWidth: root.lineWidth
            fillColor: root.color
            joinStyle: ShapePath.MiterJoin
            PathSvg {
                path: "M5 1 H9 V4 H5 Z"
            }
        }
    }

    // --------------------------------------------------------------------- wifi
    Shape {
        anchors.fill: parent
        visible: root.kind === "wifi"
        layer.enabled: visible
        layer.samples: 4

        ShapePath {
            strokeColor: root.level >= 1 && !root.flag ? root.color : root.dimColor
            strokeWidth: root.lineWidth
            fillColor: "transparent"
            capStyle: ShapePath.FlatCap
            PathSvg {
                path: "M4.53 9.53 A3.5 3.5 0 0 1 9.47 9.53"
            }
        }
        ShapePath {
            strokeColor: root.level >= 2 && !root.flag ? root.color : root.dimColor
            strokeWidth: root.lineWidth
            fillColor: "transparent"
            capStyle: ShapePath.FlatCap
            PathSvg {
                path: "M2.4 7.4 A6.5 6.5 0 0 1 11.6 7.4"
            }
        }
        ShapePath {
            strokeColor: root.level >= 3 && !root.flag ? root.color : root.dimColor
            strokeWidth: root.lineWidth
            fillColor: "transparent"
            capStyle: ShapePath.FlatCap
            PathSvg {
                path: "M0.28 5.28 A9.5 9.5 0 0 1 13.72 5.28"
            }
        }
        ShapePath {
            strokeColor: "transparent"
            fillColor: root.flag ? root.dimColor : root.color
            PathSvg {
                path: "M6 11 H8 V13 H6 Z"
            }
        }
        // offline slash
        ShapePath {
            strokeColor: root.flag ? root.color : "transparent"
            strokeWidth: root.lineWidth
            fillColor: "transparent"
            capStyle: ShapePath.FlatCap
            PathSvg {
                path: "M2 12.5 L12 1.5"
            }
        }
    }

    // -------------------------------------------------------------------- sound
    Shape {
        anchors.fill: parent
        visible: root.kind === "sound"
        layer.enabled: visible
        layer.samples: 4

        ShapePath {
            strokeColor: root.color
            strokeWidth: root.lineWidth
            fillColor: root.color
            joinStyle: ShapePath.MiterJoin
            PathSvg {
                path: "M1.5 5 H4.5 L8 2 V12 L4.5 9 H1.5 Z"
            }
        }
        ShapePath {
            strokeColor: !root.flag && root.level >= 1 ? root.color : root.dimColor
            strokeWidth: root.lineWidth
            fillColor: "transparent"
            capStyle: ShapePath.FlatCap
            PathSvg {
                path: root.flag ? "" : "M9.93 4.7 A3 3 0 0 1 9.93 9.3"
            }
        }
        ShapePath {
            strokeColor: !root.flag && root.level >= 2 ? root.color : root.dimColor
            strokeWidth: root.lineWidth
            fillColor: "transparent"
            capStyle: ShapePath.FlatCap
            PathSvg {
                path: root.flag ? "" : "M11.54 2.79 A5.5 5.5 0 0 1 11.54 11.21"
            }
        }
        // muted cross
        ShapePath {
            strokeColor: root.flag ? root.color : "transparent"
            strokeWidth: root.lineWidth
            fillColor: "transparent"
            capStyle: ShapePath.FlatCap
            PathSvg {
                path: "M9.5 5 L13 9 M13 5 L9.5 9"
            }
        }
    }

    // ------------------------------------------------------------------ battery
    Shape {
        anchors.fill: parent
        visible: root.kind === "battery"
        layer.enabled: visible
        layer.samples: 4

        ShapePath {
            strokeColor: root.color
            strokeWidth: root.lineWidth
            fillColor: "transparent"
            joinStyle: ShapePath.MiterJoin
            PathSvg {
                path: "M1.5 3.5 H11.5 V10.5 H1.5 Z"
            }
        }
        ShapePath {
            strokeColor: "transparent"
            fillColor: root.color
            PathSvg {
                path: "M12 5.5 H13.5 V8.5 H12 Z"
            }
        }
        // charge level
        ShapePath {
            strokeColor: "transparent"
            fillColor: root.color
            PathSvg {
                path: "M3 5 H" + (3 + 7 * Math.max(0, Math.min(1, root.level))) + " V9 H3 Z"
            }
        }
        // charging bolt
        ShapePath {
            strokeColor: root.flag ? "#EFEEFF" : "transparent"
            strokeWidth: 1.1
            fillColor: "transparent"
            joinStyle: ShapePath.MiterJoin
            PathSvg {
                path: "M7.8 3.8 L5.2 7.2 H8 L5.8 10.2"
            }
        }
    }

    // ------------------------------------------------------------------ control
    Shape {
        anchors.fill: parent
        visible: root.kind === "control"
        layer.enabled: visible
        layer.samples: 4

        ShapePath {
            strokeColor: root.color
            strokeWidth: root.lineWidth
            fillColor: "transparent"
            joinStyle: ShapePath.MiterJoin
            PathSvg {
                path: "M2 2 H6 V6 H2 Z M8 2 H12 V6 H8 Z M2 8 H6 V12 H2 Z"
            }
        }
        ShapePath {
            strokeColor: root.color
            strokeWidth: root.lineWidth
            fillColor: root.color
            joinStyle: ShapePath.MiterJoin
            PathSvg {
                path: "M8 8 H12 V12 H8 Z"
            }
        }
    }
}
