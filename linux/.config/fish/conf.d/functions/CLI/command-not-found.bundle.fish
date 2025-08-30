# command-not-found handler for Fish
if test -x /usr/lib/command-not-found
	function fish_command_not_found
		/usr/lib/command-not-found -- $argv[1]
	end
else if test -x /usr/share/command-not-found/command-not-found
	function fish_command_not_found
		/usr/share/command-not-found/command-not-found -- $argv[1]
	end
else if test -x /usr/libexec/pk-command-not-found
	function fish_command_not_found
		/usr/libexec/pk-command-not-found $argv
	end
else if test -x /usr/bin/command-not-found
	function fish_command_not_found
		/usr/bin/command-not-found $argv[1]
	end
else
	function fish_command_not_found
		printf 'fish: %s: command not found\n' $argv[1] >&2
		return 127
	end
end
