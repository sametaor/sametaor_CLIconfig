import QtQuick
import QtQuick.Shapes

// The visual for the media flyout (see the concept): chamfered cover frame,
// title / artist / album / time, transport buttons, and a seekable progress
// bar with a hatched end-cap and a cut bottom-right corner.
// Pure Qt on purpose: all data comes in through properties and all actions go
// out as signals, so MediaFlyout.qml is the only file that talks to MPRIS.
Item {
    id: root

    implicitWidth: 420
    // controls row sits under the progress bar: barY + barH + 10 gap + 24 buttons + 16 margin
    implicitHeight: 216
    width: implicitWidth
    height: implicitHeight

    // ------------------------------------------------------------ data in
    property bool hasPlayer: false
    property string title: ""
    property string artist: ""
    property string album: ""
    property string artUrl: ""
    property string identity: ""
    property int playerIndex: 1
    property int playerCount: 1

    property real position: 0        // seconds
    property real length: 0          // seconds, 0 = unknown
    property bool playing: false

    property bool canPrevious: false
    property bool canNext: false
    property bool canToggle: false
    property bool canSeek: false
    property bool shuffleSupported: false
    property bool shuffle: false
    property bool loopSupported: false
    property int loopMode: 0         // 0 off, 1 playlist, 2 track

    // ----------------------------------------------------------- actions out
    signal previousRequested
    signal nextRequested
    signal toggleRequested
    signal shuffleRequested
    signal loopRequested
    signal cycleRequested
    signal seekRequested(real seconds)
    signal closeRequested

    // ------------------------------------------------------------- styling
    // Opaque on purpose: the corner masks over the cover art and the hatch use this
    // exact colour, so a translucent panel would show them as faint triangles.
    property color fillColor: "#1a1030"
    property color lineColor: "#36F8EC"
    property color accentColor: "#FEF709"
    property color textColor: "#EFEEFF"
    property color dimColor: "#8a7fa8"
    property color alertColor: "#f809c9"
    property string fontFamily: "Iosevka SciFi"

    // ------------------------------------------------------------ geometry
    readonly property real pad: 18
    readonly property real artSize: 100
    readonly property real artCut: 16
    readonly property real barY: 144
    readonly property real barH: 22
    readonly property real barCut: 10
    // The striped cap is the wedge under the top-left chamfer: it ends exactly where
    // the chamfer meets the top edge, and the fill starts right there (as in the concept).
    readonly property real barCap: barCut

    // End-cap stripes: same look as the slanted accent stripes on the left edge of
    // CyberBar.qml (2px wide, 45°, magenta, one every 8px).
    property color stripeColor: "#f809c9"
    property real stripeStep: 6
    property real stripeWidth: 2
    property real stripeGap: 3       // clear space between the chamfer and the first stripe
    readonly property real barW: width - 2 * pad

    // seeking state: while dragging, show the drag position instead of the player's
    property bool seeking: false
    property real dragFrac: 0
    readonly property real progress: length > 0 ? Math.max(0, Math.min(1, position / length)) : 0
    readonly property real shownFrac: seeking ? dragFrac : progress

    function fmt(sec) {
        if (!isFinite(sec) || sec < 0)
            return "--:--";
        const s = Math.floor(sec);
        const h = Math.floor(s / 3600);
        const m = Math.floor((s % 3600) / 60);
        const r = s % 60;
        const rr = (r < 10 ? "0" : "") + r;
        return h > 0 ? h + ":" + (m < 10 ? "0" : "") + m + ":" + rr : m + ":" + rr;
    }

    focus: true
    Keys.onEscapePressed: root.closeRequested()

    // ======================================================== outer frame
    CutFrame {
        anchors.fill: parent
        cut: 18
        fillColor: root.fillColor
        lineColor: root.lineColor
    }

    // which player, and click to switch when there are several
    Text {
        id: idLabel
        visible: root.hasPlayer
        anchors.right: parent.right
        anchors.rightMargin: root.pad
        y: 7
        text: root.identity.toUpperCase() + (root.playerCount > 1 ? "   " + root.playerIndex + "/" + root.playerCount + " ›" : "")
        color: idArea.containsMouse && root.playerCount > 1 ? root.accentColor : root.dimColor
        font.family: root.fontFamily
        font.pixelSize: 10
        font.bold: true

        MouseArea {
            id: idArea
            anchors.fill: parent
            anchors.margins: -3
            hoverEnabled: true
            enabled: root.playerCount > 1
            cursorShape: Qt.PointingHandCursor
            onClicked: root.cycleRequested()
        }
    }

    // ============================================================ cover art
    Item {
        id: art
        x: root.pad
        y: 26
        width: root.artSize
        height: root.artSize

        Item {
            anchors.fill: parent
            clip: true

            Hatch {
                anchors.fill: parent
                visible: cover.status !== Image.Ready
                color: "#2236F8EC"
                step: 8
            }
            Text {
                visible: cover.status !== Image.Ready
                anchors.centerIn: parent
                text: root.hasPlayer ? "NO COVER" : ""
                color: root.dimColor
                font.family: root.fontFamily
                font.pixelSize: 10
                font.bold: true
            }
            Image {
                id: cover
                anchors.fill: parent
                source: root.artUrl
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
                smooth: true
                sourceSize.width: 2 * root.artSize
                sourceSize.height: 2 * root.artSize
            }
        }

        // hide whatever sticks out past the chamfered top-left and bottom-right corners
        Shape {
            anchors.fill: parent
            preferredRendererType: Shape.CurveRenderer
            ShapePath {
                strokeColor: "transparent"
                fillColor: Qt.rgba(root.fillColor.r, root.fillColor.g, root.fillColor.b, 1)
                startX: -1
                startY: -1
                PathLine {
                    x: root.artCut + 1
                    y: -1
                }
                PathLine {
                    x: -1
                    y: root.artCut + 1
                }
                PathLine {
                    x: -1
                    y: -1
                }
            }
            ShapePath {
                strokeColor: "transparent"
                fillColor: Qt.rgba(root.fillColor.r, root.fillColor.g, root.fillColor.b, 1)
                startX: root.artSize - root.artCut - 1
                startY: root.artSize + 1
                PathLine {
                    x: root.artSize + 1
                    y: root.artSize - root.artCut - 1
                }
                PathLine {
                    x: root.artSize + 1
                    y: root.artSize + 1
                }
                PathLine {
                    x: root.artSize - root.artCut - 1
                    y: root.artSize + 1
                }
            }
        }

        // outline: square with the top-left and bottom-right corners cut
        Shape {
            anchors.fill: parent
            preferredRendererType: Shape.CurveRenderer
            ShapePath {
                strokeColor: root.lineColor
                strokeWidth: 1.5
                fillColor: "transparent"
                joinStyle: ShapePath.MiterJoin
                startX: root.artCut
                startY: 0
                PathLine {
                    x: root.artSize
                    y: 0
                }
                PathLine {
                    x: root.artSize
                    y: root.artSize - root.artCut
                }
                PathLine {
                    x: root.artSize - root.artCut
                    y: root.artSize
                }
                PathLine {
                    x: 0
                    y: root.artSize
                }
                PathLine {
                    x: 0
                    y: root.artCut
                }
                PathLine {
                    x: root.artCut
                    y: 0
                }
            }
        }
    }

    // ============================================================ text block
    Column {
        x: 134
        y: 22
        width: root.width - 134 - root.pad
        spacing: 1

        Text {
            width: parent.width
            text: root.title
            color: root.hasPlayer ? root.lineColor : root.dimColor
            font.family: root.fontFamily
            font.pixelSize: 20
            font.bold: true
            elide: Text.ElideRight
        }
        Text {
            width: parent.width
            text: root.artist
            color: root.textColor
            font.family: root.fontFamily
            font.pixelSize: 15
            font.italic: true
            elide: Text.ElideRight
        }
        Text {
            width: parent.width
            text: root.album
            color: root.dimColor
            font.family: root.fontFamily
            font.pixelSize: 15
            font.italic: true
            elide: Text.ElideRight
        }
    }

    // elapsed / total time
    Text {
        x: 134
        y: 104
        height: 22
        verticalAlignment: Text.AlignVCenter
        text: root.hasPlayer ? root.fmt(root.seeking ? root.dragFrac * root.length : root.position) + " / " + (root.length > 0 ? root.fmt(root.length) : "--:--") : "0:00 / 0:00"
        color: root.hasPlayer ? root.accentColor : root.dimColor
        font.family: root.fontFamily
        font.pixelSize: 13
    }

    // transport buttons, centred under the progress bar
    Row {
        x: (root.width - width) / 2
        y: root.barY + root.barH + 10
        spacing: 6

        MediaButton {
            visible: root.shuffleSupported
            kind: "shuffle"
            toggled: root.shuffle
            onClicked: root.shuffleRequested()
        }
        MediaButton {
            kind: "prev"
            enabled: root.canPrevious
            onClicked: root.previousRequested()
        }
        MediaButton {
            kind: root.playing ? "pause" : "play"
            enabled: root.canToggle
            toggled: root.playing
            onClicked: root.toggleRequested()
        }
        MediaButton {
            kind: "next"
            enabled: root.canNext
            onClicked: root.nextRequested()
        }
        MediaButton {
            visible: root.loopSupported
            kind: "loop"
            toggled: root.loopMode !== 0
            badge: root.loopMode === 2 ? "1" : ""
            onClicked: root.loopRequested()
        }
    }

    // ========================================================== progress bar
    // Layers, bottom to top: background, fill, hatch cap, a mask for the cut
    // top-left corner (hatch is rectangular), then the outline on top.
    Shape {
        x: root.pad
        y: root.barY
        width: root.barW
        height: root.barH
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            strokeColor: "transparent"
            fillColor: "#22000000"
            startX: root.barCut
            startY: 0
            PathLine {
                x: root.barW
                y: 0
            }
            PathLine {
                x: root.barW
                y: root.barH - root.barCut
            }
            PathLine {
                x: root.barW - root.barCut
                y: root.barH
            }
            PathLine {
                x: 0
                y: root.barH
            }
            PathLine {
                x: 0
                y: root.barCut
            }
            PathLine {
                x: root.barCut
                y: 0
            }
        }
    }

    // fill, clipped to the chamfer so it never pokes out of the cut corner
    Shape {
        id: fillShape
        x: root.pad
        y: root.barY
        width: root.barW
        height: root.barH
        preferredRendererType: Shape.CurveRenderer

        readonly property real fx: root.barCap + root.shownFrac * (root.barW - root.barCap - 3)
        readonly property real yb: Math.min(root.barH - 2, root.barW + root.barH - root.barCut - 3 - fx)

        ShapePath {
            strokeColor: "transparent"
            fillColor: root.seeking ? root.accentColor : root.lineColor
            startX: root.barCap
            startY: 2
            PathLine {
                x: fillShape.fx
                y: 2
            }
            PathLine {
                x: fillShape.fx
                y: fillShape.yb
            }
            PathLine {
                x: Math.min(fillShape.fx, root.barW - root.barCut - 1)
                y: root.barH - 2
            }
            PathLine {
                x: root.barCap
                y: root.barH - 2
            }
            PathLine {
                x: root.barCap
                y: 2
            }
        }
    }

    // hatched end-cap on the left (from the concept). Its box is inset 2px inside the
    // outline; startSum keeps the first stripe `stripeGap` away from the chamfer line
    // (the chamfer is x+y = barCut in bar coordinates, i.e. barCut - 4 in this box).
    Hatch {
        x: root.pad + 2
        y: root.barY + 2
        width: root.barCap - 2
        height: root.barH - 4
        color: root.hasPlayer ? root.stripeColor : Qt.rgba(root.stripeColor.r, root.stripeColor.g, root.stripeColor.b, 0.4)
        step: root.stripeStep
        lineWidth: root.stripeWidth
        startSum: root.barCut - 4 + root.stripeGap
    }
    Rectangle {
        x: root.pad + root.barCap
        y: root.barY + 1
        width: 1
        height: root.barH - 2
        color: root.lineColor
    }

    // hide hatch beyond the chamfered top-left corner
    Shape {
        x: root.pad
        y: root.barY
        width: root.barW
        height: root.barH
        preferredRendererType: Shape.CurveRenderer
        ShapePath {
            strokeColor: "transparent"
            fillColor: Qt.rgba(root.fillColor.r, root.fillColor.g, root.fillColor.b, 1)
            startX: -1
            startY: -1
            PathLine {
                x: root.barCut + 1
                y: -1
            }
            PathLine {
                x: -1
                y: root.barCut + 1
            }
            PathLine {
                x: -1
                y: -1
            }
        }
    }

    // outline: top-left and bottom-right corners cut
    Shape {
        x: root.pad
        y: root.barY
        width: root.barW
        height: root.barH
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            strokeColor: seekArea.containsMouse && root.canSeek ? root.accentColor : root.lineColor
            strokeWidth: 1.5
            fillColor: "transparent"
            joinStyle: ShapePath.MiterJoin
            startX: root.barCut
            startY: 0
            PathLine {
                x: root.barW
                y: 0
            }
            PathLine {
                x: root.barW
                y: root.barH - root.barCut
            }
            PathLine {
                x: root.barW - root.barCut
                y: root.barH
            }
            PathLine {
                x: 0
                y: root.barH
            }
            PathLine {
                x: 0
                y: root.barCut
            }
            PathLine {
                x: root.barCut
                y: 0
            }
        }
    }

    MouseArea {
        id: seekArea
        x: root.pad + root.barCap
        y: root.barY
        width: root.barW - root.barCap
        height: root.barH
        hoverEnabled: true
        enabled: root.hasPlayer && root.canSeek && root.length > 0
        preventStealing: true
        cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor

        function frac(mx) {
            return Math.max(0, Math.min(1, mx / width));
        }
        onPressed: mouse => {
            root.dragFrac = frac(mouse.x);
            root.seeking = true;
        }
        onPositionChanged: mouse => {
            if (pressed)
                root.dragFrac = frac(mouse.x);
        }
        onReleased: mouse => {
            root.dragFrac = frac(mouse.x);
            root.seeking = false;
            root.seekRequested(root.dragFrac * root.length);
        }
        onCanceled: root.seeking = false
    }
}
