# Auto-activate pipenv shell when entering a directory with a Pipfile
function __pipenv_auto_activate --on-event fish_chpwd
	if not type -q pipenv
		return
	end
	set -l dir $PWD
	set -l found 0
	for check in "$dir/Pipfile" "$dir/../Pipfile" "$dir/../../Pipfile"
		if test -e $check
			set found 1
			break
		end
	end
	if test $found -eq 0
		return
	end
	if not set -q PIPENV_ACTIVE
		if pipenv --venv ^/dev/null
			if test $dir != $PWD
				pipenv shell "cd $PWD"
			else
				pipenv shell
			end
		end
	end
end

# Run once at shell start
__pipenv_auto_activate
