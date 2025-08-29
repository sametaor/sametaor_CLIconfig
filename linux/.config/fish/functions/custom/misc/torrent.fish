
function magnet_to_torrent --description 'Convert magnet link to .torrent file'
	if test (count $argv) -eq 0
		echo 'Usage: magnet_to_torrent <magnet-link>' >&2
		return 1
	end
	set link $argv[1]
	set hash (string match -r 'xt=urn:btih:([^&/]+)' -- $link | string replace -r '.*xt=urn:btih:([^&/]+).*' '$1')
	if test -z "$hash"
		return 1
	end
	set filename (string match -r 'dn=([^&/]+)' -- $link | string replace -r '.*dn=([^&/]+).*' '$1')
	if test -z "$filename"
		set filename $hash
	end
	echo "d10:magnet-uri"(string length -- $link)":$link"e > "$filename.torrent"
end
