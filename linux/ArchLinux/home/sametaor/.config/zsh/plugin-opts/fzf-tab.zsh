zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -a -l --icons=always --colour=always --hyperlink -F always --color-scale-mode=gradient --git --git-repos -o'

zstyle ':fzf-tab:*' use-fzf-default-opts yes

zstyle ':fzf-tab:*' switch-group '<' '>'

zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup