# Taken from https://github.com/oh-my-fish/plugin-pyenv/blob/master/completions/pyenv.fish

function pyenv
  set cmd $argv[1]
  set -e argv[1]

  switch "$cmd"
  case activate deactivate rehash shell virtualenvwrapper virtualenvwrapper_lazy
    command pyenv "sh-$cmd" $argv | source
  case '*'
    command pyenv "$cmd" $argv
  end
end