export alias sgem = sudo gem
# Need a function for piping in Nushell:
export def rfind [pattern: string=""] {
  ^find . -name "*.rb" | xargs grep -n $pattern
}
export alias rb = ruby
export alias gein = gem install
export alias geun = gem uninstall
export alias geli = gem list
export alias gei = gem info
export alias geiall = gem info --all
export alias geca = gem cert --add
export alias gecr = gem cert --remove
export alias gecb = gem cert --build
export alias geclup = gem cleanup -n
export alias gegi = gem generate_index
export alias geh = gem help
export alias gel = gem lock
export alias geo = gem open
export alias geoe = gem open -e
export alias rrun = ruby -e
