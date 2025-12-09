export def p [] {
    # 1. Create a lookup table for usernames (no changes here)
    let users = (
        open /etc/passwd
        | lines
        | split column ":" name _ uid _ _ _ _
        | select name uid
        | update uid { |it| $it.uid | into int }
    )

    # 2a. Create a supplementary table ONLY for TTY info.
    let tty_info = (
        ^ps -eo pid,tty
        | lines
        | skip 1
        | str trim
        | str replace --regex '\s+' ' '
        | split column " " pid tty
        | update pid { |it| $it.pid | into int }
    )

    # 2b. Create another supplementary table ONLY for TIME info.
    let time_info = (
        ^ps -eo pid,time
        | lines
        | skip 1
        | str trim
        | str replace --regex '\s+' ' '
        | split column " " pid time
        | update pid { |it| $it.pid | into int }
    )

    # 3. Get the main process list from nushell's internal `ps` command.
    ps -l
    # 4. Insert the human-readable USER column.
    | insert USER { |process|
        ($users | where uid == $process.user_id | get name | first)
    }
    # 5. Perform the first JOIN to add the TTY data.
    | join $tty_info pid
    # 6. Perform the second JOIN to add the TIME data.
    | join $time_info pid
    # 7. Select all the columns we want in the final, correct order and rename them.
    | select USER pid ppid cpu start_time tty time name
    | rename USER PID PPID C STIME TTY TIME CMD
}

export def :q [] {
    # Run logout script if exists
    source ($nu.default-config-dir | path join 'logout.nu')
    exit
}
