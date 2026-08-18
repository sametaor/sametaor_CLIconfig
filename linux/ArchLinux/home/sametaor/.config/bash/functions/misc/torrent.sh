magnet_to_torrent() {
    # Extract hash from magnet link
    if [[ ! "$1" =~ xt=urn:btih:([^\&/]+) ]]; then
        return 1
    fi
    local hashh="${BASH_REMATCH[1]}"
    local filename
    # Extract display name if available
    if [[ "$1" =~ dn=([^\&/]+) ]]; then
        filename="${BASH_REMATCH[1]}"
    else
        filename="$hashh"
    fi
    # Create torrent file
    echo "d10:magnet-uri${#1}:${1}e" > "$filename.torrent"
}