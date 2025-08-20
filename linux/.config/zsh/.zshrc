## 3  Shell behaviour ----------------------------------------------------
setopt AUTO_CD             # `cd` by omission
setopt AUTO_PUSHD PUSHD_IGNORE_DUPS
setopt INTERACTIVE_COMMENTS
setopt PROMPT_SUBST    # allow prompt expansion
bindkey -v; export KEYTIMEOUT=1                 # vi-mode

# Edit the command line using default editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# Advanced glob patterns
setopt EXTENDED_GLOB NO_ERR_RETURN

## 3-A  Autoload helpers --------------------------------------------------
autoload -Uz zmv zargs

## 3-B  Completion & prompt cache -----------------------------------------

# User-supplied completions
export ZSH_COMP_DIR="$ZDOTDIR/completions"

# Use dedicated cache dir to avoid clutter
export ZSH_CACHE_DIR="$ZDOTDIR/cache"
mkdir -p "$ZSH_CACHE_DIR"

# Speed: load only after the first TAB in a session
zmodload -F zsh/complist

# Load completion options first
for file in "$ZSH_COMP_DIR"/**/*.zsh(N); do
  source "$file"
done

# Initialize completion system (compinit) with cache dump
autoload -Uz compinit
compinit -d "$ZSH_CACHE_DIR/zcompdump" -C

## 3-C  Functions -------------------------------------------------------------
# Tell zsh where to look when autoloading
fpath=("$ZDOTDIR/functions" $fpath)

# Rule of thumb
#   • *.zsh           → autoload the file-name (lazy, 1 func / file)
#   • *.bundle.zsh    → source it right away (many funcs per file)
for fnfile in "$ZDOTDIR/functions"/**/*(N-.); do    # (N-.) = regular files, no errors
  case ${fnfile:t} in
    *.bundle.zsh)          # a “bundle” holds several helpers
      source "$fnfile"
      ;;
    *.zsh)                 # classic 1-file-1-function style
      autoload -Uz "${${fnfile#$ZDOTDIR/functions/}%.*}"
      ;;
  esac
done


## 3-D  Source modular alias sets -----------------------------------------
for file in "$ZDOTDIR/aliases"/**/*.zsh(N); do source "$file"; done

## 3-E  Lightweight plugin framework --------------------------------------
export ZSH_PLUGINS_DIR="$ZDOTDIR/plugins"

# Helper: add a plugin once – no external manager needed
zpl_add() {
  local param=$1 host url name

  if [[ "$param" == */* ]]; then
    # Check for host prefix in form: host:author/repo
    if [[ "$param" =~ ^([^:]+):(.+/.+)$ ]]; then
      host=${match[1]}
      param=${match}
      case $host in
        github)    url="https://github.com/${param}.git" ;;
        gitlab)    url="https://gitlab.com/${param}.git" ;;
        bitbucket) url="https://bitbucket.org/${param}.git" ;;
        gitea)     url="https://gitea.com/${param}.git" ;;
        # Common self-hosted or alternative domains
        sourcehut) url="https://git.sr.ht/${param}" ;;         # SourceHut (no .git suffix)
        pagure)    url="https://pagure.io/${param}.git" ;;    # Pagure
        codeberg)  url="https://codeberg.org/${param}.git" ;; # Codeberg (Gitea-based)
        # Custom host/domain fallback (assume HTTPS + .com + .git)
        *)         url="https://${host}.com/${param}.git" ;;
      esac
    else
      # Default: github
      url="https://github.com/${param}.git"
    fi
    name=${param##*/}
  else
    # Param is a full URL
    url="$param"
    name=${${param##*/}%.git}
  fi

  git -C "$ZSH_PLUGINS_DIR" clone --depth=1 "$url" "$name" 2>/dev/null || :
}

# Helper: update every git plugin silently on shell start
zpl_update_all() {
  local repo
  for repo in "$ZSH_PLUGINS_DIR"/*/.git(N); do
    export GIT_TERMINAL_PROMPT=0
    git -C "${repo:h}" pull --ff-only --quiet >/dev/null 2>&1 &!
  done
}
zpl_update_all                                    # keep plugins fresh

plugins=(
  fzf-tab                       # completion UI   – needs to be early
  fast-syntax-highlighting       # colours
  zsh-history-substring-search  # Up/Down filtered history
  zsh-autosuggestions           # grey inline ghost text
  # my-own-plugin               # add more whenever you like
)

_zsh_load_plugins() {
  emulate -L zsh

  # Build the ordered list
  typeset -a _plugin_list _seen
  for name in "${plugins[@]}"; do
    [[ -d $ZSH_PLUGINS_DIR/$name ]] && {
      _plugin_list+=$ZSH_PLUGINS_DIR/$name
      _seen+=$name
    }
  done

  # Append any remaining clones not mentioned in the array
  for p in $ZSH_PLUGINS_DIR/*(/N); do
    [[ ${_seen[(r)$p:t]} ]] || _plugin_list+=$p
  done

  # Source every file that looks like a plugin
  for p in "${_plugin_list[@]}"; do
    fpath=($p $fpath)                       # expose any _completions
    for f in $p/*(N-.) ; do
      [[ $f == *.(zsh|plugin.zsh|zsh-theme) ]] && source $f
    done
  done
  unset _plugin_list _seen p f              # tidy namespace
}
_zsh_load_plugins

for f in "$ZDOTDIR/plugin-opts"/*.zsh(N); do
  source "$f"
done

## 3-F  Prompt (minimal; tweak to taste) -----------------------------------
# Load the module only once
autoload -Uz vcs_info

# Style: show “‹branch›” for git or mercurial; nothing for plain dirs
zstyle ':vcs_info:git:*' formats ' ‹%b›'
zstyle ':vcs_info:hg:*'  formats ' ‹%b›'

# Run right before each prompt draw
precmd() {
  vcs_info                         # fills $vcs_info_msg_0_
}

# Finally, build the prompt
PROMPT='%F{cyan}%n@%m%f %F{yellow}%~%f${vcs_info_msg_0_}
$ '

## 3-G  Misc convenience ---------------------------------------------------
alias reload='source "$ZDOTDIR/.zshrc"'
# Load fastfetch if available
if command -v fastfetch &>/dev/null; then
  fastfetch
fi

## 3-H  Keybinds -----------------------------------------------------------
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# History search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Force history substring search binds AFTER all plugins and binds
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -- "${key[Up]}" history-substring-search-up
bindkey -- "${key[Down]}" history-substring-search-down

# Vim motions

## History search
bindkey -M vicmd '/' history-incremental-search-forward
bindkey -M vicmd '?' history-incremental-search-backward

## Incremental pattern search in insert mode
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^F' history-incremental-pattern-search-forward

## Prefix search
bindkey '^[OA' up-line-or-beginning-search # Up
bindkey '^[OB' down-line-or-beginning-search # Down
bindkey -M vicmd 'k' up-line-or-beginning-search
bindkey -M vicmd 'j' down-line-or-beginning-search

# Cursor shape
function zle-keymap-select {
case $KEYMAP in
vicmd) print -n -- $'\e[1 q' ;; # block cursor
viins|main) print -n -- $'\e[5 q' ;; # beam cursor
esac
}
zle -N zle-keymap-select
function zle-line-init { zle-keymap-select }
zle -N zle-line-init
preexec() { print -n -- $'\e[0 q' } # reset on external cmd