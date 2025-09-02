export alias bs = brew search
export alias bsd = brew search --desc
export alias binf = brew info
export alias bins = brew install
export alias buns = brew uninstall
export alias bcat = brew cat
export alias btap = brew tap
export alias btapinf = brew tap-info
export alias ci = brew info --cask
export alias cis = brew install --cask

# Multi-step actions need to be converted to a Nushell function:
export def brewup [] {
  brew -v update
  brew -v upgrade
  brew upgrade --cask
  brew -v cleanup --prune=5
  brew doctor
}
export alias bdr = brew doctor
export alias bls = brew list
export alias cus = brew uninstall --cask
export alias cuz = brew zap --cask
export alias blv = brew leaves
