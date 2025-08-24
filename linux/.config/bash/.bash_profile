
# --- Bash Profile Loader (login shell entrypoint) ---
# 1. Source .bashenv for environment variables (always)
if [ -f "$HOME/.config/bash/.bashenv" ]; then
    source "$HOME/.config/bash/.bashenv"
fi

# 2. Source .bashrc for interactive shell setup (if interactive)
if [[ $- == *i* ]]; then
    if [ -f "$HOME/.config/bash/.bashrc" ]; then
        source "$HOME/.config/bash/.bashrc"
    fi
fi

# 3. Fallback: source .bash_login if present (rarely needed)
if [ -f "$HOME/.config/bash/.bash_login" ]; then
    source "$HOME/.config/bash/.bash_login"
fi

# --- PATH and tool initializations (login shell only) ---
if [[ -d "/home/linuxbrew/.linuxbrew/bin" ]]; then
  [[ -d /home/linuxbrew/.linuxbrew/bin ]] && PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
  [[ -d /home/linuxbrew/.linuxbrew/sbin ]] && PATH="/home/linuxbrew/.linuxbrew/sbin:$PATH"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ -d "/opt/homebrew/bin" ]]; then               # Apple Silicon
  [[ -d /opt/homebrew/bin ]] && PATH="/opt/homebrew/bin:$PATH"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
export PATH

# Initialize pyenv (Python version manager)
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Oh-my-posh initialization (bash mode)
if command -v oh-my-posh >/dev/null 2>&1; then
  eval "$(oh-my-posh init bash --config 'https://raw.githubusercontent.com/sametaor/sametaor_CLIconfig/master/misc/sametaor.omp.json')"
fi

# Initialize zoxide (better cd)
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi
