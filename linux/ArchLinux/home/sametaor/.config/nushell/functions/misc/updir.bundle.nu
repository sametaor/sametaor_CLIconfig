# updir.nu - Complete working version

def --env updir [
  n: int = 1  # Number of directories to move up (1-99)
] {
  # Validate input
  if $n < 1 or $n > 99 {
    print "Usage: updir <1-99>"
    return 1
  }
  
  # Try zoxide first
  if (which zoxide | is-not-empty) {
    # Generate query path: "../../../..." (n times)
    let query_path = (
      (1..$n)
      | each { |_| ".." }
      | str join "/"
    )
    
    let zoxide_result = (do -i { ^zoxide query $query_path } | complete)
    
    if $zoxide_result.exit_code == 0 {
      let target = ($zoxide_result.stdout | str trim)
      if ($target | is-not-empty) and ($target | path exists) {
        cd $target
        print $"Jumped to: ($target)"
        return
      }
    }
  }
  
  # Fallback: manual ../ path
  let target = (
    (1..$n)
    | each { |_| ".." }
    | str join "/"
  )
  
  cd $target
  print $"Moved up ($n) directories"
}

# Generate z1 to z10 aliases
export alias z1  = updir 1
export alias z2  = updir 2
export alias z3  = updir 3
export alias z4  = updir 4
export alias z5  = updir 5
export alias z6  = updir 6
export alias z7  = updir 7
export alias z8  = updir 8
export alias z9  = updir 9
export alias z10 = updir 10
