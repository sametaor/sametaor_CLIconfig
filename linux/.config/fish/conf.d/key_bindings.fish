
# --- Key bindings (ported from .zshrc/.blerc) ---

# Enable vi mode
fish_vi_key_bindings

# FZF key bindings (if fzf installed)
if type -q fzf
	bind \ct 'fzf | read -l result; and commandline -i $result'
	bind \cr 'history | fzf | read -l result; and commandline -r $result'
end

# History substring search (up/down)
bind \e\A history-search-backward
bind \e\B history-search-forward

# Custom navigation (Ctrl+L to clear, Ctrl+U to erase line)
bind \cl 'clear; commandline -f repaint'
bind \cu backward-kill-line

# Insert literal tab with Ctrl+V
bind \cv self-insert

