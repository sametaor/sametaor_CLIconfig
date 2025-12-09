# Fish shell aliases for MacPorts (ported from bash/zsh)
abbr -a pc 'sudo port clean --all installed'
abbr -a pi 'sudo port install'
abbr -a pli 'port livecheck installed'
abbr -a plm 'port-livecheck-maintainer'
abbr -a psu 'sudo port selfupdate'
abbr -a puni 'sudo port uninstall inactive'
abbr -a puo 'sudo port upgrade outdated'
abbr -a pup 'sudo port selfupdate; and sudo port upgrade outdated'
