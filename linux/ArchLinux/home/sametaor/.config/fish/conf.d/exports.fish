# Exported variables (for child processes)
# Example: set -x PATH $PATH /usr/local/bin
# --- Exported variables (ported from .zshenv/.zprofile) ---

# Locale

# Manpage colors and pager
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -gx MANROFFOPT -c
# Add your custom exported variables below
