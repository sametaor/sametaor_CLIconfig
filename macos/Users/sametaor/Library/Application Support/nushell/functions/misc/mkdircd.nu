
export def --env mkdircd_mod [
  dir: string       # Directory to create and enter
  --parents(-p)     # Create parent directories as needed
  --verbose(-v)     # Print created directory
] {
  if $verbose {
    print $"Creating directory: ($dir)"
  }
  
  try {
    mkdir $dir
    if $verbose {
      print $"Created: ($dir)"
    }
    cd $dir
  } catch {
    print -e $"Error: Could not create directory '($dir)'"
    return 1
  }
}
