#!/usr/bin/env bash
# ble.sh plugin-function for Bash config (robust, safe)
# Ensures ble.sh is installed, up-to-date.

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