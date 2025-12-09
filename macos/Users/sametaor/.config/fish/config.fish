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

function fish_mode_prompt
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

function rerender_on_bind_mode_change --on-variable fish_bind_mode
    set mode_value ""
    switch $fish_bind_mode
        case default
            set mode_value " N"
        case insert
            set mode_value "󱩽 I"
        case visual
            set mode_value " V"
        case visual_line
            set mode_value "󰡮 VL"
        case visual_block
            set mode_value "󱂔 VB"
        case replace_one
            set mode_value " R"
        case '*'
            set mode_value $fish_bind_mode
    end
    if test "$fish_bind_mode" != paste -a "$mode_value" != "$VI_MODE"
        set -gx VI_MODE $mode_value
        omp_repaint_prompt
    end
end

function fish_default_mode_prompt --description "Display vi prompt mode"
    # This function is masked and does nothing
end

# .ZLOGOUT emulation
function on_exit --on-event fish_exit
    # Remove any temp files, notify user, etc.
    rm -f "$XDG_CACHE_HOME"/fish/last-session-$fish_pid 2>/dev/null
    echo "Cya $USER!"
end

