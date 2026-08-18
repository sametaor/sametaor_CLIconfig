# yazi + zoxide navigation for Fish
function y
	if test (count $argv) -gt 0
		if test -d $argv[1]
			yazi $argv[1]
		else if type -q zoxide
			set target (zoxide query $argv[1] 2>/dev/null)
			if test -n "$target"
				yazi $target
			else
				echo "zoxide: No match found for '$argv[1]'" >&2
				return 1
			end
		else
			yazi $argv[1]
		end
	else
		yazi
	end
end
