# Fish shell aliases for npm (ported from bash/zsh)
alias npmg 'npm i -g '
alias npmS 'npm i -S '
alias npmD 'npm i -D '
alias npmF 'npm i -f'
function npmE
    set -l bin (npm bin)
    set -x PATH $bin $PATH
    eval $argv
end
alias npmO 'npm outdated'
alias npmU 'npm update'
alias npmV 'npm -v'
alias npmL 'npm list'
alias npmL0 'npm ls --depth=0'
alias npmst 'npm start'
alias npmt 'npm test'
alias npmR 'npm run'
alias npmP 'npm publish'
alias npmI 'npm init'
alias npmi 'npm info'
alias npmSe 'npm search'
