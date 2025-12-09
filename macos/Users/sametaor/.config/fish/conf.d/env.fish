# Environment variables (set here for modularity)
# Example: set -gx EDITOR nvim
# Add your custom environment variables below

# --- Environment Variables (ported from .zshenv/.zprofile) ---

# Editor
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx SUDO_EDITOR nvim
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
set -gx PAGER less

# FZF config
set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border"
set -gx FZF_DEFAULT_COMMAND "fd --type f"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_ALT_C_COMMAND "fd --type d"

# GPG
if type -q gpg-agent
    set -gx GPG_TTY (tty)
end

# pyenv
set -gx PYENV_ROOT "$HOME/.pyenv"
set -gx PATH $PYENV_ROOT/bin $PATH

# DBUS/XDG
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"
#set -gx DBUS_SESSION_BUS_ADDRESS (dbus-launch --sh-syntax | string match -r 'DBUS_SESSION_BUS_ADDRESS=([^;]+);' | string replace 'DBUS_SESSION_BUS_ADDRESS=' '')

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
set -gx PATH $PNPM_HOME $PATH

# pipx
set -gx PIPX_HOME "$HOME/.local/pipx"
set -gx PIPX_BIN_DIR "$HOME/.local/bin"
set -gx PATH $PIPX_BIN_DIR $PATH

# cargo
set -gx CARGO_HOME "$HOME/.cargo"
set -gx PATH $CARGO_HOME/bin $PATH

# Nix
if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
end

# Perl5
set -gx PERL5LIB "$HOME/perl5/lib/perl5"
set -gx PATH "$HOME/perl5/bin" $PATH

# Less colors
set -gx LESS_TERMCAP_mb (set_color --bold red)
set -gx LESS_TERMCAP_md (set_color --bold green)
set -gx LESS_TERMCAP_me (set_color normal)
set -gx LESS_TERMCAP_se (set_color normal)
set -gx LESS_TERMCAP_so (set_color --background=yellow --bold blue)
set -gx LESS_TERMCAP_ue (set_color normal)
set -gx LESS_TERMCAP_us (set_color --bold magenta)

# Misc
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -gx MANROFFOPT -c

if test -d /usr/local/opt/ruby/bin
    fish_add_path /usr/local/opt/ruby/bin
    set -lx _gemdir (gem environment gemdir)
    fish_add_path $_gemdir/bin
end

# Eza config location
set -gx EZA_CONFIG_DIR "$HOME/.config/eza"
