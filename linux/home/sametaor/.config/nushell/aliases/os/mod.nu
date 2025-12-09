# CLI Tools Module - lazy loads on first use
export module os_mod {
    export use ./arch.nu *
    export use ./debian.nu *
    export use ./fedora.nu *
    export use ./opensuse.nu *
    export use ./ubuntu.nu *
}
