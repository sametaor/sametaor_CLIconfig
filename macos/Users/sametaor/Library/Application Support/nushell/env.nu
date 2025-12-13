# General environment vars
$env.EDITOR = 'nvim'
$env.VISUAL = $env.EDITOR
$env.PAGER = 'less'
$env.LESS = "-RFiX"
$env.LANG = 'en_US.UTF-8'
$env.MANPAGER = "bat -plman"

# PATH for all shells (persistent PATH modifications)
$env.PATH = ($env.PATH | append [
  $"($nu.home-path)/.local/bin",
  '/usr/local/bin'
])
# Add Cargo, Perl5, pnpm, pipx, etc.
$env.PATH = ($env.PATH | append [
  $"($nu.home-path)/.cargo/bin",
  $'($nu.home-path)/.local/share/pnpm',
  $'($nu.home-path)/perl5/bin',
  $'($nu.home-path)/.local/bin',
  $'($nu.home-path)/.pyenv/bin',
  $'($nu.home-path)/go/bin'
])

# History config
$env.config.history = {
  max_size: 50_000
  sync_on_enter: true
}

# Zoxide loader
zoxide init nushell --cmd=cd | save -f `~/Library/Application Support/nushell/zoxide.nu`

# Python, Perl, and pnpm home
$env.PYENV_ROOT = $"($nu.home-path)/.pyenv"
$env.PNPM_HOME = $'($nu.home-path)/.local/share/pnpm'

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
$env.FZF_DEFAULT_OPTS = '--color=fg:-1,fg+:#d0d0d0,bg:-1,bg+:#20192b --color=hl:#6d77b3,hl+:#4adef5,info:#72f0b8,marker:#fede5d --color=prompt:#ff757f,spinner:#fede5d,pointer:#f1527e,header:#6d77b3 --color=border:#43c5fc,label:#ed70df,query:#efedfe --border="bold" --border-label="FZF" --border-label-pos="0" --preview-window="border-sharp" --padding="1" --margin="1" --prompt=" " --marker=" " --pointer="󰛡" --separator="─" --scrollbar="┃" --layout="reverse" --info="right" --tmux left,80% --height=80% --preview="~/.config/fzf/fzf-preview.sh {}"'

if ("/usr/local/opt/ruby/bin" | path exists) {
    let gem_bin = try { (^gem environment gemdir | str trim)/bin } catch { null }
    let new_paths = ([
        "/usr/local/opt/ruby/bin"
    ] | append (if $gem_bin != null { [$gem_bin] } else { [] }))
    $env.PATH = ($new_paths | prepend $env.PATH)
}

$env.EZA_CONFIG_DIR = $"($nu.home-path)/.config/eza"

# Ripgrep Config directory
$env.RIPGREP_CONFIG_PATH = $"($nu.home-path)/.config/ripgrep"
