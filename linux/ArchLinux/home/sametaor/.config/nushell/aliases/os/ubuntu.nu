# Apt
export alias acs = apt-cache search
export alias afs = apt-file search --regexp
export alias ags = apt source
export alias acp = apt-cache policy
export alias agli = apt list --installed
export alias aglu = apt list --upgradable
export alias acsp = apt-cache showpkg
export alias afu = sudo apt-file update
export alias ppap = sudo ppa-purge
export alias age = sudo apt
export alias aga = sudo apt autoclean
export alias agb = sudo apt build-dep
export alias agc = sudo apt clean
export alias agd = sudo apt dselect-upgrade
export alias agi = sudo apt install
export alias agp = sudo apt purge
export alias agr = sudo apt remove
export alias agu = sudo apt update

export def agud [] {
  sudo apt update
  sudo apt dist-upgrade
}

export alias agug = sudo apt upgrade

export def aguu [] {
  sudo apt update
  sudo apt upgrade
}

export alias agar = sudo apt autoremove

# Dpkg
export def allpkgs [] { dpkg --get-selections | grep -v deinstall }
export alias mydeb = time dpkg-buildpackage -rfakeroot -us -uc
