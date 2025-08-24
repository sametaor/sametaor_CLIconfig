#!/usr/bin/env bash
# auto-notify.opts.sh — user options for bash-auto-notify plugin

export AUTO_NOTIFY_THRESHOLD=60                # Notify if command runs longer than 60 seconds
export AUTO_NOTIFY_TITLE="%command finished"   # Notification title template
export AUTO_NOTIFY_BODY="%command took %elapsed seconds with exit code %exit_code"  # Body template
export AUTO_NOTIFY_EXPIRE_TIME=5000                  # Notification display time in ms (5s)