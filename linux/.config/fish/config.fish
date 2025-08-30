# --- Fish Shell Bootstrap ---
#
# Fish automatically sources all files in conf.d/ and its subdirectories (except hidden files),
# so all configuration, plugin, and helper scripts placed there are loaded at shell startup.
#
# Functions in the functions/ directory are autoloaded ("lazy loaded") by fish when called.
#
# Do NOT source completions/ here, as this can cause issues.
#
# If you have a plugin loader (like fpl.fish), source it here:
#if test -f $HOME/.config/fish/fpl.fish
#    source $HOME/.config/fish/fpl.fish
#end

function fish_mode_prompt; end

# Eagerly load all plugin functions
for f in ~/.config/fish/functions/plugin-functions/*.fish
    source $f
end

# Eagerly load all plugin options
for f in ~/.config/fish/functions/plugin-opts/*.fish
    source $f
end

set confd_dir ~/.config/fish/conf.d

for f in (find $confd_dir -mindepth 3 -type f -name '*.fish' | sort)
    source $f
end

set fish_greeting

oh-my-posh init fish --config 'https://raw.githubusercontent.com/sametaor/sametaor_CLIconfig/master/misc/sametaor.omp.json' | source

# Helper to always refresh the prompt after mode switch
function __omp_repaint_on_mode_change --on-event fish_bind_mode
    commandline -f repaint
end