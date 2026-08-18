export def fdir [pattern: string] {
  ls --full-paths -a **/*
  | where type == "dir" and (name =~ $pattern)
}

export def ff [pattern: string] {
  ls --full-paths -a **/*
  | where type == "file" and (name =~ $pattern)
}
