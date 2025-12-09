# Functional aliases for easy yt-dlp usage
play_latest() {
	latest_file=$(find . -type f -ctime -1s | head -1)
	vlc --rate 1.33 "$latest_file"
}

ytf() { # List formats & prompt for which one(s) to download
	set -eux -pipefail
	which ffmpeg

	FORMATS=$(ytnpl --list-formats "$1")

	echo "$FORMATS" | grep --invert-match "(audio|video) only"
	echo ""
	
	for type in audio video
	do
		echo "$FORMATS" | grep "$type only"
		echo ""
	done

	echo "== Please copy-paste 👇 a 'format code' (or vid+aud) ☝️"
	read -r FORMAT
	ytnpl --format "$FORMAT" "$1"
	
	play_latest
}

yw() {
	cd /tmp
	ytp "$1"
	play_latest
}

yww() {
	cd /tmp
	yth "$1"
	play_latest
}