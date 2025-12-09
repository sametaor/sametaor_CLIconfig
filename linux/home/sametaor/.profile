#!/bin/sh
# ~/.profile - POSIX-compliant environment configuration
# Sourced by all POSIX shells (bash, dash, etc.)

# Core environment variables (Manual §3.4)
export EDITOR=nvim
export VISUAL="$EDITOR" 
export PAGER=less
export LESS="-RFiX"
export LANG=en_US.UTF-8

# Bash configuration directory
export BASH_CONFIG_DIR="${HOME}/.config/bash"

# History settings (Manual §9.1)
export HISTFILE="${BASH_CONFIG_DIR}/.bash_history"
export HISTSIZE=50000
export HISTFILESIZE=50000
export HISTCONTROL="erasedups:ignoredups:ignorespace"
export HISTTIMEFORMAT='%F %T '

# PATH management function (avoiding duplicates)
_add_to_path() {
    case ":$PATH:" in
        *":$1:"*) ;;
        *) PATH="$1:$PATH" ;;
    esac
}

# Core PATH additions
[ -d "$HOME/.local/bin" ] && _add_to_path "$HOME/.local/bin"
[ -d "/usr/local/bin" ] && _add_to_path "/usr/local/bin"

# Development tools PATH
[ -d "$HOME/.cargo/bin" ] && _add_to_path "$HOME/.cargo/bin"
[ -d "$HOME/.pyenv/bin" ] && _add_to_path "$HOME/.pyenv/bin"
[ -d "/home/sametaor/.local/share/pnpm" ] && _add_to_path "/home/sametaor/.local/share/pnpm"

# Terminal and session variables
export GPG_TTY="$(tty 2>/dev/null || echo /dev/tty)"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus"

# FZF configuration (matching ZSH setup exactly)
export FZF_DEFAULT_OPTS='--color=fg:#c8d3f5,fg+:#c8d3f5,bg:#222436,bg+:#2a2e54 --color=hl:#82aaff,hl+:#86e1fc,info:#c3e88d,marker:#ffc777 --color=prompt:#ff757f,spinner:#c099ff,pointer:#c099ff,header:#828bb8 --color=border:#6c75ba,label:#9da8ee,query:#c8d3f5 --border="rounded" --border-label="FZF" --border-label-pos="0" --preview-window="border-double" --padding="1" --margin="1" --prompt=">_ " --marker=">>" --pointer="=>" --separator="─" --scrollbar="|" --layout="reverse" --info="right" --tmux left,80% --height=80%'

# Perl5 environment (if exists)
if [ -d "$HOME/perl5" ]; then
    export PERL5LIB="$HOME/perl5/lib/perl5:$PERL5LIB"
    export PERL_LOCAL_LIB_ROOT="$HOME/perl5:$PERL_LOCAL_LIB_ROOT"
    export PERL_MB_OPT="--install_base \"$HOME/perl5\""
    export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"
    _add_to_path "$HOME/perl5/bin"
fi

# Nix package manager
[ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ] && . "$HOME/.nix-profile/etc/profile.d/nix.sh"

# Export final PATH
export PATH

# Cleanup
unset -f _add_to_path
