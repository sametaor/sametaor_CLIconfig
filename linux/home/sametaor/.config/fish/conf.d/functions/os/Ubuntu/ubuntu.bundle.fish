# Ubuntu helpers for Fish
function aar --description 'Add a PPA and install a package'
	set repo $argv[1]
	set package $argv[2]
	if test -n "$package"
		set PACKAGE $package
	else
		read -l -P "Type in the package name to install/upgrade with this ppa ["(string split -r '/' $repo)[-1]"]: " PACKAGE
	end
	if test -z "$PACKAGE"
		set PACKAGE (string split -r '/' $repo)[-1]
	end
	sudo apt-add-repository $repo; and sudo apt update
	sudo apt install $PACKAGE
end
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
function kerndeb --description 'Kernel package build shortcut'
	set -l MAKEFLAGS (string replace -r '-j\s*\d+' '' -- $MAKEFLAGS)
	echo "MAKEFLAGS set to '$MAKEFLAGS'"
	set appendage -custom
	set revision (date +"%Y%m%d")
	make-kpkg clean
	time fakeroot make-kpkg --append-to-version $appendage --revision $revision kernel_image kernel_headers
end
function apt-list-packages --description 'List installed packages by size'
	dpkg-query -W --showformat='${Installed-Size} ${Package} ${Status}\n' | grep -v deinstall | sort -n | awk '{print $1, $2}'
end
