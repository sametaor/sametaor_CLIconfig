# ~/.config/fish/functions/plugin-opts/fish-abbreviation-tips.fish

# Customize the tip text format.
# Use {{ .abbr }} for abbreviation and {{ .cmd }} for the corresponding full command.
set -U ABBR_TIPS_PROMPT "\n󰛩 \e[1mAlias Tip: {{ .abbr }}\e[0m means -> {{ .cmd }}"

# Optionally customize alias whitelist or regexes here as well if needed.
#set -U ABBR_TIPS_ALIAS_WHITELIST "alias1 alias2"  # example
set -U ABBR_TIPS_REGEXES '(^(\w+\s+)+(-{1,2})\w+)(\s\S+)' '(^( ?\w+){3}).*' '(^( ?\w+){2}).*' '(^( ?\w+){1}).*'
