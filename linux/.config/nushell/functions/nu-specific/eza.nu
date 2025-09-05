def nl [] {
    # Capture eza output for decorated names (no color for easier parsing)
    let eza_lines = (eza --color=always --hyperlink | lines | collect)
    let eza_names = ($eza_lines | each {|line| { decorated_name: $line } })

    # Capture ls data
    let ls_data = (ls -l | collect)

    # Current directory path for joining paths
    let cwd = (pwd)

    let current_user = (whoami | str trim)

    $ls_data | enumerate | each { |row|
        let decorated_name = ($eza_names | skip $row.index | first | get decorated_name)
        let item_name = $row.item.name
        let is_dir = ($row.item.type == "dir")

        let full_path = if $is_dir { (echo $cwd | path join $item_name) } else { "" }

        # Determine if executable by checking if 'x' is in mode string
        let is_executable = ($row.item.mode | str contains "x")

        # Append * for executables that are not directories
        let name_with_flag = if $is_executable and (not $is_dir) { $decorated_name + "*" } else { $decorated_name }

        $row.item
        | update name {|| $name_with_flag }
    }
    | each { |row|

        let color_code = if ($row.user != $current_user) { "38;2;169;169;169m" } else { "38;2;248;240;164m" }

        let colored_user = (ansi --escape $color_code) + $row.user + (ansi --escape "0m")

        $row | update user {|| $colored_user }

    }
    | each { |row|

        let exact_modified = $row.modified | format date "%d %b %H:%M"

        $row | update modified {|| $exact_modified }

    }
    | each { |row|
        let modified_str = $row.modified | into string
        let colored_date = (ansi --escape "38;2;0;55;216m") + $modified_str + (ansi --escape "0m")
        $row | update modified {|| $colored_date }
    }
    | each { |row|
        let size_str = $row.size | into string
        let colored_size = (ansi --escape "38;2;22;197;12m") + $size_str + (ansi --escape "0m")
        $row | update size {|| $colored_size }
    }
    | each { |row|
        let prefix = if $row.type == "dir" { "d" } else { "." }
        let mode_str = $prefix + $row.mode
        let chars = $mode_str | split chars

        # All 'r' indices
        let r_indices = ($chars | enumerate | where {|e| $e.item == "r"} | get index)

        # Indices of 'r's to color as second color (all except first)
        let mult_r_indices = if ($r_indices | length) > 1 { $r_indices | skip 1 } else { [] }

        let colored_chars = $chars | enumerate | each {|e|
            let c = $e.item
            let i = $e.index

            if $c == "d" {
                (ansi --escape "38;2;41;84;177m") + $c + (ansi --escape "0m")
            } else if $c == "r" {
                if ($mult_r_indices | any {|x| $x == $i}) {
                    (ansi --escape "38;2;132;106;0m") + $c + (ansi --escape "0m")
                } else {
                    (ansi --escape "38;2;248;240;164m") + $c + (ansi --escape "0m")
                }
            } else if $c == "w" {
                (ansi --escape "38;2;187;58;70m") + $c + (ansi --escape "0m")
            } else if $c == "x" {
                (ansi --escape "38;2;18;161;10m") + $c + (ansi --escape "0m")
            } else {
                $c
            }
        }

        let colored_mode = $colored_chars | str join ""

        $row | update mode {|| $colored_mode }
    }
    | each { |row|
        let colored_size = if $row.type == "dir" {
            "-"  # or "" for blank
        } else {
            let size_str = $row.size | into string
            (ansi --escape "38;2;22;197;12m") + $size_str + (ansi --escape "0m")
        }
        $row | update size {|| $colored_size }
    }
    | each { |row| 
        {
        "Permissions": $row.mode,
        "Size": $row.size,
        "User": $row.user,
        "Date Modified": $row.modified,
        "Name": $row.name
        }
    }
}

