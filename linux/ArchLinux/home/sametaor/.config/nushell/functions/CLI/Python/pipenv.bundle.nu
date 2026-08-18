# Check if current directory or parent directories contain a Pipfile
def --env _pipenv_chpwd [] {
  let pipfile_in_pwd = ($env.PWD | path join "Pipfile" | path exists)
  let pipfile_in_parent = ($env.PWD | path join ".." "Pipfile" | path exists)
  let pipfile_in_grandparent = ($env.PWD | path join ".." ".." "Pipfile" | path exists)
  
  let should_cd = (not $pipfile_in_pwd) and ($pipfile_in_parent or $pipfile_in_grandparent)
  
  # Return early if no Pipfile found in pwd or up to 2 levels up
  if not ($pipfile_in_pwd or $pipfile_in_parent or $pipfile_in_grandparent) {
    return
  }
  
  # Check if pipenv is not already active
  if ($env.PIPENV_ACTIVE? | is-empty) {
    # Check if a virtual environment exists for this project
    let venv_check = (do -i { pipenv --venv } | complete)
    
    if $venv_check.exit_code == 0 {
      if $should_cd {
        pipenv shell $"cd ($env.PWD)"
      } else {
        pipenv shell
      }
    }
  }
}
