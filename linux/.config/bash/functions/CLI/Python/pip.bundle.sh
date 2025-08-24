# pip.bundle.sh — Bash compatible pip functions

# Upgrade all installed packages
pipupall() {
  # non-GNU xargs does not support nor need --no-run-if-empty
  local xargs_cmd="xargs --no-run-if-empty"
  if ! xargs --version 2>/dev/null | grep -q GNU ; then
    xargs_cmd="xargs"
  fi
  pip list --outdated | awk 'NR > 2 { print $1 }' | $xargs_cmd pip install --upgrade
}

# Uninstall all installed packages
pipunall() {
  # non-GNU xargs does not support nor need --no-run-if-empty
  local xargs_cmd="xargs --no-run-if-empty"
  if ! xargs --version 2>/dev/null | grep -q GNU ; then
    xargs_cmd="xargs"
  fi
  pip list --format freeze | cut -d= -f1 | $xargs_cmd pip uninstall
}

# Install from GitHub repository
pipig() {
  pip install "git+https://github.com/$1.git"
}

# Install from GitHub branch
pipigb() {
  pip install "git+https://github.com/$1.git@$2"
}

# Install from GitHub pull request
pipigp() {
  pip install "git+https://github.com/$1.git@refs/pull/$2/head"
}