# Fish shell misc aliases (ported from bash/zsh)
abbr -a h 'history'
abbr -a hl 'history | less'
abbr -a hs 'history | grep'
abbr -a hsi 'history | grep -i'
abbr -a hgrep 'fc -El 0 | grep'
abbr -a help 'man'
abbr -a p 'ps -f'
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
if type -q bat
    abbr -a cat 'bat'
end

abbr -a zipnew 'zip -r'
abbr -a zipadd 'zip -ur'
abbr -a zipls 'unzip -l'
abbr -a zipfix 'zip -F'

function unzip_to
  unzip $argv[1] -d $argv[2]
end

abbr -a zipdel 'zip -d'
abbr -a unzipt 'unzip -t'
abbr -a zipenc 'zip -er'

# "Smart" extract function that detects compression type from file extension.
# Usage: untar archive.tar.gz
function untar
    switch $argv[1]
        case "*.tar.gz" "*.tgz"
            tar -xzvf $argv[1]
        case "*.tar.bz2" "*.tbz2"
            tar -xjvf $argv[1]
        case "*.tar.xz" "*.txz"
            tar -xJvf $argv[1]
        case "*.tar"
            tar -xvf $argv[1]
        case '*'
            echo "Unsupported file type: $argv[1]"
            return 1
      end
end

# Create a gzipped tar archive (.tar.gz).
# Usage: tarc archive.tar.gz folder/ file.txt
alias tarc 'tar -czvf'

# List the contents of any tar archive.
# Usage: tart archive.tar.gz
alias tart 'tar -tvf'
