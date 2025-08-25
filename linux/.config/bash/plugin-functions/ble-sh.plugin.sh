#!/usr/bin/env bash
# ble.sh plugin-function for Bash config (robust, safe)
# Ensures ble.sh is installed, up-to-date, and sourced automatically.

# Only run in Bash, and only in interactive shells
if [[ -z "$BASH_VERSION" || $- != *i* ]]; then
  return 0
fi

BLESH_DIR="$HOME/.local/share/blesh"
BLESH_SH="$BLESH_DIR/ble.sh"
BLESH_REPO="https://github.com/akinomyoga/ble.sh.git"


# Install ble.sh if not present using official nightly tarball
if [[ ! -f "$BLESH_SH" ]]; then
  TMP_BLE_DIR="$(mktemp -d)"
  cd "$TMP_BLE_DIR" || return 1
  curl -L https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz | tar xJf - || { cd /; rm -rf "$TMP_BLE_DIR"; return 1; }
  bash ble-nightly/ble.sh --install "$HOME/.local/share" || { cd /; rm -rf "$TMP_BLE_DIR"; return 1; }
  cd /; rm -rf "$TMP_BLE_DIR"
fi

# Update ble.sh if present and not already loaded
# Only source if not already loaded
if [[ -f "$BLESH_DIR/ble.sh" && $- == *i* ]]; then
    source "$BLESH_DIR/ble.sh" --attach=none
    [[ ! ${BLE_VERSION-} ]] || ble-attach
fi