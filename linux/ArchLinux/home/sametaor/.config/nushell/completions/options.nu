# === ZSH options.zsh → Nushell equivalent ===
# nicer menu, group headers in blue ✓
# case-insensitive, hyphen/underscore ✓
# extra matchers, special-dirs, gain-privileges, rehash ✓

# 1. MENU: select + group headers (blue)
$env.config.listings = {
    table: {
        mode: "compact"  # compact menu like zsh 'menu select'
        header: true
        # Blue group headers via ANSI
        color: {
            header: "blue_bold"
        }
    }
}

# 2. MATCHER: case-insensitive + hyphen/underscore
$env.config.completions = {
    case_insensitive: true           # m:{a-zA-Z}={A-Za-z}
    quick: true                      # fast fuzzy matching
    # Hyphen/underscore interchange via custom matcher
    algorithm: "fuzzy"               # closest to zsh matcher-list
    external: {
        enable: true
        max_results: 100
        # Carapace handles hyphen/underscore naturally
    }
}

# 3. SPECIAL-DIRS: true (use ~, ., ..)
$env.config.use_ls_colors = true

# 4. GAIN-PRIVILEGES: sudo completion
$env.config.completions.extra_bin_dirs = [
    "/usr/local/sbin"
    "/usr/sbin"
    "/sbin"
]

# 5. REHASH: true (auto-detect new exes)
$env.config.completions.analyze_command_vi_mode: false  # zsh-style

# Group name formatting (descriptions format)
$env.config.listings.table.mode = "compact"
$env.config.listings.table.color.header = "blue_bold"
