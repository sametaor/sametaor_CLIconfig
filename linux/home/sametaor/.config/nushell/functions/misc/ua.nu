
# ua.nu - Universal archive

export def ua_mod [
  format: string        # Archive format (7z, bz2, gz, tar, tbz, tgz, zip, etc.)
  ...files: string      # Files/directories to archive
] {
  let usage = "Archive files and directories using a given compression algorithm.

Usage:   ua <format> <files>
Example: ua tbz PKGBUILD

Supported archive formats are:
7z, bz2, gz, lzma, lzo, rar, tar, tbz (tar.bz2), tgz (tar.gz),
tlz (tar.lzma), txz (tar.xz), tZ (tar.Z), xz, Z, zip, and zst."

  # Validate input
  if ($files | is-empty) {
    print -e $usage
    return 1
  }

  let input = ($files | first | path expand)

  # Check if input exists
  if not ($input | path exists) {
    print -e $"$input not found"
    return 1
  }

  # Generate output file name
  let output = if ($files | length) > 1 {
    $input | path dirname | path basename
  } else if ($input | path type) == "file" {
    $input | path parse | get stem
  } else if ($input | path type) == "dir" {
    $input | path basename
  } else {
    $input | path basename
  }

  # If output file exists, generate a random name
  let final_output = $"($output).($format)"
  
  if ($final_output | path exists) {
    let temp = (mktemp -d | str trim)
    let random_name = (mktemp "($temp/$output)_XXX" | str trim)
    rm -rf $temp
    set final_output $"($random_name).($format)"
  }

  # Safety check
  if ($final_output | path exists) {
    print -e $"output file '($final_output)' already exists. Aborting"
    return 1
  }

  # Archive based on format
  match $format {
    "7z" => { ^7z u $final_output ...$files },
    "bz2" => { ^bzip2 -vcf ...$files | save -f $final_output },
    "gz" => { ^gzip -vcf ...$files | save -f $final_output },
    "lzma" => { ^lzma -vc -T0 ...$files | save -f $final_output },
    "lzo" => { ^lzop -vc ...$files | save -f $final_output },
    "rar" => { ^rar a $final_output ...$files },
    "tar" => { ^tar -cvf $final_output ...$files },
    "tbz" | "tar.bz2" => { ^tar -cvjf $final_output ...$files },
    "tgz" | "tar.gz" => { ^tar -cvzf $final_output ...$files },
    "tlz" | "tar.lzma" => { 
      $env.XZ_OPT = "-T0"
      ^tar --lzma -cvf $final_output ...$files
    },
    "txz" | "tar.xz" => { 
      $env.XZ_OPT = "-T0"
      ^tar -cvJf $final_output ...$files
    },
    "tZ" | "tar.Z" => { ^tar -cvZf $final_output ...$files },
    "xz" => { ^xz -vc -T0 ...$files | save -f $final_output },
    "Z" => { ^compress -vcf ...$files | save -f $final_output },
    "zip" => { ^zip -rull $final_output ...$files },
    "zst" => { ^zstd -c -T0 ...$files | save -f $final_output },
    _ => {
      print -e $usage
      return 1
    }
  }

  print $"Archived to: ($final_output)"
}
