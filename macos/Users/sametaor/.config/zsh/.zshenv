# Zsh dotfiles' location
export ZDOTDIR="${HOME}/.config/zsh"

# General environment vars
export EDITOR=nvim
export VISUAL=$EDITOR
export PAGER=less
export LESS="-RFiX"
export LANG=en_US.UTF-8


# Let macOS path_helper run first, THEN lock your fpath
if [[ -o login ]]; then
  [[ -x /usr/libexec/path_helper ]] && eval $(/usr/libexec/path_helper -s)
fi

# PATH for non-interactive shells
typeset -U path PATH
path=(
	"$HOME/.local/bin"
	"/usr/local/bin"
	$path
)
export PATH

# History config
HISTFILE=$ZDOTDIR/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000
export HISTDUP=erase
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt INC_APPEND_HISTORY_TIME
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_LEX_WORDS
#setopt HIST_NO_STORE
#setopt HIST_NO_FUNCTIONS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
#setopt HIST_VERIFY

# Set default editor
export EDITOR=/usr/bin/nvim

# GPG for tty
export GPG_TTY=$(tty)

# Fzf default formatting
export FZF_DEFAULT_OPTS='--color=fg:#c8d3f5,fg+:#c8d3f5,bg:#222436,bg+:#2a2e54 --color=hl:#82aaff,hl+:#86e1fc,info:#c3e88d,marker:#ffc777 --color=prompt:#ff757f,spinner:#c099ff,pointer:#c099ff,header:#828bb8 --color=border:#6c75ba,label:#9da8ee,query:#c8d3f5 --border="rounded" --border-label="FZF" --border-label-pos="0" --preview-window="border-double" --padding="1" --margin="1" --prompt=">_ " --marker=">>" --pointer="=>" --separator="─" --scrollbar="|" --layout="reverse" --info="right" --tmux left,80% --height=80%'

# Pyenv vars
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

# DBUS and XDG vars
export XDG_RUNTIME_DIR="/run/user/$UID"
export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus"

if [[ -z "$XDG_RUNTIME_DIR" || ! -d "$XDG_RUNTIME_DIR" ]]; then
  export XDG_RUNTIME_DIR="/tmp/xdg-runtime-$UID"
  mkdir -p "$XDG_RUNTIME_DIR"
  chmod 700 "$XDG_RUNTIME_DIR"
fi

# Pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Pipx
export PATH="$PATH:$HOME/.local/bin"

# Cargo (Rust)
PATH="$PATH:$HOME/.cargo/bin"

# Nix package manager
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi

# For fzf-zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Perl5 Env vars
PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;

# Ruby for macOS Intel
if [ -d "/usr/local/opt/ruby/bin" ]; then
  export PATH=/usr/local/opt/ruby/bin:$PATH
  export PATH=`gem environment gemdir`/bin:$PATH
fi

# Eza config location
export EZA_CONFIG_DIR=$HOME/.config/eza
