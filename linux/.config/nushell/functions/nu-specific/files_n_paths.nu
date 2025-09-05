def mkd [dir: path] {
    if (test -d $dir) {
        let answer = (input "Directory '$dir' already exists. Overwrite? (y/n): ")
        if ($answer | str trim | str downcase) == "y" {
            # Optionally, you can add `rm -r $dir` here if you want to remove it
            # before creating a new one. `mkdir` will just recreate it.
            mkdir $dir
        } else {
            print "Operation canceled."
        }
    } else {
        mkdir $dir
    }
}

def duh [] {
  du | get size | math sum | into filesize | print
}