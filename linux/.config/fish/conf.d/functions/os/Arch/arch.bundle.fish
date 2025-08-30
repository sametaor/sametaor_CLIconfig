# Arch Linux upgrade and pacman helpers for Fish
function upgrade --description 'Upgrade system with keyring check and AUR helper'
	sudo pacman -Sy
	echo ':: Checking Arch Linux PGP Keyring...'
	set installedver (LANG= sudo pacman -Qi archlinux-keyring | string match -r 'Version\s+: (.*)' | string replace -r '.*: ' '')
	set currentver (LANG= sudo pacman -Si archlinux-keyring | string match -r 'Version\s+: (.*)' | string replace -r '.*: ' '')
	if test "$installedver" != "$currentver"
		echo ' Arch Linux PGP Keyring is out of date.'
		echo ' Updating before full system upgrade.'
		sudo pacman -S --needed --noconfirm archlinux-keyring
	else
		echo ' Arch Linux PGP Keyring is up to date.'
		echo ' Proceeding with full system upgrade.'
	end
	if type -q yay
		yay -Su
	else if type -q trizen
		trizen -Su
	else if type -q pacaur
		pacaur -Su
	else if type -q aura
		sudo aura -Su
	else
		sudo pacman -Su
	end
end
function paclist --description 'List explicitly installed packages and their info'
	pacman -Qqe | xargs -r -P0 -I{} pacman -Qs --color=auto "^{}\$"
end
function pacdisowned --description 'Find files not owned by any package'
	set tmp_dir (mktemp -d) || return 1
	set db $tmp_dir/db
	set fs $tmp_dir/fs
	function _cleanup; rm -rf -- $tmp_dir; end
	trap _cleanup EXIT
	pacman -Qlq | sort -u > $db
	find /etc /usr ! -name lost+found \( -type d -printf '%p/\n' -o -print \) | sort > $fs
	comm -23 $fs $db
end
function pacmansignkeys --description 'Sign pacman keys'
	for key in $argv
		sudo pacman-key --recv-keys $key
		sudo pacman-key --lsign-key $key
		printf 'trust\n3\n' | sudo gpg --homedir /etc/pacman.d/gnupg --no-permission-warning --command-fd 0 --edit-key $key
	end
end
if type -q xdg-open
	function pacweb --description 'Open Arch package webpage'
		if test (count $argv) -eq 0; or string match -r '^--help|-h$' $argv[1]
			echo "$argv[0] - open the website of an ArchLinux package"
			echo
			echo "Usage: $argv[0] <package>"
			return 1
		end
		set pkg $argv[1]
		set infos (LANG=C pacman -Si $pkg)
		if test -z "$infos"; return 1; end
		set repo (string match -r '^Repo' $infos | awk '{print $3}')
		set arch (string match -r '^Arch' $infos | awk '{print $3}')
		xdg-open "https://www.archlinux.org/packages/$repo/$arch/$pkg/" &> /dev/null
	end
end
