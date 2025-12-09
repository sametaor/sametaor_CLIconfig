# pyenv fish helpers

# List of possible venv names
set -g PYTHON_VENV_NAMES venv .venv
set -g PYTHON_VENV_NAME venv

# vrun: activate a python virtual environment
function vrun --description 'Activate a python virtual environment in current directory'
	set -l name $argv[1]
	if test -z "$name"
		for n in $PYTHON_VENV_NAMES
			if test -d "$n"
				vrun $n
				return $status
			end
		end
		echo "Error: no virtual environment found in current directory" >&2
		return 1
	end
	set -l venvpath "$name"
	if not test -d "$venvpath"
		echo "Error: no such venv in current directory: $name" >&2
		return 1
	end
	if not test -f "$venvpath/bin/activate"
		echo "Error: '$name' is not a proper virtual environment" >&2
		return 1
	end
	source "$venvpath/bin/activate"
	echo "Activated virtual environment $name"
end

# mkv: create and activate a new virtual environment
function mkv --description 'Create and activate a new python virtual environment'
	set -l name $argv[1]
	if test -z "$name"
		set name $PYTHON_VENV_NAME
	end
	python3 -m venv "$name"; or return
	echo "Created venv in '$name'" >&2
	vrun "$name"
end

# auto_vrun: auto-activate venv on directory change
set -g PYTHON_AUTO_VRUN true
function __auto_vrun --on-event fish_chpwd
	if test "$PYTHON_AUTO_VRUN" = "true"
		if set -q VIRTUAL_ENV
			if not string match -q "$PWD*" -- (dirname $VIRTUAL_ENV)
				if functions -q deactivate
					deactivate > /dev/null 2>&1
				end
			end
		end
		for n in $PYTHON_VENV_NAMES
			if test -f "$n/bin/activate"
				if functions -q deactivate
					deactivate > /dev/null 2>&1
				end
				source "$n/bin/activate" > /dev/null 2>&1
				break
			end
		end
	end
end

# Run once at shell start
__auto_vrun
