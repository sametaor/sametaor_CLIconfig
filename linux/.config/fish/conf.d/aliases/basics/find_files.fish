# Fish shell find/grep/fzf aliases (ported from bash/zsh)
abbr -a fdir 'find . -type d -name'
abbr -a ff 'find . -type f -name'
abbr -a grep 'grep --color=auto'
abbr -a sgrep 'grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS}'
abbr -a pkgtop 'pkgtop -pacman yay'
abbr -a fd 'fd | fzf'
abbr -a fzf "fzf --preview 'bat --color=always {}' --preview-window '~3'"
