export alias glfsi = git lfs install
export alias glfst = git lfs track
export alias glfsls = git lfs ls-files
# The last alias expects arguments, so it should be a function in Nushell:
export def glfsmi [...args] {
  git lfs migrate import --include=$args
}
