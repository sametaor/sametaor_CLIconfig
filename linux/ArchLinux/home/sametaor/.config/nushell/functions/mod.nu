# Functions Module - lazy loads on first use
export module Func_mod {
    export use CLI/mod.nu CLI_func_mod *
    export use misc/mod.nu misc_func_mod *
    export use nu-specific/mod.nu Nu_func_mod *
    export use os/mod.nu OS_func_mod *
} 
