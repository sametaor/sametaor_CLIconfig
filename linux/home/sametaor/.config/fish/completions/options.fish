
# --- Custom completions (modular) ---

# Source all completions in completions/ if present
for f in $HOME/.config/fish/completions/*.fish
	if test -f $f
		source $f
	end
end

