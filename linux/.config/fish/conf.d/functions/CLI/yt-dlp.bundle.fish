# yt-dlp helpers for Fish
function play_latest
	set latest_file (find . -type f -ctime -1s | head -1)
	if test -n "$latest_file"
		vlc --rate 1.33 "$latest_file"
	else
		echo "No recently created file found."
		return 1
	end
end
function ytf
	if not type -q ffmpeg
		echo "ffmpeg is required but not installed or not in PATH." >&2
		return 1
	end
	set formats (ytnpl --list-formats $argv[1] ^/dev/null)
	echo $formats | grep -vE "(audio|video) only"
	echo ""
	for type in audio video
		echo $formats | grep "$type only"
		echo ""
	end
	echo "== Please copy-paste ↓ a 'format code' (or vid+aud) ☝"
	read -l format
	ytnpl --format $format $argv[1]
	play_latest
end
function yw
	cd /tmp; and ytp $argv[1]; and play_latest
end
function yww
	cd /tmp; and yth $argv[1]; and play_latest
end
