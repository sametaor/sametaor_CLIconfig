# Fish shell basic file/path aliases (ported from bash/zsh)
alias cd 'z' # requires zoxide installed
alias c 'clear'
alias rm 'rm -ir'
alias rmf 'rm -irf'
alias cp 'cp -irv'
alias mkd 'mkdir -ip'
function mkz
    mkdir -p $argv[1]; and cd $argv[1]
end
alias zshrc 'nvim ~/.zshrc'
alias dud 'du -d 1 -h'
alias duh 'du -sh'
alias t 'tail -f'
function path
    echo $PATH | tr ':' '\n'
end
