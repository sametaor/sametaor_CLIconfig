# command-not-found.bundle.bash — Bash-compatible command-not-found handlers

# 1) Arch Linux (pkgfile)
# Requires: sudo pacman -S pkgfile && sudo pkgfile --update
# Newer pkgfile ships a bash handler at /usr/share/doc/pkgfile/command-not-found.bash
# Older installs may only have the zsh file; we’ll source if readable.
for file in \
  /usr/share/doc/pkgfile/command-not-found.bash \
  /usr/share/doc/pkgfile/command-not-found.zsh \
  /opt/homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh \
  /usr/local/Homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh \
  /home/linuxbrew/.linuxbrew/Homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh
do
  if [ -r "$file" ]; then
    # shellcheck disable=SC1090
    . "$file"
    unset file
    # If the sourced file provided a handler, stop here
    type command_not_found_handle >/dev/null 2>&1 && return 0
    break
  fi
done
unset file

# If no handler was provided by the sourced files, define our own handlers
# Note: Bash calls command_not_found_handle (not ..._handler as in zsh)

# 2) Debian/Ubuntu command-not-found
if [ -x /usr/lib/command-not-found ] || [ -x /usr/share/command-not-found/command-not-found ]; then
  command_not_found_handle() {
    if [ -x /usr/lib/command-not-found ]; then
      /usr/lib/command-not-found -- "$1"
      return $?
    elif [ -x /usr/share/command-not-found/command-not-found ]; then
      /usr/share/command-not-found/command-not-found -- "$1"
      return $?
    else
      printf "bash: %s: command not found\n" "$1" >&2
      return 127
    fi
  }
fi

# 3) Fedora (PackageKit)
if [ -x /usr/libexec/pk-command-not-found ]; then
  command_not_found_handle() {
    if [ -S /var/run/dbus/system_bus_socket ] && [ -x /usr/libexec/packagekitd ]; then
      /usr/libexec/pk-command-not-found "$@"
      return $?
    fi
    printf "bash: %s: command not found\n" "$1" >&2
    return 127
  }
fi

# 4) NixOS
if [ -x /run/current-system/sw/bin/command-not-found ]; then
  command_not_found_handle() {
    /run/current-system/sw/bin/command-not-found "$@"
  }
fi

# 5) Termux
if [ -x /data/data/com.termux/files/usr/libexec/termux/command-not-found ]; then
  command_not_found_handle() {
    /data/data/com.termux/files/usr/libexec/termux/command-not-found "$1"
  }
fi

# 6) SUSE and derivatives
if [ -x /usr/bin/command-not-found ]; then
  command_not_found_handle() {
    /usr/bin/command-not-found "$1"
  }
fi

# 7) Homebrew handler (if not already sourced above)
# These paths covered earlier in the for-loop; kept here as a fallback if none set:
if ! type command_not_found_handle >/dev/null 2>&1; then
  for file in \
    /opt/homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh \
    /usr/local/Homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh \
    /home/linuxbrew/.linuxbrew/Homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh
  do
    if [ -r "$file" ]; then
      # shellcheck disable=SC1090
      . "$file"
      type command_not_found_handle >/dev/null 2>&1 && break
    fi
  done
fi

# 8) Final fallback if nothing installed/available
# Only define if still missing so we don’t override distro-provided behavior.
if ! type command_not_found_handle >/dev/null 2>&1; then
  command_not_found_handle() {
    printf "bash: %s: command not found\n" "$1" >&2
    return 127
  }
fi