
function mkdircd --description 'Make directory and cd into it'
	if test (count $argv) -eq 0
		echo 'Usage: mkdircd <directory>' >&2
		return 1
	end
	mkdir -p -- $argv[1]; and cd -- $argv[1]
end
