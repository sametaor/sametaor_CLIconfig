# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 7

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
 COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# fzf-tab stuff
zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:*' fzf-bindings 'ctrl-j:accept' 'ctrl-a:toggle-all'


# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git archlinux command-not-found copypath gh themes zsh-autosuggestions zsh-syntax-highlighting fzf-tab 1password aliases alias-finder zoxide battery brew chezmoi colored-man-pages colorize common-aliases cp direnv dotenv dotnet eza fzf git-auto-fetch git-commit git-escape-magic git-extras github git-lfs git-prompt gnu-utils history httpie man marktext npm pipenv pylint python rclone rsync ruby snap ssh ssh-agent sudo systemd thefuck themes tldr tmux tmuxinator torrent vscode yum)
source $ZSH/oh-my-zsh.sh
source /usr/share/doc/git-extras/git-extras-completion.zsh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias cd=z
alias what='navi --query'
alias nano='nano --modernbindings'
alias sudo=doas
alias sudoedit='doas rnano'
alias codew='codium --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland'
alias code=codium
alias vim=nvim
alias vi=nvim
alias neo='tmatrix -s 15 --fade -c default -C cyan -f 1,1 -G 0,70 -g 20,60 -l 2,60 -r 5,10'
alias matrix='tmatrix -s 15 --fade -c default -f 1,1 -G 0,70 -g 20,60 -l 2,60 -r 5,10'
alias ':q'=exit
alias ls='eza -a -l --icons=always --colour=always --hyperlink -F always --color-scale-mode=gradient --git --git-repos -o'
alias lt='eza -a -l --icons=always --colour=always --hyperlink -F always --color-scale-mode=gradient -T -L 2 --git --git-repos -o --no-user'
alias pkgsearch="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias pkgbrowse="pacman -Slq | fzf --preview 'pacman -Si {}' --layout=reverse"
alias pkgtop="pkgtop -pacman yay"
alias lolcat="lolcat -t"
alias git-send='_git-send() { git add . && git commit -m "$1" && git push }; _git-send'

# Invoke auto update
sudo pacman -Syu && yay -a && sudo pacman -Qdtq | ifne sudo pacman -Rns - && sudo pacman -Scc --noconfirm && yay -a -Scc --noconfirm

clear

# Invoke Fastfetch
fastfetch

export EDITOR=/usr/bin/nvim

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

eval "$(oh-my-posh init zsh --config "https://raw.githubusercontent.com/sametaor/sametaor_CLIconfig/master/misc/sametaor.omp.json")"

eval "$(zoxide init zsh)"

export GPG_TTY=$(tty)

export FZF_DEFAULT_OPTS='--color=fg:#c8d3f5,fg+:#c8d3f5,bg:#222436,bg+:#2a2e54 --color=hl:#82aaff,hl+:#86e1fc,info:#c3e88d,marker:#ffc777 --color=prompt:#ff757f,spinner:#c099ff,pointer:#c099ff,header:#828bb8 --color=border:#6c75ba,label:#9da8ee,query:#c8d3f5 --border="rounded" --border-label="FZF" --border-label-pos="0" --preview-window="border-double" --padding="1" --margin="1" --prompt=">_ " --marker=">>" --pointer="=>" --separator="─" --scrollbar="|" --layout="reverse" --info="right" --tmux left,80% --height=80%'
# zsh parameter completion for the dotnet CLI

_dotnet_zsh_complete()
{
  local completions=("$(dotnet complete "$words")")

  # If the completion list is empty, just continue with filename selection
  if [ -z "$completions" ]
  then
    _arguments '*::arguments: _normal'
    return
  fi

  # This is not a variable assignment, don't remove spaces!
  _values = "${(ps:\n:)completions}"
}

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

compdef _dotnet_zsh_complete dotnet

# pnpm
export PNPM_HOME="/home/sametaor/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Created by `pipx` on 2024-12-28 05:44:32
export PATH="$PATH:/home/sametaor/.local/bin"

if [ -e /home/sametaor/.nix-profile/etc/profile.d/nix.sh ]; then . /home/sametaor/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
