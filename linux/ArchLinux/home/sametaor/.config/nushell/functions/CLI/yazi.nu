
# y.nu (production version)

# Open yazi at given directory or zoxide suggestion
export def --env y [
  target?: string  # Directory path or zoxide query
] {
  if ($target | is-empty) {
    # No argument, open in current directory
    ^yazi
  } else if ($target | path exists) and ($target | path type) == "dir" {
    # Valid directory path
    ^yazi $target
  } else {
    # Try zoxide query
    let zoxide_result = (do -i { ^zoxide query $target } | complete)
    
    if $zoxide_result.exit_code == 0 and ($zoxide_result.stdout | str trim | is-not-empty) {
      let zoxide_path = ($zoxide_result.stdout | str trim)
      ^yazi $zoxide_path
    } else {
      print -e $"Error: zoxide could not find a match for '($target)'"
    }
  }
}
