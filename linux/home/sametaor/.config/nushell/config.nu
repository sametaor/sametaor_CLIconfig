# Source env.nu for environment variables

source-env ($nu.default-config-dir | path join 'env.nu')

source ($nu.default-config-dir | path join 'profile.nu')

# Source login.nu to emulate zsh's .zlogin loading structure
source ($nu.default-config-dir | path join 'login.nu')

# Setup directories and files to be autoloaded right away
$env.NU_USER_AUTOLOAD_DIRS = [
    ($nu.default-config-dir | path join "autoload/**/*.nu")
]

$env.config = {
  show_banner: false
  use_ansi_coloring: true
  edit_mode: vi
  rm: {
    always_trash: true
  }
  cursor_shape: {
    emacs: "blink_line"
    vi_insert: "blink_underscore"
    vi_normal: "blink_block"
  }
  completions: {
    algorithm: "fuzzy"
  }
  table: {
    mode: "double"
    show_empty: false
    missing_value_symbol: "⛌ "
  }
}

if ("~/.config/fastfetch/scripts/" | path exists) {
  ~/.config/fastfetch/scripts/deusfetch.sh
}

# Module lazy-loading
use functions/ Func_mod *
use aliases/ aliases_mod *

$env.config.hooks.command_not_found = {|cmd_name|
  command_not_found_handler $cmd_name
  null  # Return null to signal we handled it
}

# In config.nu
$env.config.keybindings = ($env.config.keybindings | append {
  name: doas_command_line
  modifier: control
  keycode: char_d
  mode: [emacs, vi_normal, vi_insert]
  event: {
    send: executehostcommand
    cmd: "doas-command-line"
  }
})

# Importing plugin
plugin use desktop_notifications

$env.config.display_errors.exit_code = true

$env.PROMPT_INDICATOR = " "
$env.PROMPT_INDICATOR_VI_NORMAL = " N "
$env.PROMPT_INDICATOR_VI_INSERT = "󱩽 I "
