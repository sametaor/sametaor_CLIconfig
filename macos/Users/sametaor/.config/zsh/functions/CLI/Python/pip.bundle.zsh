# Upgrade all installed packages
function pipupall {
  # non-GNU xargs does not support nor need `--no-run-if-empty`
  local xargs="xargs --no-run-if-empty"
  xargs --version 2>/dev/null | grep -q GNU || xargs="xargs"
  pip list --outdated | awk 'NR > 2 { print $1 }' | ${=xargs} pip install --upgrade
}

# Uninstall all installed packages
function pipunall {
  # non-GNU xargs does not support nor need `--no-run-if-empty`
  local xargs="xargs --no-run-if-empty"
  xargs --version 2>/dev/null | grep -q GNU || xargs="xargs"
  pip list --format freeze | cut -d= -f1 | ${=xargs} pip uninstall
}

# Install from GitHub repository
function pipig {
  pip install "git+https://github.com/$1.git"
}
compdef _pip pipig

# Install from GitHub branch
function pipigb {
  pip install "git+https://github.com/$1.git@$2"
}
compdef _pip pipigb

# Install from GitHub pull request
function pipigp {
  pip install "git+https://github.com/$1.git@refs/pull/$2/head"
}
compdef _pip pipigp