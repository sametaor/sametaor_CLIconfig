
# copypath.nu

export def copypath_mod [
  file?: string  # Path to copy (default: current directory)
] {
  # If no argument passed, use current directory
  let target = if ($file | is-empty) { "." } else { $file }
  
  # If argument is not an absolute path, prepend $PWD
  let full_path = if ($target | str starts-with "/") {
    $target
  } else {
    $"($env.PWD)/($target)"
  }
  
  # Resolve to absolute path
  let abs_path = try {
    $full_path | path expand
  } catch {
    print -e $"Error: Cannot resolve path '($target)'"
    return 1
  }
  
  # Copy the absolute path to clipboard
  let copy_result = (do -i { 
    $abs_path | ^clipcopy 
  } | complete)
  
  if $copy_result.exit_code != 0 {
    print -e "Error: clipcopy failed"
    return 1
  }
  
  print $"(ansi bold)($abs_path)(ansi reset) copied to clipboard."
}
