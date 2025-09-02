export alias pc = sudo port clean --all installed
export alias pi = sudo port install
export alias pli = port livecheck installed
export alias plm = port-livecheck-maintainer
export alias psu = sudo port selfupdate
export alias puni = sudo port uninstall inactive
export alias puo = sudo port upgrade outdated

# Multi-step action as a Nushell function:
export def pup [] {
  sudo port selfupdate
  sudo port upgrade outdated
}
