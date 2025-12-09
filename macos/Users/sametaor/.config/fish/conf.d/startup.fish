# --- Modular Fish Loader: Replicate zsh/bash logic ---

# --- Plugin Features: Autosuggestions, Syntax Highlighting, fzf-tab ---
# Use native fish plugins if available, else fallback to custom logic
if type -q fish_config
    # fish >= 3.1: enable autosuggestions and syntax highlighting by default
    set -g fish_features autosuggestion syntax_highlighting
end

# fzf integration (if installed)
if type -q fzf
    # fzf-tab equivalent: fish supports tab completion natively, but can enhance with fzf
    set -g FZF_DEFAULT_OPTS '--preview "bat --color=always {}" --preview-window=~3'
end

# Reload function (like zsh 'reload')
function reload --description 'Reload fish config'
    exec fish
end

# Fastfetch if available
if type -q fastfetch
    /Users/sametaor/.config/fastfetch/scripts/deusfetch.sh
end
