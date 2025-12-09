# pipupall: Upgrade all installed pip packages
function pipupall --description 'Upgrade all installed pip packages'
	set -l xargs_cmd "xargs --no-run-if-empty"
	xargs --version 2>/dev/null | grep -q GNU; or set xargs_cmd xargs
	pip list --outdated | awk 'NR > 2 { print $1 }' | $xargs_cmd pip install --upgrade
end

# pipunall: Uninstall all installed pip packages
function pipunall --description 'Uninstall all installed pip packages'
	set -l xargs_cmd "xargs --no-run-if-empty"
	xargs --version 2>/dev/null | grep -q GNU; or set xargs_cmd xargs
	pip list --format freeze | cut -d= -f1 | $xargs_cmd pip uninstall -y
end

# pipig: Install from GitHub repository
function pipig --description 'Install from GitHub repository'
	pip install "git+https://github.com/$argv[1].git"
end

# pipigb: Install from GitHub branch
function pipigb --description 'Install from GitHub branch'
	pip install "git+https://github.com/$argv[1].git@$argv[2]"
end

# pipigp: Install from GitHub pull request
function pipigp --description 'Install from GitHub pull request'
	pip install "git+https://github.com/$argv[1].git@refs/pull/$argv[2]/head"
end
