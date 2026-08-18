# Homebrew (if present)
if test -d /home/linuxbrew/.linuxbrew/bin
    set -gx PATH /home/linuxbrew/.linuxbrew/bin $PATH
end
# MacPorts (if present)
if test -d /opt/local/bin
    set -gx PATH /opt/local/bin $PATH
end

if test -d $PYENV_ROOT
    status --is-interactive; and pyenv init - | source
end

oh-my-posh init fish --config 'https://raw.githubusercontent.com/sametaor/sametaor_CLIconfig/master/misc/sametaor.omp.json' | source

zoxide init fish --cmd=cd | source
