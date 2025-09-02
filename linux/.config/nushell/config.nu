# Set prompt to mimic Zsh style
let-env PROMPT_COMMAND = { || $"(whoami)@($hostname):($pwd) > " }
prompt = $PROMPT_COMMAND

# Aliases (Zsh style mapped to Nushell)
alias ll = eza -l --git
alias la = eza -la --git
alias l = eza -l
alias ls = eza

# Common navigation aliases
alias .. = cd ..
alias ... = cd ../..
alias .... = cd ../../..
alias ~ = cd ~

# Clear screen
alias c = clear

# Grep with color
alias grep = grep --color=auto

# Use bat as cat replacement if available
alias cat = bat

# Source env.nu for environment variables
source-env ~/env.nu