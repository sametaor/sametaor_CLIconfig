# Fish shell misc aliases (ported from bash/zsh)
abbr -a h 'history'
abbr -a hl 'history | less'
abbr -a hs 'history | grep'
abbr -a hsi 'history | grep -i'
abbr -a hgrep 'fc -El 0 | grep'
abbr -a help 'man'
abbr -a p 'ps -eo user,pid,ppid,c,stime,tty,time,comm
abbr -a sortnr 'sort -nr'
abbr -a unexport 'set -e'
# The following are not possible as aliases in fish, but can be functions if needed:
# H, T, G, L, M, LL, CA, NE, NUL, P
abbr -a ping 'prettyping'
abbr -a what 'navi --query'
abbr -a nano 'nano --modernbindings'
abbr -a sudo 'doas'
abbr -a ':q' 'exit'
abbr -a sudoedit 'doas rnano'
abbr -a vim 'nvim'
abbr -a vi 'nvim'
abbr -a neo 'tmatrix -s 15 --fade -c default -C cyan -f 1,1 -G 0,70 -g 20,60 -l 2,60 -r 5,10'
abbr -a matrix 'tmatrix -s 15 --fade -c default -f 1,1 -G 0,70 -g 20,60 -l 2,60 -r 5,10'
abbr -a lolcat 'lolcat -t'
# Bat (Better Cat) Aliases
if type -q batcat
    abbr -a cat 'batcat'
end
