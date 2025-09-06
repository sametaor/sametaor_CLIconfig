# Zsh dotfiles' (now zshenv) equivalent location - no direct Nushell equivalent
# Default Nushell config is in ~/.config/nushell

# General environment vars
$env.EDITOR = 'nvim'
$env.VISUAL = $env.EDITOR
$env.PAGER = 'less'
$env.LESS = "-RFiX"
$env.LANG = 'en_US.UTF-8'

# PATH for all shells (persistent PATH modifications)
$env.PATH = ($env.PATH | append [
  $"($nu.home-path)/.local/bin",
  '/usr/local/bin'
])
# Add Cargo, Perl5, pnpm, pipx, etc.
$env.PATH = ($env.PATH | append [
  $"($nu.home-path)/.cargo/bin",
  '/home/sametaor/.local/share/pnpm',
  '/home/sametaor/perl5/bin',
  '/home/sametaor/.local/bin'
])
# .nix-profile (uses file existence check)
#source /home/sametaor/.nix-profile/etc/profile.d/nix.sh

# Python, Perl, and pnpm home
$env.PYENV_ROOT = $"($nu.home-path)/.pyenv"
$env.PNPM_HOME = '/home/sametaor/.local/share/pnpm'

# Perl5 environment
$env.PERL5LIB = "/home/sametaor/perl5/lib/perl5${env.PERL5LIB:+:${env.PERL5LIB}}"
$env.PERL_LOCAL_LIB_ROOT = "/home/sametaor/perl5${env.PERL_LOCAL_LIB_ROOT:+:${env.PERL_LOCAL_LIB_ROOT}}"
$env.PERL_MB_OPT = '--install_base "/home/sametaor/perl5"'
$env.PERL_MM_OPT = 'INSTALL_BASE=/home/sametaor/perl5'

# XDG and DBUS runtime (user/session bus)
$env.XDG_RUNTIME_DIR = "/run/user/($env.USER | default $env.UID)"
$env.DBUS_SESSION_BUS_ADDRESS = $"unix:path=($env.XDG_RUNTIME_DIR)/bus"

# GPG TTY - requires subshell spawn for `tty` output in nu
let gpg_tty = (tty | complete | get stdout | str trim)
$env.GPG_TTY = $gpg_tty

# FZF default color/format opts
$env.FZF_DEFAULT_OPTS = "--color=fg:#c8d3f5,fg+:#c8d3f5,bg:#222436,bg+:#2a2e54 --color=hl:#82aaff,hl+:#86e1fc,info:#c3e88d,marker:#ffc777 --color=prompt:#ff757f,spinner:#c099ff,pointer:#c099ff,header:#828bb8 --color=border:#6c75ba,label:#9da8ee,query:#c8d3f5 --border=\"rounded\" --border-label=\"FZF\" --border-label-pos=\"0\" --preview-window=\"border-double\" --padding=\"1\" --margin=\"1\" --prompt=\">_ \" --marker=\">>\" --pointer=\"=>\" --separator=\"─\" --scrollbar=\"|\" --layout=\"reverse\" --info=\"right\" --tmux left,80% --height=80%"