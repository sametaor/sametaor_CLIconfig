# ------------------------------------------------------------------
# Auto-generate and cache completions the first time a binary is used
# ------------------------------------------------------------------
#  • Runs in the background – no visible delay.
#  • Works for ‘gh’ and ‘chezmoi’; add more in the case-block.
#  • ALWAYS returns 0 so it never blocks history saving.
# ------------------------------------------------------------------

# helper ------------------------------------------------------------
_zsh_gen_completion() {
  local bin=$1
  local dest="$ZSH_CACHE_DIR/completions/_${bin:t}"

  # command must exist
  (( $+commands[$bin] )) || return 1

  # already generated?
  [[ -e $dest ]] && return 0

  case $bin in
    gh)       "$bin" completion -s zsh  >| "$dest" &! ;;
    chezmoi)  "$bin" completion zsh     >| "$dest" &! ;;
    *)        return 1 ;;
  esac

  return 0
}

# history hook ------------------------------------------------------
# 1. Extract first word of the command line.
# 2. Try to build its completion.
# 3. **Always** return 0 so the line is kept in history.
zshaddhistory() {
  local cmd=${1%% *}
  _zsh_gen_completion "$cmd" || true
  return 0          # ← critical: never block history!
}