alias h=history
alias hl='history | less'
alias hs='history | grep'
alias hsi='history | grep -i'
alias hgrep='fc -El 0 | grep'
alias help=man
alias p='ps -f'
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
alias zipnew='zip -r'
alias zipadd='zip -ur'
alias zipls='unzip -l'
alias zipfix='zip -F'

# Usage: unzip_to archive.zip path/to/destination/
unzip_to() {
  if [ -z "$2" ]; then
    unzip "$1"
  else
    unzip "$1" -d "$2"
  fi
}

alias zipdel='zip -d'
alias unzipt='unzip -t'
alias zipenc='zip -er'

# Tar Files
# "Smart" extract function that detects compression type from file extension.
# Usage: untar archive.tar.gz
# Usage: untar archive.tar.bz2
# Usage: untar archive.tar.xz
untar() {
    if [[ "$1" == *.tar.gz || "$1" == *.tgz ]]; then
        tar -xzvf "$1"
    elif [[ "$1" == *.tar.bz2 || "$1" == *.tbz2 ]]; then
        tar -xjvf "$1"
    elif [[ "$1" == *.tar.xz || "$1" == *.txz ]]; then
        tar -xJvf "$1"
    elif [[ "$1" == *.tar ]]; then
        tar -xvf "$1"
    else
        echo "Unsupported file type: $1"
        return 1
    fi
}

# Create a gzipped tar archive (.tar.gz).
# Usage: tarc archive.tar.gz folder/ file.txt
alias tarc='tar -czvf'

# List the contents of any tar archive.
# Usage: tart archive.tar.gz
alias tart='tar -tvf'