#export alias fdir = ^find . -type d -name
#export alias ff = ^find . -type f -name
export alias grep = grep --color
export alias sgrep = grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS}
export alias pkgtop = pkgtop -pacman yay

# Aliases involving pipelines need to become functions:
export def fd [] {
  fd | fzf
}
export alias fzf = fzf --preview 'bat --color=always {}' --preview-window '~3'
