
# ~/.config/bash/.bashrc
# Purpose: Interactive shell setup (modular plugin/alias/function loading, prompt, keybinds, etc.)
# Only sourced in interactive shells. Environment variables go in .bashenv.

# Return if not interactive
case $- in
    *i*) ;;
    *) return;;
esac

# Set config root if not already set
export BASH_CONFIG_DIR="${BASH_CONFIG_DIR:-$HOME/.config/bash}"

# 1. Source plugin-opts (options/config for plugins)
PLUGIN_OPTS_DIR="$BASH_CONFIG_DIR/plugin-opts"
if [ -d "$PLUGIN_OPTS_DIR" ]; then
    for opt in "$PLUGIN_OPTS_DIR"/*.sh; do
        [ -r "$opt" ] && source "$opt"
    done
fi

# 2. Source plugin-functions (actual plugin features)
PLUGIN_FUNCS_DIR="$BASH_CONFIG_DIR/plugin-functions"
if [ -d "$PLUGIN_FUNCS_DIR" ]; then
    for plugin in "$PLUGIN_FUNCS_DIR"/*.sh; do
        [ -r "$plugin" ] && source "$plugin"
    done
fi

# 3. Source aliases (all sets)
ALIASES_DIR="$BASH_CONFIG_DIR/aliases"
if [ -d "$ALIASES_DIR" ]; then
    for dir in "$ALIASES_DIR"/*; do
        if [ -d "$dir" ]; then
            for afile in "$dir"/*.sh; do
                [ -r "$afile" ] && source "$afile"
            done
        elif [ -f "$dir" ]; then
            [ -r "$dir" ] && source "$dir"
        fi
    done
fi

# 4. Source completions (if any)
COMPLETIONS_DIR="$BASH_CONFIG_DIR/completions"
if [ -d "$COMPLETIONS_DIR" ]; then
    for cfile in "$COMPLETIONS_DIR"/*; do
        [ -r "$cfile" ] && source "$cfile"
    done
fi

# 5. Source functions (all sets)
FUNCS_DIR="$BASH_CONFIG_DIR/functions"
if [ -d "$FUNCS_DIR" ]; then
    for dir in "$FUNCS_DIR"/*; do
        if [ -d "$dir" ]; then
            for ffile in "$dir"/*.sh; do
                [ -r "$ffile" ] && source "$ffile"
            done
        elif [ -f "$dir" ]; then
            [ -r "$dir" ] && source "$dir"
        fi
    done
fi

# ---------------- Shell Behavior ----------------

# Enable cd by typing directory name (bash equivalent)
shopt -s autocd

# Add directories to directory stack on cd, avoid duplicates (no exact bash equivalent of AUTO_PUSHD with ignore)
shopt -s pushdignoredups

# Allow comments in interactive shell (interactive_comments is zsh-specific, no direct bash equivalent)

# Enable prompt substitution
shopt -s promptvars

# Enable vi mode editing
set -o vi
export KEYTIMEOUT=1

# Edit command line via default editor: no direct bash readline equivalent for autoload, omit


# ---------------- Advanced Globbing ----------------
shopt -s extglob        # extended globbing for complex patterns
shopt -s failglob       # no equivalent for NO_ERR_RETURN, failglob fails on no matches


# ---------------- Completion and Prompt Cache ----------------

# Completion directory (user supplied completions)
export BASH_COMP_DIR="${BASH_CONFIG_DIR:-$HOME/.config/bash}/completions"

# Cache directory for completion system
export BASH_CACHE_DIR="${BASH_CONFIG_DIR:-$HOME/.config/bash}/cache"
mkdir -p "$BASH_CACHE_DIR"

# Bash completions are usually loaded like this:
if [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
elif [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
elif [ -f /usr/local/etc/bash_completion ]; then
    source /usr/local/etc/bash_completion
fi

# Source user completion scripts
if [ -d "$BASH_COMP_DIR" ]; then
    for comp_file in "$BASH_COMP_DIR"/*; do
        [ -r "$comp_file" ] && source "$comp_file"
    done
fi

# Completion system cache like compinit isn't in bash, so no direct analog


# ---------------- Function Loading ----------------

# Bash does not autoload functions like zsh. Source function scripts explicitly if needed
export BASH_FUNCS_DIR="${BASH_CONFIG_DIR:-$HOME/.config/bash}/functions"
if [ -d "$BASH_FUNCS_DIR" ]; then
    for func_file in "$BASH_FUNCS_DIR"/*; do
        [ -r "$func_file" ] && source "$func_file"
    done
fi


# ---------------- Aliases ----------------

# Source aliases from modular alias sets
export BASH_ALIASES_DIR="${BASH_CONFIG_DIR:-$HOME/.config/bash}/aliases"
if [ -d "$BASH_ALIASES_DIR" ]; then
    for alias_file in "$BASH_ALIASES_DIR"/*; do
        [ -r "$alias_file" ] && source "$alias_file"
    done
fi


# ---------------- Prompt Configuration ----------------

# Git prompt support (requires git prompt script installed)
if [ -f /usr/share/git/completion/git-prompt.sh ]; then
    source /usr/share/git/completion/git-prompt.sh
fi

__git_ps1() { :; }  # fallback no-op function if above is missing

# Custom prompt with color and git branch
PS1='\[\e[36m\]\u@\h\[\e[m\] \[\e[33m\]\w\[\e[m\]$(__git_ps1 " ‹%s›")\n$ '

# ---------------- Misc Convenience ----------------

alias reload='source ~/.bashrc'

if command -v fastfetch >/dev/null 2>&1; then
    fastfetch
fi


# ---------------- Key Bindings ----------------

# Bash uses readline bind, not bindkey
# Map keys similar to zsh terminfo references:

bind '"\e[1~": beginning-of-line'   # Home
bind '"\e[4~": end-of-line'         # End
bind '"\e[2~": quoted-insert'       # Insert
bind '"\C-h": backward-delete-char' # Backspace
bind '"\e[3~": delete-char'         # Delete
bind '"\e[A": history-search-backward' # Up
bind '"\e[B": history-search-forward'  # Down
bind '"\e[D": backward-char'        # Left
bind '"\e[C": forward-char'         # Right
bind '"\e[5~": beginning-of-history' # PageUp
bind '"\e[6~": end-of-history'       # PageDown
bind '"\e[Z": reverse-menu-complete' # Shift-Tab

# Vi mode keymap bindings
bind -m vi-insert '"\C-a": beginning-of-line'
bind -m vi-insert '"\C-e": end-of-line'
bind -m vi-insert '"\C-l": clear-screen'
bind -m vi-insert '"\C-w": backward-kill-word'

# History substring search equivalents are not builtin; you can install bash-history-substring-search externally


# ---------------- Vi mode cursor and prompt redraw is not directly possible in bash readline ----------------
# Cursor shape and mode prompt updates are advanced zsh features without direct bash equivalents

# You can set simple vi mode with 'set -o vi' and customize PS1, but no zle or widget manipulation