# Upgrade all installed packages
def pipupall [] {
  pip list --outdated 
  | lines 
  | skip 2 
  | parse "{package} {current} {latest} {type}"
  | get package
  | each { |pkg| pip install --upgrade $pkg }
}

# Uninstall all installed packages
def pipunall [] {
  pip list --format freeze 
  | lines
  | split column "=" package version
  | get package
  | each { |pkg| pip uninstall $pkg }
}

# Install from GitHub repository
def pipig [repo: string] {
  pip install $"git+https://github.com/($repo).git"
}

# Install from GitHub branch
def pipigb [
  repo: string  # GitHub repository (owner/repo)
  branch: string  # Branch name
] {
  pip install $"git+https://github.com/($repo).git@($branch)"
}

# Install from GitHub pull request
def pipigp [
  repo: string  # GitHub repository (owner/repo)
  pr: int  # Pull request number
] {
  pip install $"git+https://github.com/($repo).git@refs/pull/($pr)/head"
}
