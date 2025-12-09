
# doas-command-line.nu
# ------------------------------------------------------------------------------
# Description
# -----------
#
# doas will be inserted before the command
#
# ------------------------------------------------------------------------------
# Authors
# -------
#
# * Anatoly <akopyl@radner.ru>
# * Converted to Nushell
#
# ------------------------------------------------------------------------------

# Add doas to the current command line or remove it if already present
export def doas-command-line [] {
  # Get current buffer (command line content)
  let buffer = (commandline)
  
  # If buffer is empty, get the last command from history
  let current = if ($buffer | is-empty) {
    history | last | get command
  } else {
    $buffer
  }
  
  # Toggle doas prefix
  let new_command = if ($current | str starts-with "doas ") {
    # Remove doas if it's already there
    $current | str substring 5..
  } else {
    # Add doas if it's not there
    $"doas ($current)"
  }
  
  # Update the command line
  commandline edit --replace $new_command
}
