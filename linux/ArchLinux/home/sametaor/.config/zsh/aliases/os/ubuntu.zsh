# Apt
alias acs='apt-cache search'
alias afs='apt-file search --regexp'
alias ags="apt source"
alias acp='apt-cache policy'
alias agli='apt list --installed'
alias aglu='apt list --upgradable'
alias acsp='apt-cache showpkg'
alias afu='sudo apt-file update'
alias ppap='sudo ppa-purge'
alias age="sudo apt"
alias aga="sudo apt autoclean"
alias agb="sudo apt build-dep"
alias agc="sudo apt clean"
alias agd="sudo apt dselect-upgrade"
alias agi="sudo apt install"
alias agp="sudo apt purge"
alias agr="sudo apt remove"
alias agu="sudo apt update"
alias agud="sudo apt update && sudo apt dist-upgrade"
alias agug="sudo apt upgrade"
alias aguu="sudo apt update && sudo apt upgrade"
alias agar="sudo apt autoremove"

# Dpkg
alias allpkgs='dpkg --get-selections | grep -v deinstall'
alias mydeb='time dpkg-buildpackage -rfakeroot -us -uc'