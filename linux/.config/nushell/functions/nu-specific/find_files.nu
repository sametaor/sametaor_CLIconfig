def fdir [pattern: string] {
  ls --full-paths -a **/*
  | where type == "dir" and (name =~ $pattern)
}

def ff [pattern: string] {
  ls --full-paths -a **/*
  | where type == "file" and (name =~ $pattern)
}