let macports_bin = "/opt/local/bin"
let macports_sbin = "/opt/local/sbin"

# Prepend sbin first, then bin, ensuring bin ends up at index 0.
if ($macports_sbin | path exists) {
    $env.PATH = ($env.PATH | prepend $macports_sbin)
}
if ($macports_bin | path exists) {
    $env.PATH = ($env.PATH | prepend $macports_bin)
}
# Pyenv initialization for Nushell
if ($env.PYENV_ROOT | path exists) {
    # Ensure PYENV_ROOT is set if not already
    # Add pyenv shims to PATH
    $env.PATH = ($env.PYENV_ROOT | path join 'shims' | append $env.PATH)
    # Add pyenv bin to PATH
    $env.PATH = ($env.PYENV_ROOT | path join 'bin' | append $env.PATH)
}

oh-my-posh init nu --config "https://raw.githubusercontent.com/sametaor/sametaor_CLIconfig/master/misc/sametaor.omp.json"

source ($nu.default-config-dir | path join 'zoxide.nu')
