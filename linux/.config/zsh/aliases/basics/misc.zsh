alias h=history
alias hl='history | less'
alias hs='history | grep'
alias hsi='history | grep -i'
alias hgrep='fc -El 0 | grep'
alias help=man
alias p='ps -eo user,pid,ppid,c,stime,tty,time,comm'
alias sortnr='sort -n -r'
alias unexport=unset
alias H='| head'
alias T='| tail'
alias G='| grep'
alias L='| less'
alias M='| most'
alias LL='2>&1 | less'
alias CA='2>&1 | cat -A'
alias NE='2 > /dev/null'
alias NUL='> /dev/null 2>&1'
alias P='2>&1| pygmentize -l pytb'
alias ping=prettyping
alias what='navi --query'
alias nano='nano --modernbindings'
alias sudo=doas
alias ':q'=exit

# Editor aliases
alias sudoedit='doas rnano'
alias vim=nvim
alias vi=nvim

# Tmatrix Aliases
alias neo='tmatrix -s 15 --fade -c default -C cyan -f 1,1 -G 0,70 -g 20,60 -l 2,60 -r 5,10'
alias matrix='tmatrix -s 15 --fade -c default -f 1,1 -G 0,70 -g 20,60 -l 2,60 -r 5,10'

# Lolcat Alias
alias lolcat="lolcat -t"

# Bat (Better Cat) Aliases
alias rcat="$(which cat)"
if command -v batcat &>/dev/null; then
    alias cat="$(which batcat)"
    export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
    export MANROFFOPT="-c"
else
    alias cat="$(which bat)"
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    export MANROFFOPT="-c"
fi

# Zip Files
alias zip='unzip -l'
alias rar='unrar l'
alias tar='tar tf'
alias 'tar.gz'=echo
