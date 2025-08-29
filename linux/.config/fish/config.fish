# --- Auto-load installed plugins ---
# --- Auto-load installed plugins (safe globbing) ---
set -l plugins_dir $HOME/.config/fish/functions/plugins
set -l opts_dir $HOME/.config/fish/functions/plugin-opts
if test -d $plugins_dir
    set -l plugin_dirs (find $plugins_dir -mindepth 1 -maxdepth 1 -type d 2>/dev/null)
    for plugin in $plugin_dirs
        set -l plugin_name (basename $plugin)
        set -l opts_file $opts_dir/$plugin_name.fish
        # Source plugin options if present
        if test -f $opts_file
            source $opts_file
        end
        # Source all .fish files in the plugin
        for f in $plugin/*.fish
            if test -f $f
                source $f
            end
        end
    end
end

# --- Fish plugin installer function (inline) ---
function plugin_installer --argument-names plugin_name git_url
    set -l plugin_dir $HOME/.config/fish/functions/plugins/$plugin_name
    set -l opts_file $HOME/.config/fish/functions/plugin-opts/$plugin_name.fish

    # Clone or update the plugin
    if test -d $plugin_dir
        echo "Updating $plugin_name..."
        command git -C $plugin_dir pull
    else
        echo "Installing $plugin_name from $git_url..."
        command git clone $git_url $plugin_dir
    end

    # Source plugin options if present
    if test -f $opts_file
        source $opts_file
    end

    # Source plugin main file(s)
    for f in $plugin_dir/*.fish
        if test -f $f
            source $f
        end
    end

    echo "$plugin_name loaded."
end

# --- Session and login logic (ported from .zprofile/.zlogin) ---

# Source modular loader only once per session to prevent recursion
if not set -q __startup_fish_loaded
    set -g __startup_fish_loaded 1
    if test -f $HOME/.config/fish/conf.d/startup.fish
        source $HOME/.config/fish/conf.d/startup.fish
    end
end

# Ensure reload function is available
if not functions -q reload
    if test -f $HOME/.config/fish/functions/reload.fish
        source $HOME/.config/fish/functions/reload.fish
    end
end

# DBUS session (if needed)
if test -z "$DBUS_SESSION_BUS_ADDRESS"
    set -gx DBUS_SESSION_BUS_ADDRESS (dbus-launch --sh-syntax | string match -r 'DBUS_SESSION_BUS_ADDRESS=([^;]+);' | string replace 'DBUS_SESSION_BUS_ADDRESS=' '')
end

# Interactive session logic
if status is-interactive
    # Place interactive-only logic here
end
