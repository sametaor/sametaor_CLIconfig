# Fish shell misc aliases (ported from bash/zsh)
alias h 'history'
alias hl 'history | less'
alias hs 'history | grep'
alias hsi 'history | grep -i'
alias hgrep 'fc -El 0 | grep'
alias help 'man'
alias p 'ps -f'
alias sortnr 'sort -nr'
alias unexport 'set -e'
# The following are not possible as aliases in fish, but can be functions if needed:
# H, T, G, L, M, LL, CA, NE, NUL, P
alias ping 'prettyping'
alias what 'navi --query'
alias nano 'nano --modernbindings'
alias sudo 'doas'
alias ':q' 'exit'
alias sudoedit 'doas rnano'
alias vim 'nvim'
alias vi 'nvim'
alias neo 'tmatrix -s 15 --fade -c default -C cyan -f 1,1 -G 0,70 -g 20,60 -l 2,60 -r 5,10'
alias matrix 'tmatrix -s 15 --fade -c default -f 1,1 -G 0,70 -g 20,60 -l 2,60 -r 5,10'
alias lolcat 'lolcat -t'
# Bat (Better Cat) Aliases
if type -q batcat
    alias cat 'batcat'
end