def nla [] {
    # Capture eza output for decorated names (no color for easier parsing)
    let eza_lines = (eza -a --color=always --hyperlink | lines | collect)
    let eza_names = ($eza_lines | each {|line| { decorated_name: $line } })

    # Capture ls data
    let ls_data = (ls -al | collect)

    # Current directory path for joining paths
    let cwd = (pwd)

    let current_user = (whoami | str trim)

    $ls_data | enumerate | each { |row|
        let decorated_name = ($eza_names | skip $row.index | first | get decorated_name)
        let item_name = $row.item.name
        let is_dir = ($row.item.type == "dir")

        let full_path = if $is_dir { (echo $cwd | path join $item_name) } else { "" }

        # Determine if executable by checking if 'x' is in mode string
        let is_executable = ($row.item.mode | str contains "x")

        # Append * for executables that are not directories
        let name_with_flag = if $is_executable and (not $is_dir) { $decorated_name + "*" } else { $decorated_name }

        $row.item
        | update name {|| $name_with_flag }
    }
    | each { |row|

        let color_code = if ($row.user != $current_user) { "38;2;169;169;169m" } else { "38;2;248;240;164m" }

        let colored_user = (ansi --escape $color_code) + $row.user + (ansi --escape "0m")

        $row | update user {|| $colored_user }

    }
    | each { |row|

        let exact_modified = $row.modified | format date "%d %b %H:%M"

        $row | update modified {|| $exact_modified }

    }
    | each { |row|
        let modified_str = $row.modified | into string
        let colored_date = (ansi --escape "38;2;0;55;216m") + $modified_str + (ansi --escape "0m")
        $row | update modified {|| $colored_date }
    }
    | each { |row|
        let size_str = $row.size | into string
        let colored_size = (ansi --escape "38;2;22;197;12m") + $size_str + (ansi --escape "0m")
        $row | update size {|| $colored_size }
    }
    | each { |row|
        let prefix = if $row.type == "dir" { "d" } else { "." }
        let mode_str = $prefix + $row.mode
        let chars = $mode_str | split chars

        # All 'r' indices
        let r_indices = ($chars | enumerate | where {|e| $e.item == "r"} | get index)

        # Indices of 'r's to color as second color (all except first)
        let mult_r_indices = if ($r_indices | length) > 1 { $r_indices | skip 1 } else { [] }

        let colored_chars = $chars | enumerate | each {|e|
            let c = $e.item
            let i = $e.index

            if $c == "d" {
                (ansi --escape "38;2;41;84;177m") + $c + (ansi --escape "0m")
            } else if $c == "r" {
                if ($mult_r_indices | any {|x| $x == $i}) {
                    (ansi --escape "38;2;132;106;0m") + $c + (ansi --escape "0m")
                } else {
                    (ansi --escape "38;2;248;240;164m") + $c + (ansi --escape "0m")
                }
            } else if $c == "w" {
                (ansi --escape "38;2;187;58;70m") + $c + (ansi --escape "0m")
            } else if $c == "x" {
                (ansi --escape "38;2;18;161;10m") + $c + (ansi --escape "0m")
            } else {
                $c
            }
        }

        let colored_mode = $colored_chars | str join ""

        $row | update mode {|| $colored_mode }
    }
    | each { |row|
        let colored_size = if $row.type == "dir" {
            "-"  # or "" for blank
        } else {
            let size_str = $row.size | into string
            (ansi --escape "38;2;22;197;12m") + $size_str + (ansi --escape "0m")
        }
        $row | update size {|| $colored_size }
    }
    | each { |row| 
        {
        "Permissions": $row.mode,
        "Size": $row.size,
        "User": $row.user,
        "Date Modified": $row.modified,
        "Name": $row.name
        }
    }
}

def nlr [] {
  let cwd = (pwd)

  # Get root items with type (dir or file)
  let root_items = (ls -a --all | where { |row| ($row.name != '.' and $row.name != '..') } | collect)

  let root_files = ($root_items | where { |row| $row.type != "dir" })
  let root_dirs = ($root_items | where { |row| $row.type == "dir" })


  # Output files at root
  echo "Files in current directory:"
  $root_files
  | each { |row| { Name: $row.name } }
  | table

  # Iterate over directories and show their contents recursively
  $root_dirs | each { |dir_row| 
    echo ("Directory: " + $dir_row.name)
    let dir_path = (echo $cwd | path join $dir_row.name)

    # Recursive eza listing inside the directory
    let dir_contents = (eza -hF --color=always --icons=always --hyperlink $dir_path | lines | collect)

    $dir_contents
    | each { |line| { ($dir_row.name): $line } }
    | table
  }
}

def nlt [] {
    # Capture eza output for decorated names (no color for easier parsing)
    let eza_lines = (eza --icons=always --color=always --hyperlink | lines | collect)
    let eza_names = ($eza_lines | each {|line| { decorated_name: $line } })

    # Capture ls data
    let ls_data = (ls -l | collect)

    # Current directory path for joining paths
    let cwd = (pwd)

    let current_user = (whoami | str trim)

    $ls_data | enumerate | each { |row|
        let decorated_name = ($eza_names | skip $row.index | first | get decorated_name)
        let item_name = $row.item.name
        let is_dir = ($row.item.type == "dir")

        let full_path = if $is_dir { (echo $cwd | path join $item_name) } else { "" }

        # Determine if executable by checking if 'x' is in mode string
        let is_executable = ($row.item.mode | str contains "x")

        # Append * for executables that are not directories
        let name_with_flag = if $is_executable and (not $is_dir) { $decorated_name + "*" } else { $decorated_name }

        $row.item
        | update name {|| $name_with_flag }
    }
    | each { |row|

        let color_code = if ($row.user != $current_user) { "38;2;169;169;169m" } else { "38;2;248;240;164m" }

        let colored_user = (ansi --escape $color_code) + $row.user + (ansi --escape "0m")

        $row | update user {|| $colored_user }

    }
    | each { |row|

        let exact_created = $row.created | format date "%d %b %H:%M"

        $row | update created {|| $exact_created }

    }
    | each { |row|
        let created_str = $row.created | into string
        let colored_date = (ansi --escape "38;2;0;55;216m") + $created_str + (ansi --escape "0m")
        $row | update created {|| $colored_date }
    }
    | each { |row|
        let size_str = $row.size | into string
        let colored_size = (ansi --escape "38;2;22;197;12m") + $size_str + (ansi --escape "0m")
        $row | update size {|| $colored_size }
    }
    | each { |row|
        let prefix = if $row.type == "dir" { "d" } else { "." }
        let mode_str = $prefix + $row.mode
        let chars = $mode_str | split chars

        # All 'r' indices
        let r_indices = ($chars | enumerate | where {|e| $e.item == "r"} | get index)

        # Indices of 'r's to color as second color (all except first)
        let mult_r_indices = if ($r_indices | length) > 1 { $r_indices | skip 1 } else { [] }

        let colored_chars = $chars | enumerate | each {|e|
            let c = $e.item
            let i = $e.index

            if $c == "d" {
                (ansi --escape "38;2;41;84;177m") + $c + (ansi --escape "0m")
            } else if $c == "r" {
                if ($mult_r_indices | any {|x| $x == $i}) {
                    (ansi --escape "38;2;132;106;0m") + $c + (ansi --escape "0m")
                } else {
                    (ansi --escape "38;2;248;240;164m") + $c + (ansi --escape "0m")
                }
            } else if $c == "w" {
                (ansi --escape "38;2;187;58;70m") + $c + (ansi --escape "0m")
            } else if $c == "x" {
                (ansi --escape "38;2;18;161;10m") + $c + (ansi --escape "0m")
            } else {
                $c
            }
        }

        let colored_mode = $colored_chars | str join ""

        $row | update mode {|| $colored_mode }
    }
    | each { |row|
        let colored_size = if $row.type == "dir" {
            "-"  # or "" for blank
        } else {
            let size_str = $row.size | into string
            (ansi --escape "38;2;22;197;12m") + $size_str + (ansi --escape "0m")
        }
        $row | update size {|| $colored_size }
    }
    | each { |row| 
        {
        "Permissions": $row.mode,
        "Size": $row.size,
        "User": $row.user,
        "Date Created": $row.created,
        "Name": $row.name
        }
    }
}

