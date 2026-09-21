import QtQuick
import Quickshell
import Quickshell.Services.Mpris

// The "Song - Artist" box in the bar. Click it to open the media flyout
// (MediaFlyout.qml / MediaCard.qml); middle-click toggles play/pause.
// Track info now comes straight from MPRIS (same source as the flyout and the
// Cava module) instead of a `playerctl -F` process, so it updates instantly and
// the bar and the flyout can never disagree about which player is showing.
Item {
    id: root

    // Explicitly define the physical size so QML never collapses it
    width: 150
    height: 24

    // ---- which player to show -------------------------------------------
    // The one you picked in the flyout (while it still exists), else whichever
    // is playing, else the first one that has a track.
    property var manualPlayer: null
    readonly property var players: Mpris.players.values
    readonly property var player: pick()

    function pick() {
        const list = root.players;
        if (!list || list.length === 0)
            return null;
        if (root.manualPlayer && list.indexOf(root.manualPlayer) !== -1)
            return root.manualPlayer;
        for (let i = 0; i < list.length; i++) {
            if (list[i].playbackState === MprisPlaybackState.Playing)
                return list[i];
        }
        for (let j = 0; j < list.length; j++) {
            if (list[j].trackTitle)
                return list[j];
        }
        return list[0];
    }

    function cyclePlayer() {
        const list = root.players;
        if (!list || list.length < 2)
            return;
        root.manualPlayer = list[(list.indexOf(root.player) + 1) % list.length];
    }

    readonly property string trackInfo: {
        const p = root.player;
        if (!p || !p.trackTitle)
            return "-";
        return p.trackArtist ? p.trackTitle + " - " + p.trackArtist : p.trackTitle;
    }

    readonly property bool open: flyout.visible

    // ---- scrolling title --------------------------------------------------
    Item {
        anchors.fill: parent
        clip: true

        Text {
            id: scrollingText
            text: root.trackInfo
            color: root.open ? "#FEF709" : (root.trackInfo === "-" ? "#631B87" : "#36F8EC")
            font.family: "Iosevka SciFi"
            font.pixelSize: 16
            anchors.verticalCenter: parent.verticalCenter

            // Explicitly lock the starting X coordinate
            x: 0

            function restartMarquee() {
                x = 0; // Snap back to start when the song changes
                if (implicitWidth > parent.width) {
                    marqueeAnim.restart();
                } else {
                    marqueeAnim.stop();
                }
            }
            onTextChanged: restartMarquee()
            // fonts can load after the first layout; recheck when the width settles
            onImplicitWidthChanged: restartMarquee()
            Component.onCompleted: restartMarquee()

            SequentialAnimation {
                id: marqueeAnim
                loops: Animation.Infinite

                // 1. Pause at the beginning
                PauseAnimation {
                    duration: 2000
                }

                // 2. Scroll to the left
                NumberAnimation {
                    target: scrollingText
                    property: "x"
                    from: 0
                    to: Math.min(0, scrollingText.parent.width - scrollingText.implicitWidth - 20)
                    duration: Math.max(1000, (scrollingText.implicitWidth - scrollingText.parent.width) * 40)
                }

                // 3. Pause at the end
                PauseAnimation {
                    duration: 2000
                }

                // 4. Smoothly scroll back to the right (original position)
                NumberAnimation {
                    target: scrollingText
                    property: "x"
                    to: 0
                    // Uses the exact same duration formula for a consistent scroll speed
                    duration: Math.max(1000, (scrollingText.implicitWidth - scrollingText.parent.width) * 40)
                    easing.type: Easing.InOutQuad // Adds a slight deceleration as it reaches home
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton
        cursorShape: Qt.PointingHandCursor
        onClicked: mouse => {
            if (mouse.button === Qt.MiddleButton) {
                if (root.player && root.player.canTogglePlaying)
                    root.player.togglePlaying();
            } else {
                flyout.toggle();
            }
        }
    }

    MediaFlyout {
        id: flyout
        target: root
        player: root.player
        players: root.players
        onCyclePlayer: root.cyclePlayer()
    }
}
