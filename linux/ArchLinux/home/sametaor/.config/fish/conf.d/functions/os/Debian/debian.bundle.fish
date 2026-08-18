# Debian/Ubuntu APT helpers for Fish
function apt-history --description 'Show APT history of installs, upgrades, removals, rollback'
	switch $argv[1]
		case install
			zgrep --no-filename 'install ' (ls -rt /var/log/dpkg*)
		case upgrade remove
			zgrep --no-filename $argv[1] (ls -rt /var/log/dpkg*)
		case rollback
			zgrep --no-filename upgrade (ls -rt /var/log/dpkg*) | grep $argv[2] -A10000000 | grep $argv[3] -B10000000 | awk '{print $4"="$5}'
		case list
			zgrep --no-filename '' (ls -rt /var/log/dpkg*)
		case '*'
			echo 'Parameters:'
			echo ' install  - Lists all packages that have been installed.'
			echo ' upgrade  - Lists all packages that have been upgraded.'
			echo ' remove   - Lists all packages that have been removed.'
			echo ' rollback - Lists rollback information.'
			echo ' list     - Lists all contents of dpkg logs.'
	end
end
function apt-list-packages --description 'List packages by installed size'
	dpkg-query -W --showformat='${Installed-Size} ${Package} ${Status}\n' | grep -v deinstall | sort -n | awk '{print $1, $2}'
end
function kerndeb --description 'Kernel package build shortcut'
	set -l MAKEFLAGS (string replace -r '-j\d*' '' -- $MAKEFLAGS)
	echo "MAKEFLAGS set to '$MAKEFLAGS'"
	set appendage -custom
	set revision (date +"%Y%m%d")
	make-kpkg clean
	time fakeroot make-kpkg --append-to-version $appendage --revision $revision kernel_image kernel_headers
end
