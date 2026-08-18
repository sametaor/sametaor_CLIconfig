# Remove any temp files, notify user, etc.
rm -f "$ZSH_CACHE_DIR"/last-session-$$ 2>/dev/null
echo "Cya $(print -Pn '%n')!"