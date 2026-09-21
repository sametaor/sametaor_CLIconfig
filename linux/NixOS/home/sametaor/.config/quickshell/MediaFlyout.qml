import QtQuick
import Quickshell
import Quickshell.Services.Mpris

// The window that opens under the media box: a MediaCard fed by an MPRIS player.
// Click outside (or Escape) to close. All MPRIS access lives in this file.
PopupWindow {
    id: flyout

    property Item target: null          // the bar item it hangs from
    property var player: null           // MprisPlayer or null
    property var players: []            // all MprisPlayers (for the switcher)
    property real gap: -8                // space between the bar and the flyout

    property double closedAt: 0
    property real pos: 0                // playback position, seconds (polled, see below)

    signal cyclePlayer

    readonly property bool has: player !== null && player !== undefined

    // Click on the media box while open: the focus grab closes the flyout first,
    // so don't let that same click re-open it.
    function toggle() {
        if (visible) {
            visible = false;
            return;
        }
        if (Date.now() - closedAt < 250)
            return;
        visible = true;
    }

    visible: false
    color: "transparent"
    grabFocus: true
    implicitWidth: card.width
    implicitHeight: card.height

    anchor.item: target
    anchor.edges: Edges.Bottom | Edges.Left
    anchor.gravity: Edges.Bottom | Edges.Right
    anchor.adjustment: PopupAdjustment.Slide
    anchor.margins.bottom: gap

    onVisibleChanged: {
        if (visible) {
            pos = has ? player.position : 0;
            openAnim.restart();
        } else {
            closedAt = Date.now();
        }
    }
    onPlayerChanged: pos = has ? player.position : 0

    // MprisPlayer.position doesn't update on its own; reading it always returns
    // the live value, so poll it - but only while the flyout is open and playing.
    Timer {
        interval: 250
        running: flyout.visible && flyout.has && flyout.player.playbackState === MprisPlaybackState.Playing
        repeat: true
        triggeredOnStart: true
        onTriggered: flyout.pos = flyout.player.position
    }

    Connections {
        target: flyout.player
        function onTrackChanged() {
            flyout.pos = 0;
        }
    }

    ParallelAnimation {
        id: openAnim
        NumberAnimation {
            target: card
            property: "opacity"
            from: 0
            to: 1
            duration: 140
        }
        NumberAnimation {
            target: card
            property: "y"
            from: -8
            to: 0
            duration: 160
            easing.type: Easing.OutCubic
        }
    }

    MediaCard {
        id: card

        hasPlayer: flyout.has
        title: flyout.has ? (flyout.player.trackTitle || "Unknown title") : "Nothing playing"
        artist: flyout.has ? (flyout.player.trackArtist || "") : ""
        album: flyout.has ? (flyout.player.trackAlbum || "") : ""
        artUrl: flyout.has ? flyout.player.trackArtUrl : ""
        identity: flyout.has ? (flyout.player.identity || "") : ""
        playerCount: flyout.players.length
        playerIndex: Math.max(1, flyout.players.indexOf(flyout.player) + 1)

        position: flyout.pos
        // players that don't know the track length report `position` here; treat as unknown
        length: flyout.has && flyout.player.lengthSupported ? flyout.player.length : 0
        playing: flyout.has && flyout.player.playbackState === MprisPlaybackState.Playing

        canPrevious: flyout.has && flyout.player.canGoPrevious
        canNext: flyout.has && flyout.player.canGoNext
        canToggle: flyout.has && flyout.player.canTogglePlaying
        canSeek: flyout.has && flyout.player.canSeek && flyout.player.positionSupported
        shuffleSupported: flyout.has && flyout.player.shuffleSupported
        shuffle: flyout.has && flyout.player.shuffle
        loopSupported: flyout.has && flyout.player.loopSupported
        loopMode: !flyout.has ? 0 : (flyout.player.loopState === MprisLoopState.Track ? 2 : (flyout.player.loopState === MprisLoopState.Playlist ? 1 : 0))

        onToggleRequested: {
            if (flyout.has && flyout.player.canTogglePlaying)
                flyout.player.togglePlaying();
        }
        onNextRequested: {
            if (flyout.has && flyout.player.canGoNext)
                flyout.player.next();
        }
        onPreviousRequested: {
            if (flyout.has && flyout.player.canGoPrevious)
                flyout.player.previous();
        }
        onShuffleRequested: {
            if (flyout.has && flyout.player.shuffleSupported)
                flyout.player.shuffle = !flyout.player.shuffle;
        }
        onLoopRequested: {
            if (!flyout.has || !flyout.player.loopSupported)
                return;
            // off -> playlist -> track -> off
            const s = flyout.player.loopState;
            flyout.player.loopState = s === MprisLoopState.None ? MprisLoopState.Playlist : (s === MprisLoopState.Playlist ? MprisLoopState.Track : MprisLoopState.None);
        }
        onSeekRequested: seconds => {
            if (flyout.has && flyout.player.canSeek) {
                flyout.player.position = seconds;
                flyout.pos = seconds;
            }
        }
        onCycleRequested: flyout.cyclePlayer()
        onCloseRequested: flyout.visible = false
    }
}
