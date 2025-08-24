# Remove any temp files, notify user, etc.
rm -f "$BASH_CACHE_DIR/last-session-$$" 2>/dev/null

# Print username using bash syntax
echo "Cya $USER!"