def nll [] {
    # Capture eza output for decorated names (no color for easier parsing)
    let eza_lines = (eza --color=always --hyperlink | lines | collect)
    let eza_names = ($eza_lines | each {|line| { decorated_name: $line } })

    # Capture ls data
    let ls_data = (ls -l | collect)

    # Current directory path for joining paths
    let cwd = (pwd)

    let current_user = (whoami | str trim)

    $ls_data | enumerate | each { |row|
        let decorated_name = ($eza_names | skip $row.index | first | get decorated_name)
        let item_name = $row.item.name
        let is_dir = ($row.item.type == "dir")

        let full_path = if $is_dir { (echo $cwd | path join $item_name) } else { "" }

        # Determine if executable by checking if 'x' is in mode string
        let is_executable = ($row.item.mode | str contains "x")

        # Append * for executables that are not directories
        let name_with_flag = if $is_executable and (not $is_dir) { $decorated_name + "*" } else { $decorated_name }

        $row.item
        | update name {|| $name_with_flag }
    }
    | each { |row|

        let color_code = if ($row.user != $current_user) { "38;2;169;169;169m" } else { "38;2;248;240;164m" }

        let colored_user = (ansi --escape $color_code) + $row.user + (ansi --escape "0m")

        $row | update user {|| $colored_user }

    }
    | each { |row|

        let exact_modified = $row.modified | format date "%d %b %H:%M"

        $row | update modified {|| $exact_modified }

    }
    | each { |row|
        let modified_str = $row.modified | into string
        let colored_date = (ansi --escape "38;2;0;55;216m") + $modified_str + (ansi --escape "0m")
        $row | update modified {|| $colored_date }
    }
    | each { |row|
        let size_str = $row.size | into string
        let colored_size = (ansi --escape "38;2;22;197;12m") + $size_str + (ansi --escape "0m")
        $row | update size {|| $colored_size }
    }
    | each { |row|
        let prefix = if $row.type == "dir" { "d" } else { "." }
        let mode_str = $prefix + $row.mode
        let chars = $mode_str | split chars

        # All 'r' indices
        let r_indices = ($chars | enumerate | where {|e| $e.item == "r"} | get index)

        # Indices of 'r's to color as second color (all except first)
        let mult_r_indices = if ($r_indices | length) > 1 { $r_indices | skip 1 } else { [] }

        let colored_chars = $chars | enumerate | each {|e|
            let c = $e.item
            let i = $e.index

            if $c == "d" {
                (ansi --escape "38;2;41;84;177m") + $c + (ansi --escape "0m")
            } else if $c == "r" {
                if ($mult_r_indices | any {|x| $x == $i}) {
                    (ansi --escape "38;2;132;106;0m") + $c + (ansi --escape "0m")
                } else {
                    (ansi --escape "38;2;248;240;164m") + $c + (ansi --escape "0m")
                }
            } else if $c == "w" {
                (ansi --escape "38;2;187;58;70m") + $c + (ansi --escape "0m")
            } else if $c == "x" {
                (ansi --escape "38;2;18;161;10m") + $c + (ansi --escape "0m")
            } else {
                $c
            }
        }

        let colored_mode = $colored_chars | str join ""

        $row | update mode {|| $colored_mode }
    }
    | each { |row|
        let colored_size = if $row.type == "dir" {
            "-"  # or "" for blank
        } else {
            let size_str = $row.size | into string
            (ansi --escape "38;2;22;197;12m") + $size_str + (ansi --escape "0m")
        }
        $row | update size {|| $colored_size }
    }
    | each { |row| 
        {
        "Permissions": $row.mode,
        "Size": $row.size,
        "User": $row.user,
        "Date Modified": $row.modified,
        "Name": $row.name
        }
    }
}

