try {
  source ($nu.default-config-dir)/plugin-opts/alias-tips.nu
} catch {
  # Defaults if no options file
}

# Set defaults for any unset options
$env.NUSHELL_PLUGINS_ALIAS_TIPS_TEXT = $env.NUSHELL_PLUGINS_ALIAS_TIPS_TEXT? | default "Alias tip: "

let tip_text = $env.NUSHELL_PLUGINS_ALIAS_TIPS_TEXT

let alias_tips = {
    if not (commandline | str starts-with "def ") {
        let existing_alias = help aliases | where {|ali| (commandline) | str starts-with -i ($ali.expansion)}
        if (($existing_alias | length) > 0) {
            let alias_to_use = $existing_alias | first
            print $"(ansi magenta)($tip_text) ($alias_to_use.name | to text) = ($alias_to_use.expansion | to text)(ansi reset)"
        }
    }
}
if ($env.config.hooks.pre_execution == null) {
    $env.config.hooks.pre_execution = [$alias_tips]
} else {
    $env.config.hooks.pre_execution = ($env.config.hooks.pre_execution | prepend $alias_tips)
}

# Due credits to https://github.com/fancy-whale/NuAliasTips/blob/main/nualiastips.nu
