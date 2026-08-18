#!/usr/bin/env bash
# arch.bundle.sh — Arch Linux upgrade and pacman helper functions

# Check Arch Linux PGP Keyring before system upgrade to prevent failure
upgrade() {
  sudo pacman -Sy
  echo ":: Checking Arch Linux PGP Keyring..."

  local installedver currentver

  installedver=$(LANG= sudo pacman -Qi archlinux-keyring | grep -Po '(?<=Version\s+: ).*')
  currentver=$(LANG= sudo pacman -Si archlinux-keyring | grep -Po '(?<=Version\s+: ).*')

  if [[ "$installedver" != "$currentver" ]]; then
    echo " Arch Linux PGP Keyring is out of date."
    echo " Updating before full system upgrade."
    sudo pacman -S --needed --noconfirm archlinux-keyring
  else
    echo " Arch Linux PGP Keyring is up to date."
    echo " Proceeding with full system upgrade."
  fi

  if command -v yay &> /dev/null; then
    yay -Su
  elif command -v trizen &> /dev/null; then
    trizen -Su
  elif command -v pacaur &> /dev/null; then
    pacaur -Su
  elif command -v aura &> /dev/null; then
    sudo aura -Su
  else
    sudo pacman -Su
  fi
}

# List explicitly installed packages and their search info
paclist() {
  pacman -Qqe | xargs -r -P0 -I{} pacman -Qs --color=auto "^{}$"
}

# Find files in filesystem not owned by any package (disowned files)
pacdisowned() {
  local tmp_dir db fs
  tmp_dir=$(mktemp -d) || return 1
  db="$tmp_dir/db"
  fs="$tmp_dir/fs"

  trap 'rm -rf -- "$tmp_dir"' EXIT

  pacman -Qlq | sort -u > "$db"
  find /etc /usr ! -name lost+found \( -type d -printf '%p/\n' -o -print \) | sort > "$fs"

  comm -23 "$fs" "$db"
}

# Refresh Pacman keys
alias pacmanallkeys='sudo pacman-key --refresh-keys'

# Sign keys
pacmansignkeys() {
  local key
  for key in "$@"; do
    sudo pacman-key --recv-keys "$key"
    sudo pacman-key --lsign-key "$key"
    printf 'trust\n3\n' | sudo gpg --homedir /etc/pacman.d/gnupg \
      --no-permission-warning --command-fd 0 --edit-key "$key"
  done
}

# Open Arch package webpage (if xdg-open available)
if command -v xdg-open &> /dev/null; then
  pacweb() {
    if [[ $# -eq 0 || "$1" =~ ^(--help|-h)$ ]]; then
      echo "$0 - open the website of an ArchLinux package"
      echo
      echo "Usage: $0 <package>"
      return 1
    fi

    local pkg="$1"
    local infos repo arch

    infos=$(LANG=C pacman -Si "$pkg")
    if [[ -z "$infos" ]]; then return 1; fi

    repo=$(grep -m1 '^Repo' <<< "$infos" | awk '{print $3}')
    arch=$(grep -m1 '^Arch' <<< "$infos" | awk '{print $3}')

    xdg-open "https://www.archlinux.org/packages/$repo/$arch/$pkg/" &> /dev/null
  }
fi