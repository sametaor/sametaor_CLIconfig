# Aptitude
alias age='apt-get'
alias api='aptitude'
alias acs="apt-cache search"
alias aps='aptitude search'
alias as="aptitude -F '* %p -> %d \n(%v/%V)' --no-gui --disable-columns search"
alias afs='apt-file search --regexp'
alias asrc='apt-get source'
alias app='apt-cache policy'
alias aac="sudo apt autoclean"
alias abd="sudo apt build-dep"
alias ac="sudo apt clean"
alias ad="sudo apt update"
alias adg="sudo apt update && sudo apt upgrade"
alias adu="sudo apt update && sudo apt dist-upgrade"
alias afu="sudo apt-file update"
alias au="sudo apt upgrade"
alias ai="sudo apt install"
alias ail="sed -e 's/  */ /g' -e 's/ *//' | cut -s -d ' ' -f 1 | xargs sudo apt install"
alias ap="sudo apt purge"
alias aar="sudo apt autoremove"
alias ads="sudo apt-get dselect-upgrade"
alias alu="sudo apt update && apt list -u && sudo apt upgrade"
alias kclean='sudo aptitude remove -P "?and(~i~nlinux-(ima|hea) ?not(~n$(uname -r)))"'
alias allpkgs='aptitude search -F "%p" --disable-columns ~i'

# Dpkg
alias dia="sudo dpkg -i ./*.deb"
alias di="sudo dpkg -i"
alias mydeb='time dpkg-buildpackage -rfakeroot -us -uc'