# Aptitude
export alias age = apt-get
export alias api = aptitude
export alias acs = apt-cache search
export alias aps = aptitude search
export alias as = aptitude -F '* %p -> %d \n(%v/%V)' --no-gui --disable-columns search
export alias afs = apt-file search --regexp
export alias asrc = apt-get source
export alias app = apt-cache policy
export alias aac = sudo apt autoclean
export alias abd = sudo apt build-dep
export alias ac = sudo apt clean
export alias ad = sudo apt update
export def adg [] {
  sudo apt update
  sudo apt upgrade
}
export def adu [] {
  sudo apt update
  sudo apt dist-upgrade
}
export alias afu = sudo apt-file update
export alias au = sudo apt upgrade
export alias ai = sudo apt install

# 'sed' usage best wrapped as a function; direct Nushell translation often not needed:
export def ail [pkgs: string] {
  $pkgs | split row " " | each {|p| sudo apt install $p }
}
export alias ap = sudo apt purge
export alias aar = sudo apt autoremove
export alias ads = sudo apt-get dselect-upgrade
export def alu [] {
  sudo apt update
  apt list -u
  sudo apt upgrade
}
export alias kclean = sudo aptitude remove -P '?and(~i~nlinux-(ima|hea) ?not(~n$(uname -r)))'
export alias allpkgs = aptitude search -F "%p" --disable-columns ~i

# Dpkg
export alias dia = sudo dpkg -i ./*.deb
export alias di = sudo dpkg -i
export alias mydeb = time dpkg-buildpackage -rfakeroot -us -uc