def nldot [] {
    # Capture eza output for decorated names (no color for easier parsing)
    let eza_lines = (eza -d .* --color=always --hyperlink | lines | lines | collect)
    let eza_names = ($eza_lines | each {|line| { decorated_name: $line } })

    # Capture ls data
    let ls_data = (ls -al .* | where { |row| ($row.name | str starts-with ".") and $row.name != "." } | collect)

    # Current directory path for joining paths
    let cwd = (pwd)

    let current_user = (whoami | str trim)

    $ls_data | enumerate | each { |row|
        let decorated_name = ($eza_names | skip $row.index | first | get decorated_name)
        let item_name = $row.item.name
        let is_dir = ($row.item.type == "dir")

        let full_path = if $is_dir { (echo $cwd | path join $item_name) } else { "" }

        # Determine if executable by checking if 'x' is in mode string
        let is_executable = ($row.item.mode | str contains "x")

        # Append * for executables that are not directories
        let name_with_flag = if $is_executable and (not $is_dir) { $decorated_name + "*" } else { $decorated_name }

        $row.item
        | update name {|| $name_with_flag }
    }
    | each { |row|

        let color_code = if ($row.user != $current_user) { "38;2;169;169;169m" } else { "38;2;248;240;164m" }

        let colored_user = (ansi --escape $color_code) + $row.user + (ansi --escape "0m")

        $row | update user {|| $colored_user }

    }
    | each { |row|

        let exact_modified = $row.modified | format date "%d %b %H:%M"

        $row | update modified {|| $exact_modified }

    }
    | each { |row|
        let modified_str = $row.modified | into string
        let colored_date = (ansi --escape "38;2;0;55;216m") + $modified_str + (ansi --escape "0m")
        $row | update modified {|| $colored_date }
    }
    | each { |row|
        let size_str = $row.size | into string
        let colored_size = (ansi --escape "38;2;22;197;12m") + $size_str + (ansi --escape "0m")
        $row | update size {|| $colored_size }
    }
    | each { |row|
        let prefix = if $row.type == "dir" { "d" } else { "." }
        let mode_str = $prefix + $row.mode
        let chars = $mode_str | split chars

        # All 'r' indices
        let r_indices = ($chars | enumerate | where {|e| $e.item == "r"} | get index)

        # Indices of 'r's to color as second color (all except first)
        let mult_r_indices = if ($r_indices | length) > 1 { $r_indices | skip 1 } else { [] }

        let colored_chars = $chars | enumerate | each {|e|
            let c = $e.item
            let i = $e.index

            if $c == "d" {
                (ansi --escape "38;2;41;84;177m") + $c + (ansi --escape "0m")
            } else if $c == "r" {
                if ($mult_r_indices | any {|x| $x == $i}) {
                    (ansi --escape "38;2;132;106;0m") + $c + (ansi --escape "0m")
                } else {
                    (ansi --escape "38;2;248;240;164m") + $c + (ansi --escape "0m")
                }
            } else if $c == "w" {
                (ansi --escape "38;2;187;58;70m") + $c + (ansi --escape "0m")
            } else if $c == "x" {
                (ansi --escape "38;2;18;161;10m") + $c + (ansi --escape "0m")
            } else {
                $c
            }
        }

        let colored_mode = $colored_chars | str join ""

        $row | update mode {|| $colored_mode }
    }
    | each { |row|
        let colored_size = if $row.type == "dir" {
            "-"  # or "" for blank
        } else {
            let size_str = $row.size | into string
            (ansi --escape "38;2;22;197;12m") + $size_str + (ansi --escape "0m")
        }
        $row | update size {|| $colored_size }
    }
    | each { |row| 
        {
        "Permissions": $row.mode,
        "Size": $row.size,
        "User": $row.user,
        "Date Modified": $row.modified,
        "Name": $row.name
        }
    }
}

def nlS [] {
    # Capture eza output for decorated names (no color for easier parsing)
    let eza_lines = (eza --color=always --hyperlink | lines | collect)
    let eza_names = ($eza_lines | each {|line| { decorated_name: $line } })

    # Capture ls data
    let ls_data = (ls -l | collect)

    # Current directory path for joining paths
    let cwd = (pwd)

    let current_user = (whoami | str trim)

    $ls_data | enumerate | each { |row|
        let decorated_name = ($eza_names | skip $row.index | first | get decorated_name)
        let item_name = $row.item.name
        let is_dir = ($row.item.type == "dir")

        let full_path = if $is_dir { (echo $cwd | path join $item_name) } else { "" }

        # Determine if executable by checking if 'x' is in mode string
        let is_executable = ($row.item.mode | str contains "x")

        # Append * for executables that are not directories
        let name_with_flag = if $is_executable and (not $is_dir) { $decorated_name + "*" } else { $decorated_name }

        $row.item
        | update name {|| $name_with_flag }
    }
    | each { |row| 
        {
        "Name": $row.name
        }
    }
}

