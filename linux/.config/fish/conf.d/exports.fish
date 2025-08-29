# Exported variables (for child processes)
# Example: set -x PATH $PATH /usr/local/bin
# --- Exported variables (ported from .zshenv/.zprofile) ---

# Locale
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

# Pager
set -gx PAGER less

# Manpage colors and pager
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -gx MANROFFOPT "-c"
# Add your custom exported variables below

