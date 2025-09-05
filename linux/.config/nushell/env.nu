# Environment variables and path exports

# Example environment variables (adapt as needed)
let EDITOR = "nvim"
let VISUAL = "nvim"
let PAGER = "less"
let PATH = ($env.PATH | prepend "/usr/local/bin" | prepend "/home/sametaor/.local/bin")