def nlart [] {
    # Capture eza output for decorated names (no color for easier parsing)
    let eza_lines = (eza -d .* --color=always --hyperlink | lines | lines | collect)
    let eza_names = ($eza_lines | each {|line| { decorated_name: $line } })

    # Capture ls data
    let ls_data = (ls -al .* | where { |row| ($row.name | str starts-with ".") and $row.name != "." } | collect)

    # Current directory path for joining paths
    let cwd = (pwd)

    let current_user = (whoami | str trim)

    $ls_data | enumerate | each { |row|
        let decorated_name = ($eza_names | skip $row.index | first | get decorated_name)
        let item_name = $row.item.name
        let is_dir = ($row.item.type == "dir")

        let full_path = if $is_dir { (echo $cwd | path join $item_name) } else { "" }

        # Determine if executable by checking if 'x' is in mode string
        let is_executable = ($row.item.mode | str contains "x")

        # Append * for executables that are not directories
        let name_with_flag = if $is_executable and (not $is_dir) { $decorated_name + "*" } else { $decorated_name }

        $row.item
        | update name {|| $name_with_flag }
    }
    | each { |row| 
        {
        "Name": $row.name
        }
    }
}

def nlrt [] {
    # Capture eza output for decorated names (no color for easier parsing)
    let eza_lines = (eza -d .* --color=always --hyperlink | lines | lines | collect)
    let eza_names = ($eza_lines | each {|line| { decorated_name: $line } })

    # Capture ls data
    let ls_data = (ls -al .* | where { |row| ($row.name | str starts-with ".") and $row.name != "." } | collect)

    # Current directory path for joining paths
    let cwd = (pwd)

    let current_user = (whoami | str trim)

    $ls_data | enumerate | each { |row|
        let decorated_name = ($eza_names | skip $row.index | first | get decorated_name)
        let item_name = $row.item.name
        let is_dir = ($row.item.type == "dir")

        let full_path = if $is_dir { (echo $cwd | path join $item_name) } else { "" }

        # Determine if executable by checking if 'x' is in mode string
        let is_executable = ($row.item.mode | str contains "x")

        # Append * for executables that are not directories
        let name_with_flag = if $is_executable and (not $is_dir) { $decorated_name + "*" } else { $decorated_name }

        $row.item
        | update name {|| $name_with_flag }
    }
    | reverse
    | each { |row| 
        {
        "Name": $row.name
        }
    }
}

def nla_for_nlsr [dir_path] {
  let dir = if $dir_path == null { (pwd) } else { $dir_path }

  # Capture eza output for decorated names in the directory
  let eza_lines = (eza -a --color=always --hyperlink $dir | lines | collect)
  let eza_names = ($eza_lines | each {|line| { decorated_name: $line } })

  # Capture ls data for the directory
  let ls_data = (ls -al $dir | collect)

  let cwd = $dir
  let current_user = (whoami | str trim)

  $ls_data | enumerate | each { |row|
    let decorated_name = ($eza_names | skip $row.index | first | get decorated_name)
    let item_name = $row.item.name
    let is_dir = ($row.item.type == "dir")

    # Determine if executable by checking if 'x' is in mode string
    let is_executable = ($row.item.mode | str contains "x")

    # Append * for executables that are not directories
    let name_with_flag = if $is_executable and (not $is_dir) { $decorated_name + "*" } else { $decorated_name }

    $row.item | update name {|| $name_with_flag }
  }
  | each { |row|
    let color_code = if ($row.user != $current_user) { "38;2;169;169;169m" } else { "38;2;248;240;164m" }
    let colored_user = (ansi --escape $color_code) + $row.user + (ansi --escape "0m")
    $row | update user {|| $colored_user }
  }
  | each { |row|
    let exact_modified = $row.modified | format date "%d %b %H:%M"
    $row | update modified {|| $exact_modified }
  }
  | each { |row|
    let modified_str = $row.modified | into string
    let colored_date = (ansi --escape "38;2;0;55;216m") + $modified_str + (ansi --escape "0m")
    $row | update modified {|| $colored_date }
  }
  | each { |row|
    let size_str = $row.size | into string
    let colored_size = if $row.type == "dir" { "-" } else { (ansi --escape "38;2;22;197;12m") + $size_str + (ansi --escape "0m") }
    $row | update size {|| $colored_size }
  }
  | each { |row|
    let prefix = if $row.type == "dir" { "d" } else { "." }
    let mode_str = $prefix + $row.mode
    let chars = $mode_str | split chars
    # ...mode coloring logic omitted for brevity; include as you have it...
    $row | update mode {|| $mode_str }
  }
  # Add RootDir column here
  | each { |row|
    {
      "Directory": (echo $cwd | path basename),
      "Permissions": $row.mode,
      "Size": $row.size,
      "User": $row.user,
      "Date Modified": $row.modified,
      "Name": $row.name
    }
  }
  # Don't pipe to table here; returns records for caller
}

def nlsr [] {
  let cwd = (pwd)

  # Print table for current working directory first
  echo "Directory: " + (echo $cwd | path basename)
  nla_for_nlsr $cwd
  | table

  # Get root items excluding '.' and '..'
  let root_items = (
    ls -a --all
    | where { |row| ($row.name != "." and $row.name != "..") }
    | collect
  )

  # Filter directories only
  let root_dirs = ($root_items | where { |row| $row.type == "dir" })

  # Then print recursive detailed tables for each subdirectory
  $root_dirs | each { |dir_row|
    echo "\nDirectory: " + $dir_row.name
    let dir_path = (echo $cwd | path join $dir_row.name)
    nla_for_nlsr $dir_path
    | table
  }
}

