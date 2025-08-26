[[ $- == *i* ]] && source -- ~/.local/share/blesh/ble.sh --attach=none --rcfile ~/.config/bash/.blerc

# --- Key Bindings ---
bind -m vi-insert '"\C-l": clear-screen'
bind -m vi-insert '"\C-w": backward-kill-word'

# --- Environment/Paths ---
export USERNAME=sametaor
export BASH_CONFIG_DIR="${HOME}/.config/bash"
export EDITOR=nvim
export VISUAL="$EDITOR"
export PAGER=less
export LESS="-RFiX"
export LANG=en_US.UTF-8
PATH="$HOME/.local/bin:/usr/local/bin:$PATH"
export PATH

# --- History ---
export HISTFILE="$HOME/.config/bash/.bash_history"
export HISTSIZE=50000
export HISTFILESIZE=50000
export HISTCONTROL=ignoreboth:erasedups
export HISTTIMEFORMAT='[%F %T] '

# --- Cache Directory ---
BASH_CACHE_DIR="$BASH_CONFIG_DIR/cache"
mkdir -p "$BASH_CACHE_DIR"
# Optional: find "$BASH_CACHE_DIR" -type f -mtime +30 -delete 2>/dev/null

# --- Extra Env/Tooling Setup ---
export GPG_TTY=$(tty)
export FZF_DEFAULT_OPTS='--color=fg:#c8d3f5,fg+:#c8d3f5,bg:#222436,bg+:#2a2e54 --color=hl:#82aaff,hl+:#86e1fc,info:#c3e88d,marker:#ffc777 --color=prompt:#ff757f,spinner:#c099ff,pointer:#c099ff,header:#828bb8 --color=border:#6c75ba,label:#9da8ee,query:#c8d3f5 --border="rounded" --border-label="FZF" --border-label-pos="0" --preview-window="border-double" --padding="1" --margin="1" --prompt=">_ " --marker=">>" --pointer="=>" --separator="─" --scrollbar="|" --layout="reverse" --info="right" --tmux left,80% --height=80%'
export PYENV_ROOT="$HOME/.pyenv"
if [[ -d "$PYENV_ROOT/bin" ]]; then export PATH="$PYENV_ROOT/bin:$PATH"; fi
export XDG_RUNTIME_DIR="/run/user/$UID"
export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus"
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in *":$PNPM_HOME:"*) ;; *) export PATH="$PNPM_HOME:$PATH" ;; esac
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"
if [[ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then . "$HOME/.nix-profile/etc/profile.d/nix.sh"; fi
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export PATH="/home/sametaor/perl5/bin${PATH:+:${PATH}}"
export PERL5LIB="/home/sametaor/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL_LOCAL_LIB_ROOT="/home/sametaor/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_MB_OPT="--install_base \"/home/sametaor/perl5\""
export PERL_MM_OPT="INSTALL_BASE=/home/sametaor/perl5"

# --- Login/Logout Logic (Homebrew, pyenv, oh-my-posh, zoxide, Arch cleanup) ---
if [[ -d "/home/linuxbrew/.linuxbrew/bin" ]]; then
  [[ -d /home/linuxbrew/.linuxbrew/bin ]] && PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
  [[ -d /home/linuxbrew/.linuxbrew/sbin ]] && PATH="/home/linuxbrew/.linuxbrew/sbin:$PATH"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ -d "/opt/homebrew/bin" ]]; then
  [[ -d /opt/homebrew/bin ]] && PATH="/opt/homebrew/bin:$PATH"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
export PATH
if command -v pyenv >/dev/null 2>&1; then eval "$(pyenv init -)"; fi
if command -v zoxide >/dev/null 2>&1; then eval "$(zoxide init bash)"; fi
if [[ -f /etc/arch-release ]] && command -v ifne >/dev/null 2>&1 && command -v doas >/dev/null 2>&1; then
  sudo pacman -Syu && yay -a && sudo pacman -Qdtq | ifne sudo pacman -Rns - && sudo pacman -Scc --noconfirm && yay -a -Scc --noconfirm
elif ! command -v ifne >/dev/null 2>&1; then
  sudo pacman -Syu && yay -a
  orphans=$(sudo pacman -Qdtq)
  if [[ -n "$orphans" ]]; then
    echo "$orphans" | sudo pacman -Rns -
  fi
  sudo pacman -Scc --noconfirm && yay -a -Scc --noconfirm
fi

# --- Shell Options ---
shopt -s nullglob
shopt -s globstar
shopt -s autocd extglob failglob promptvars
set -o vi; export KEYTIMEOUT=1


# --- Plugin Loader: Source all plugin-functions ---
for file in "$BASH_CONFIG_DIR"/plugin-functions/*.sh; do
  [ -r "$file" ] && source "$file"
done

# --- Bundle Loader: Source all .bundle.sh files (recursively) ---
for file in "$BASH_CONFIG_DIR"/**/*.bundle.sh; do
  [ -r "$file" ] && source "$file"
done

# --- Aliases Loader: Source all alias files (recursively) ---
for file in "$BASH_CONFIG_DIR"/aliases/**/*.sh; do
  [ -r "$file" ] && source "$file"
done

# --- Functions Loader: Register lazy-loaders for all .sh files except bundles/plugins (recursively) ---
for file in "$BASH_CONFIG_DIR"/**/*.sh; do
  [[ "$file" == *.bundle.sh ]] && continue
  [[ "$file" == */plugin-functions/* ]] && continue
  [[ "$file" == */aliases/* ]] && continue
  fname="${file##*/}"; fname="${fname%.*}"
  eval "
    $fname() {
      source \"$file\"
      $fname \"$@\"
    }
  "
done

# --- Completions ---
if [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
elif [ -f /usr/share/bash-completion/bash_completion ]; then
  source /usr/share/bash-completion/bash_completion
elif [ -f /usr/local/etc/bash_completion ]; then
  source /usr/local/etc/bash_completion
fi

# --- Misc ---
alias reload='source ~/.bashrc'
command -v fastfetch >/dev/null 2>&1 && fastfetch

# --- Ble.sh compatible oh-my-posh VI-MODE indicators:-
function ble_vi_mode_env {
  local mode="$_ble_decode_keymap"
  case "$mode" in
    (vi_nmap) export VI_MODE=" N" ;;    # Normal
    (vi_imap) export VI_MODE="󱩽 I" ;;    # Insert
    (vi_vmap) export VI_MODE=" V" ;;    # Visual
    (vi_Vmap) export VI_MODE="󰡮 VL" ;;   # Visual Line
    (vi_smap|vi_xmap) export VI_MODE="󱂔 VB" ;;   # Visual Block/Select
    (vi_Rmap) export VI_MODE=" R" ;;    # Replace
    (*) export VI_MODE="" ;;
  esac
}
PROMPT_COMMAND="ble_vi_mode_env${PROMPT_COMMAND:+; $PROMPT_COMMAND}"

# --- Oh My Posh prompt (must be last, only in interactive shells) ---
if [[ $- == *i* ]] && command -v oh-my-posh >/dev/null 2>&1; then
  eval "$(oh-my-posh init bash --config 'https://raw.githubusercontent.com/sametaor/sametaor_CLIconfig/master/misc/sametaor.omp.json')"
fi

[[ ! ${BLE_VERSION-} ]] || ble-attach

