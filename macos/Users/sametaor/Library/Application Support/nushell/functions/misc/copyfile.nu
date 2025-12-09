
export def copyfile_mod [
  file: string  # Path to file whose contents should be copied
] {
  if not ($file | path exists) or ($file | path type) != "file" {
    print -e $"Error: '($file)' is not a file"
    return 1
  }

  ^clipcopy $file
}
