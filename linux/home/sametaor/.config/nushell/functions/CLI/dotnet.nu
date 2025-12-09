
# dotnet-completions.nu
# ------------------------------------------------------------------------------
# Description
# -----------
#
# Completions for .NET CLI (dotnet command)
#
# ------------------------------------------------------------------------------

# Custom completer for dotnet command
def "nu-complete dotnet" [context: string] {
  # Get the current command line
  let words = ($context | split row ' ')
  
  # Call dotnet's built-in completion
  let completions = (do -i { 
    ^dotnet complete $context 
  } | complete)
  
  # If dotnet complete failed or returned empty, return empty list
  if $completions.exit_code != 0 or ($completions.stdout | is-empty) {
    return []
  }
  
  # Parse completions (one per line)
  $completions.stdout 
  | lines 
  | where {|line| ($line | str trim | is-not-empty)}
  | each {|line| 
      {
        value: $line,
        description: ""
      }
    }
}

# Main dotnet command with custom completions
export extern dotnet_func [
  ...args: string@"nu-complete dotnet"  # All arguments use custom completer
]