def nlsn [] {
    # Capture eza output for decorated names (no color for easier parsing)
    let eza_lines = (eza --color=always --hyperlink | lines | collect)
    let eza_names = ($eza_lines | each {|line| { decorated_name: $line } })

    # Capture ls data
    let ls_data = (ls -l | collect)

    # Current directory path for joining paths
    let cwd = (pwd)

    let current_user = (whoami | str trim)

    $ls_data | enumerate | each { |row|
        let decorated_name = ($eza_names | skip $row.index | first | get decorated_name)
        let item_name = $row.item.name
        let is_dir = ($row.item.type == "dir")

        let full_path = if $is_dir { (echo $cwd | path join $item_name) } else { "" }

        # Determine if executable by checking if 'x' is in mode string
        let is_executable = ($row.item.mode | str contains "x")

        # Append * for executables that are not directories
        let name_with_flag = if $is_executable and (not $is_dir) { $decorated_name + "*" } else { $decorated_name }

        $row.item
        | update name {|| $name_with_flag }
    }
    | each { |row| 
        {
        "Name": $row.name
        }
    }
}

def nls [] {
    def perms_to_octal [perms: string] {
    let table = { 'r': 4, 'w': 2, 'x': 1, '-': 0 }
    let chars = $perms | str substring 0..9 | split chars
    let values = $chars | each {|c| ($table | get $c | default 0) }
    let groups = $values | chunks 3
    "0" + ($groups | each {|g| $g | math sum } | str join "")
    }

    # Capture eza output for decorated names (no color for easier parsing)
    let eza_lines = (eza -a --icons=always --color=always --hyperlink | lines | collect)
    let eza_names = ($eza_lines | each {|line| { decorated_name: $line } })

    # Capture ls data
    let ls_data = (ls -al | collect)

    # Current directory path for joining paths
    let cwd = (pwd)

    let current_user = (whoami | str trim)

    $ls_data | enumerate | each { |row|
        let decorated_name = ($eza_names | skip $row.index | first | get decorated_name)
        let item_name = $row.item.name
        let is_dir = ($row.item.type == "dir")

        let full_path = if $is_dir { (echo $cwd | path join $item_name)} else { "" }
        let git_branch = if $is_dir {
            try {
                let branch = git -C $full_path rev-parse --abbrev-ref HEAD err> /dev/null | str trim | default ""
                if $branch == "" { "- -" } else {"| " + $branch }
            } catch {
                "- -"
            }
        } else {
            "- -"   # also mark files with "-"
        }

        # Determine if executable by checking if 'x' is in mode string
        let is_executable = ($row.item.mode | str contains "x")

        # Append * for executables that are not directories
        let name_with_flag = if $is_executable and (not $is_dir) { $decorated_name + "*" } else { $decorated_name }

        $row.item
        | update name {|| $name_with_flag }
        | insert git_branch {|| $git_branch }
    }
    | each { |row|

        let branch_val = $row.git_branch

        let colored_branch = if $branch_val != "- -" {

            (ansi --escape "38;2;22;197;12m") + $branch_val + (ansi --escape "0m")

        } else {

            $branch_val

        }

        $row | update git_branch {|| $colored_branch }

    }
    | insert Octal { |row| 
        let perms = perms_to_octal $row.mode
        let colored = (ansi --escape "38;2;135;23;151m") + $perms + (ansi --escape "0m")
        $colored
    }
    | each { |row|

        let color_code = if ($row.user != $current_user) { "38;2;169;169;169m" } else { "38;2;248;240;164m" }

        let colored_user = (ansi --escape $color_code) + $row.user + (ansi --escape "0m")

        $row | update user {|| $colored_user }

    }
    | each { |row|

        let exact_modified = $row.modified | format date "%d %b %H:%M"

        $row | update modified {|| $exact_modified }

    }
    | each { |row|
        let modified_str = $row.modified | into string
        let colored_date = (ansi --escape "38;2;0;55;216m") + $modified_str + (ansi --escape "0m")
        $row | update modified {|| $colored_date }
    }
    | each { |row|
        let size_str = $row.size | into string
        let colored_size = (ansi --escape "38;2;22;197;12m") + $size_str + (ansi --escape "0m")
        $row | update size {|| $colored_size }
    }
    | each { |row|
        let prefix = if $row.type == "dir" { "d" } else { "." }
        let mode_str = $prefix + $row.mode
        let chars = $mode_str | split chars

        # All 'r' indices
        let r_indices = ($chars | enumerate | where {|e| $e.item == "r"} | get index)

        # Indices of 'r's to color as second color (all except first)
        let mult_r_indices = if ($r_indices | length) > 1 { $r_indices | skip 1 } else { [] }

        let colored_chars = $chars | enumerate | each {|e|
            let c = $e.item
            let i = $e.index

            if $c == "d" {
                (ansi --escape "38;2;41;84;177m") + $c + (ansi --escape "0m")
            } else if $c == "r" {
                if ($mult_r_indices | any {|x| $x == $i}) {
                    (ansi --escape "38;2;132;106;0m") + $c + (ansi --escape "0m")
                } else {
                    (ansi --escape "38;2;248;240;164m") + $c + (ansi --escape "0m")
                }
            } else if $c == "w" {
                (ansi --escape "38;2;187;58;70m") + $c + (ansi --escape "0m")
            } else if $c == "x" {
                (ansi --escape "38;2;18;161;10m") + $c + (ansi --escape "0m")
            } else {
                $c
            }
        }

        let colored_mode = $colored_chars | str join ""

        $row | update mode {|| $colored_mode }
    }
    | each { |row|
        let colored_size = if $row.type == "dir" {
            "-"  # or "" for blank
        } else {
            let size_str = $row.size | into string
            (ansi --escape "38;2;22;197;12m") + $size_str + (ansi --escape "0m")
        }
        $row | update size {|| $colored_size }
    }
    | each { |row| 
        {
        "Octal": $row.Octal,
        "Permissions": $row.mode,
        "Size": $row.size,
        "User": $row.user,
        "Date Modified": $row.modified,
        "Git Repo": $row.git_branch,
        "Name": $row.name
        }
    }
}

