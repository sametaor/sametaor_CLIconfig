alias fdir='find . -type d -name'
alias ff='find . -type f -name'
alias grep='grep --color=auto'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS}'
alias pkgtop="pkgtop -pacman yay"
alias fd="fd | fzf"
alias fzf="fzf --preview 'bat --color=always {}' --preview-window '~3'"