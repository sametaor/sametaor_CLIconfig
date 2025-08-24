#!/usr/bin/env bash
# ubuntu.bundle.sh — apt repository add, apt history, kerndeb, apt list size

# Add a PPA and install a package (defaults package name from PPA URL)
aar() {
  local repo="$1"
  local package="$2"

  if [ -n "$package" ]; then
    PACKAGE="$package"
  else
    read -rp "Type in the package name to install/upgrade with this ppa [${repo##*/}]: " PACKAGE
  fi

  if [ -z "$PACKAGE" ]; then
    PACKAGE="${repo##*/}"
  fi

  sudo apt-add-repository "$repo" && sudo $APT update
  sudo $APT install "$PACKAGE"
}

# Print apt history logs filtered by action
apt-history() {
  case "$1" in
    install)
      zgrep --no-filename 'install ' $(ls -rt /var/log/dpkg*) ;;
    upgrade|remove)
      zgrep --no-filename "$1" $(ls -rt /var/log/dpkg*) ;;
    rollback)
      zgrep --no-filename upgrade $(ls -rt /var/log/dpkg*) | \
        grep "$2" -A10000000 | \
        grep "$3" -B10000000 | \
        awk '{print $4"="$5}' ;;
    list)
      zgrep --no-filename '' $(ls -rt /var/log/dpkg*) ;;
    *)
      echo "Parameters:"
      echo " install  - Lists all packages that have been installed."
      echo " upgrade  - Lists all packages that have been upgraded."
      echo " remove   - Lists all packages that have been removed."
      echo " rollback - Lists rollback information."
      echo " list     - Lists all contents of dpkg logs." ;;
  esac
}

# Build kernel package shortcut
kerndeb() {
  # Remove any -j flags from MAKEFLAGS (to avoid build failures)
  MAKEFLAGS=$(echo "$MAKEFLAGS" | perl -pe 's/-j\s*\d+//g')
  echo "MAKEFLAGS set to '$MAKEFLAGS'"

  local appendage='-custom'         # appended to kernel version string
  local revision=$(date +"%Y%m%d") # appended to .deb filename

  make-kpkg clean

  time fakeroot make-kpkg --append-to-version "$appendage" --revision "$revision" kernel_image kernel_headers
}

# List installed packages by size (excluding deinstalled)
apt-list-packages() {
  dpkg-query -W --showformat='${Installed-Size} ${Package} ${Status}\n' | \
  grep -v deinstall | sort -n | awk '{print $1, $2}'
}