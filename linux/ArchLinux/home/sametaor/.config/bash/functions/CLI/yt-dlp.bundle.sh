# yt-dlp.bundle.sh — Bash functions for yt-dlp usage

# Play the latest file created within the last 1 second using VLC at 1.33x speed
play_latest() {
    latest_file=$(find . -type f -ctime -1s | head -1)
    if [ -n "$latest_file" ]; then
        vlc --rate 1.33 "$latest_file"
    else
        echo "No recently created file found."
        return 1
    fi
}

# List formats for a given URL and prompt user to select format code(s) to download
ytf() {
    set -euxo pipefail

    # Check that ffmpeg is available
    if ! command -v ffmpeg >/dev/null 2>&1; then
        echo "ffmpeg is required but not installed or not in PATH." >&2
        return 1
    fi

    local formats
    formats=$(ytnpl --list-formats "$1" || true)

    # Show all formats except "audio only" or "video only"
    echo "$formats" | grep -vE "(audio|video) only"
    echo ""

    # Then separately show audio and video only formats
    for type in audio video; do
        echo "$formats" | grep "$type only"
        echo ""
    done

    echo "== Please copy-paste 👇 a 'format code' (or vid+aud) ☝️"
    read -r format
    ytnpl --format "$format" "$1"

    play_latest
}

# Download and play in /tmp
yw() {
    cd /tmp || return
    ytp "$1"
    play_latest
}

yww() {
    cd /tmp || return
    yth "$1"
    play_latest
}