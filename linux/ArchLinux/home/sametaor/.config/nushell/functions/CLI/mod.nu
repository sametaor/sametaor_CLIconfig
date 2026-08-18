# CLI Functions Module - lazy loads on first use
export module CLI_func_mod {
    export use Python/mod.nu Python_func_mod *
    export use ./command-not-found.bundle.nu *
    export use ./doas.bundle.nu *
    export use ./dotnet.nu *
    export use ./yazi.nu *
    export use ./yt-dlp.bundle.nu *
    export use ./zoxide-eza.bundle.nu *
}

