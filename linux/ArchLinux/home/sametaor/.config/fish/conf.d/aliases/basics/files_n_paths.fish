# Fish shell basic file/path aliases (ported from bash/zsh)
#alias cd 'z' # requires zoxide installed
# Causes recursion errors in fish shell, use z instead
abbr -a c 'clear'
abbr -a rm 'rm -ir'
abbr -a rmf 'rm -irf'
abbr -a cp 'cp -irv'
abbr -a mkd 'mkdir -ip'
function mkz
    mkdir -p $argv[1]; and cd $argv[1]
end
abbr -a zshrc 'nvim ~/.zshrc'
abbr -a dud 'du -d 1 -h'
abbr -a duh 'du -sh'
abbr -a t 'tail -f'
function path
    echo $PATH | tr ':' '\n'
end
