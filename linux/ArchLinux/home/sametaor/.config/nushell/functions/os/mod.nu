# OS Functions Module - lazy loads on first use
export module OS_func_mod {
    export use ./Arch/arch.bundle.nu *
    export use ./Debian/debian.bundle.nu *
    export use ./Ubuntu/ubuntu.bundle.nu *
}
