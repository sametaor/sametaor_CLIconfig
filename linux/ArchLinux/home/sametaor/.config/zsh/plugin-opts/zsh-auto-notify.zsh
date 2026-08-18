# Set threshold for auto-notify in Zsh
# Default is 10 seconds
ZSH_AUTO_NOTIFY_THRESHOLD=60

# Set formatting for the notification
export AUTO_NOTIFY_TITLE="%command finished"
export AUTO_NOTIFY_BODY="%command took %elapsed seconds with exit code %exit_code"

# Set the notification expiration time
# Default is 8 seconds
# Set to 5000 milliseconds (5 seconds) for quicker notifications
export AUTO_NOTIFY_EXPIRE_TIME=5000