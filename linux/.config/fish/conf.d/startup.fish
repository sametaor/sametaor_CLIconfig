# --- Modular Fish Loader: Replicate zsh/bash logic ---

# Helper: Recursively source all .bundle.fish files (immediate load)
for file in (find $HOME/.config/fish/functions -type f -name '*.bundle.fish' 2>/dev/null)
	source $file
end

# Helper: Source all regular .fish files in aliases and custom (autoload style)
for dir in $HOME/.config/fish/functions/aliases/* $HOME/.config/fish/functions/custom/*
	if test -d $dir
		for file in (find $dir -type f -name '*.fish' ! -name '*.bundle.fish' 2>/dev/null)
			source $file
		end
	end
end

# Source completions
for file in (find $HOME/.config/fish/completions -type f -name '*.fish' 2>/dev/null)
	source $file
end

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

# --- Key Bindings: Vi mode, history search, etc. ---
set -g fish_key_bindings fish_vi_key_bindings

# History substring search (up/down)
bind -M insert '\eOA' up-or-search
bind -M insert '\eOB' down-or-search
bind -M insert '\e[A' up-or-search
bind -M insert '\e[B' down-or-search


# Accept autosuggestion with right arrow (fixed)
bind -M insert '\e[C' accept-autosuggestion

# Removed problematic bind with unmatched brackets

# Reload function (like zsh 'reload')
function reload --description 'Reload fish config'
	exec fish
end

# Fastfetch if available
if type -q fastfetch
	fastfetch
end
