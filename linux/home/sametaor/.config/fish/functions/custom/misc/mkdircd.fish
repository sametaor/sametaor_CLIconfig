function mkdircd --description "Create directory and cd into it"
    argparse p/parents v/verbose -- $argv
    or return 1

    if test (count $argv) -eq 0
        echo "Usage: mkdircd [-p] [-v] DIRECTORY" >&2
        echo "  -p, --parents   Create parent directories as needed" >&2
        echo "  -v, --verbose   Print created directories" >&2
        return 1
    end

    set -l mkdir_flags
    test -n "$_flag_parents"; and set -a mkdir_flags -p
    test -n "$_flag_verbose"; and set -a mkdir_flags -v

    mkdir $mkdir_flags $argv[1]; or return 1
    cd $argv[1]
end