def nlsm [] {
    # Capture eza output for decorated names (no color for easier parsing)
    let eza_lines = (eza -a --icons=always --color=always --hyperlink | lines | collect)
    let eza_names = ($eza_lines | each {|line| { decorated_name: $line } })

    # Capture ls data
    let ls_data = (ls -al | collect)

    # Current directory path for joining paths
    let cwd = (pwd)

    let current_user = (whoami | str trim)

    $ls_data | enumerate | each { |row|
        let decorated_name = ($eza_names | skip $row.index | first | get decorated_name)
        let item_name = $row.item.name
        let is_dir = ($row.item.type == "dir")

        let full_path = if $is_dir { (echo $cwd | path join $item_name)} else { "" }
        let git_branch = if $is_dir {
            try {
                let branch = git -C $full_path rev-parse --abbrev-ref HEAD err> /dev/null | str trim | default ""
                if $branch == "" { "- -" } else {"| " + $branch }
            } catch {
                "- -"
            }
        } else {
            "- -"   # also mark files with "-"
        }

        # Determine if executable by checking if 'x' is in mode string
        let is_executable = ($row.item.mode | str contains "x")

        # Append * for executables that are not directories
        let name_with_flag = if $is_executable and (not $is_dir) { $decorated_name + "*" } else { $decorated_name }

        $row.item
        | update name {|| $name_with_flag }
        | insert git_branch {|| $git_branch }
    }
    | each { |row|

        let branch_val = $row.git_branch

        let colored_branch = if $branch_val != "- -" {

            (ansi --escape "38;2;22;197;12m") + $branch_val + (ansi --escape "0m")

        } else {

            $branch_val

        }

        $row | update git_branch {|| $colored_branch }

    }
    | each { |row|

        let color_code = if ($row.user != $current_user) { "38;2;169;169;169m" } else { "38;2;248;240;164m" }

        let colored_user = (ansi --escape $color_code) + $row.user + (ansi --escape "0m")

        $row | update user {|| $colored_user }

    }
    | each { |row|
        let exact_modified = $row.modified | format date "%Y-%m-%d %H:%M"
        $row | update modified {|| $exact_modified }
    }
    | each { |row|
        let modified_str = $row.modified | into string
        let colored_date = (ansi --escape "38;2;0;55;216m") + $modified_str + (ansi --escape "0m")
        $row | update modified {|| $colored_date }
    }
    | each { |row|
        let exact_created = if $row.created != null and ($row.created | str length) > 0 {
        $row.created | format date "%Y-%m-%d %H:%M"
        } else { "------ -:-"}
        $row | update created {|| $exact_created }
    }
    | each { |row|
        let created_str = if ($row.created != null and ($row.created | str length) > 0) {
        $row.created | into string
        } else {"------ -:-"}
        let colored_date_created = (ansi --escape "38;2;0;55;216m") + $created_str + (ansi --escape "0m")
        $row | update created {|| $colored_date_created }
    }
    | each { |row|
        let exact_accessed = $row.accessed | format date "%Y-%m-%d %H:%M"
        $row | update accessed {|| $exact_accessed }
    }
    | each { |row|
        let accessed_str = $row.accessed
        let colored_date_accessed = (ansi --escape "38;2;0;55;216m") + $accessed_str + (ansi --escape "0m")
        $row | update accessed {|| $colored_date_accessed }
    }
    | each { |row|
        let size_str = $row.size | into string
        let colored_size = (ansi --escape "38;2;22;197;12m") + $size_str + (ansi --escape "0m")
        $row | update size {|| $colored_size }
    }
    | each { |row|
        let prefix = if $row.type == "dir" { "d" } else { "." }
        let mode_str = $prefix + $row.mode
        let chars = $mode_str | split chars

        # All 'r' indices
        let r_indices = ($chars | enumerate | where {|e| $e.item == "r"} | get index)

        # Indices of 'r's to color as second color (all except first)
        let mult_r_indices = if ($r_indices | length) > 1 { $r_indices | skip 1 } else { [] }

        let colored_chars = $chars | enumerate | each {|e|
            let c = $e.item
            let i = $e.index

            if $c == "d" {
                (ansi --escape "38;2;41;84;177m") + $c + (ansi --escape "0m")
            } else if $c == "r" {
                if ($mult_r_indices | any {|x| $x == $i}) {
                    (ansi --escape "38;2;132;106;0m") + $c + (ansi --escape "0m")
                } else {
                    (ansi --escape "38;2;248;240;164m") + $c + (ansi --escape "0m")
                }
            } else if $c == "w" {
                (ansi --escape "38;2;187;58;70m") + $c + (ansi --escape "0m")
            } else if $c == "x" {
                (ansi --escape "38;2;18;161;10m") + $c + (ansi --escape "0m")
            } else {
                $c
            }
        }

        let colored_mode = $colored_chars | str join ""

        $row | update mode {|| $colored_mode }
    }
    | each { |row|
        let colored_size = if $row.type == "dir" {
            "-"  # or "" for blank
        } else {
            let size_str = $row.size | into string
            (ansi --escape "38;2;22;197;12m") + $size_str + (ansi --escape "0m")
        }
        $row | update size {|| $colored_size }
    }
    | each { |row|
        {
        "Inode": $row.inode,
        "Permissions": $row.mode,
        "Links": $row.num_links,
        "Size": $row.size,
        "User": $row.user,
        "Group": $row.group
        "Date Modified": $row.modified,
        "Date Created": $row.created,
        "Date Accessed": $row.accessed,
        "Name": $row.name
        }
    }
}

