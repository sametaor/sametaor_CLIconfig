
function copyfile --description 'Copy file contents to clipboard'
	if test (count $argv) -eq 0
		echo 'Usage: copyfile <file>' >&2
		return 1
	end
	clipcopy $argv[1]
end
