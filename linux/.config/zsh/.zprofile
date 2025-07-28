# PATH additions that require *,login* context (Homebrew on macOS, LXD snap…)
# Homebrew (Linuxbrew / macOS) ─ add its bin/sbin once per login
if [[ -d "/home/linuxbrew/.linuxbrew/bin" ]]; then
  [[ -d /home/linuxbrew/.linuxbrew/bin ]] && path+=( /home/linuxbrew/.linuxbrew/bin )
  [[ -d /home/linuxbrew/.linuxbrew/sbin ]] && path+=( /home/linuxbrew/.linuxbrew/sbin )
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ -d "/opt/homebrew/bin" ]]; then               # Apple-Silicon
  [[ -d /opt/homebrew/bin ]] && path+=( /opt/homebrew/bin )
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
export PATH

eval "$(pyenv init -)" # makes python shim visible

# Oh-my-posh init
eval "$(oh-my-posh init zsh --config "https://raw.githubusercontent.com/sametaor/sametaor_CLIconfig/master/misc/sametaor.omp.json")"

# Zoxide init
eval "$(zoxide init zsh)"