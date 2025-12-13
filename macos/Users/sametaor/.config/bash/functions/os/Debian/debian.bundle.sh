#!/usr/bin/env bash
# debian.bundle.sh — Utility functions for APT history, package listing, and kernel building

# Show APT history of installs, upgrades, removals, and rollback
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

# List packages by installed size, ordered numerically
apt-list-packages() {
  dpkg-query -W --showformat='${Installed-Size} ${Package} ${Status}\n' | \
    grep -v deinstall | \
    sort -n | \
    awk '{print $1, $2}'
}

# Kernel package build shortcut
kerndeb() {
  # Temporarily remove any -j parallel build flags (e.g., -j3 causes issues)
  local MAKEFLAGS="${MAKEFLAGS//-j*/}"
  echo "MAKEFLAGS set to '$MAKEFLAGS'"

  local appendage='-custom' # Shows in kernel version string
  local revision
  revision=$(date +"%Y%m%d") # Shows in .deb filename

  make-kpkg clean

  time fakeroot make-kpkg --append-to-version "$appendage" --revision "$revision" kernel_image kernel_headers
}