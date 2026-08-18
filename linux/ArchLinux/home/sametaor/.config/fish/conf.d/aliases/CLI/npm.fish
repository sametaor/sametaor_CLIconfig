# Fish shell aliases for npm (ported from bash/zsh)
abbr -a npmg 'npm i -g '
abbr -a npmS 'npm i -S '
abbr -a npmD 'npm i -D '
abbr -a npmF 'npm i -f'
function npmE
    set -l bin (npm bin)
    set -x PATH $bin $PATH
    eval $argv
end
abbr -a npmO 'npm outdated'
abbr -a npmU 'npm update'
abbr -a npmV 'npm -v'
abbr -a npmL 'npm list'
abbr -a npmL0 'npm ls --depth=0'
abbr -a npmst 'npm start'
abbr -a npmt 'npm test'
abbr -a npmR 'npm run'
abbr -a npmP 'npm publish'
abbr -a npmI 'npm init'
abbr -a npmi 'npm info'
abbr -a npmSe 'npm search'
