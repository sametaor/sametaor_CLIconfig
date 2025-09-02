# Environment variables and path exports

# Example environment variables (adapt as needed)
let-env EDITOR = "nvim"
let-env VISUAL = "nvim"
let-env PAGER = "less"
let-env PATH = ($env.PATH | prepend "/usr/local/bin" | prepend "/home/sametaor/.local/bin")