def nlst [] {
  # Helper: Convert permission string to octal notation
  def perms_to_octal [perms: string] {
    let table = { 'r': 4, 'w': 2, 'x': 1, '-': 0 }
    let chars = $perms | str substring 0..9 | split chars
    let values = $chars | each {|c| ($table | get $c | default 0) }
    let groups = $values | chunks 3
    "0" + ($groups | each {|g| $g | math sum } | str join "")
  }

  let cwd = (pwd)

  # List all items in cwd, excluding '.' and '..'
  let root_items = (ls -al | where {|row| $row.name != '.' and $row.name != '..'} | collect)

  let root_files = $root_items | where {|row| $row.type != "dir"}           # all non-dir entries
  let root_dirs = $root_items | where {|row| $row.type == "dir"}

  # Decorated names for cwd files using eza
  let eza_lines_cwd = (eza -a --icons=always --color=always --hyperlink | lines | collect)
  let eza_names_cwd = ($eza_lines_cwd | each {|line| { decorated_name: $line } })

  $root_dirs | each { |dir_row|
    echo ("Directory: " + $dir_row.name)
    let dir_path = ($cwd | path join $dir_row.name)

    let dir_contents = (ls -al $dir_path | collect)
    let eza_lines_dir = (eza -a --icons=always --color=always --hyperlink $dir_path | lines | collect)
    let eza_names_dir = ($eza_lines_dir | each {|line| { decorated_name: $line } })

    let formatted_dir_contents = $dir_contents | enumerate | each { |row|
      let decorated_name = ($eza_names_dir | skip $row.index | first | get decorated_name | default $row.item.name)
      let is_executable = (($row.item.mode | default "") | str contains "x")
      let name_with_flag = if $is_executable { $decorated_name + "*" } else { $decorated_name }

      $row.item
      | update name {|| $name_with_flag }
      | insert Octal {|| (ansi --escape "38;2;135;23;151m") + (perms_to_octal ($row.item.mode | default "")) + (ansi --escape "0m") }
    }
    | each { |row|
      let prefix = if $row.type == "dir" { "d" } else { "." }
      let mode_str = $prefix + ($row.mode | default "")
      let chars = $mode_str | split chars

      let r_indices = ($chars | enumerate | where {|e| $e.item == "r"} | get index)
      let mult_r_indices = if ($r_indices | length) > 1 { $r_indices | skip 1 } else { [] }

      let colored_chars = $chars | enumerate | each {|e|
        let c = $e.item
        let i = $e.index

        if $c == "d" {
          (ansi --escape "38;2;41;84;177m") + $c + (ansi --escape "0m")
        } else if $c == "r" {
          if ($mult_r_indices | any {|x| $x == $i}) {
            (ansi --escape "38;2;132;106;0m") + $c + (ansi --escape "0m")
          } else {
            (ansi --escape "38;2;248;240;164m") + $c + (ansi --escape "0m")
          }
        } else if $c == "w" {
          (ansi --escape "38;2;187;58;70m") + $c + (ansi --escape "0m")
        } else if $c == "x" {
          (ansi --escape "38;2;18;161;10m") + $c + (ansi --escape "0m")
        } else {
          $c
        }
      }

      let colored_mode = $colored_chars | str join ""
      $row | update mode {|| $colored_mode }
    }
    | each { |row|
      let colored_size = if $row.type == "dir" {
        "-"
      } else {
        let size_str = $row.size | into string
        (ansi --escape "38;2;22;197;12m") + $size_str + (ansi --escape "0m")
      }
      $row | update size {|| $colored_size }
    }
    | each { |row|
      let exact_modified = $row.modified | format date "%d %b %H:%M"
      let colored_date = (ansi --escape "38;2;0;55;216m") + $exact_modified + (ansi --escape "0m")
      $row | update modified {|| $colored_date }
    }
    | each { |row|
      {
        Octal: $row.Octal,
        Permissions: $row.mode,
        Size: $row.size,
        "Date Modified": $row.modified,
        $dir_path: $row.name
      }
    }
    $formatted_dir_contents
  }
}
