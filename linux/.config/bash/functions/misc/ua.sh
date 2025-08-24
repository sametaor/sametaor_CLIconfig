# ua.sh — Universal archiver for Bash
ua() {
  # Help text
  local usage='Archive files or directories using the chosen compression format.

Usage:   ua <format> <file|dir> [more files …]
Example: ua tbz PKGBUILD

Supported formats:
7z, bz2, gz, lzma, lzo, rar, tar, tbz (tar.bz2), tgz (tar.gz),
tlz (tar.lzma), txz (tar.xz), tZ (tar.Z), xz, Z, zip, zst.'

  # Need at least a format and one path
  if [ "$#" -lt 2 ]; then
    printf '%s\n' "$usage" >&2
    return 1
  fi

  local ext=$1
  shift                      # $* now holds the items to archive
  local input=$1             # first item drives output-name logic

  # Resolve to an absolute path for tests below (avoid symlink resolution)
  if command -v realpath >/dev/null 2>&1; then
    input=$(realpath -s -- "$input")
  else
    # Fallback: manual absolute path
    case $input in
      /*) ;;                                    # already absolute
      *)  input="$PWD/$input" ;;
    esac
  fi

  if [ ! -e "$input" ]; then
    printf '%s not found\n' "$input" >&2
    return 1
  fi

  # -----------------------------------------------------------------
  # Derive base name for the output archive
  # -----------------------------------------------------------------
  local output
  if [ "$#" -gt 1 ]; then
    # Multiple items → name after directory that holds the first file
    output=$(basename "$(dirname "$input")")
  elif [ -f "$input" ]; then
    # Single file → strip its extension
    local base=$(basename "$input")
    output=${base%.*}
  else
    # Single directory
    output=$(basename "$input")
  fi

  # If the intended archive already exists, create a random suffix
  if [ -f "${output}.${ext}" ]; then
    output=$(mktemp --tmpdir "${output}_XXX") || return 1
    rm -f "$output"
  fi
  output="${output}.${ext}"

  # Safety check
  if [ -e "$output" ]; then
    printf "output file '%s' already exists. Aborting.\n" "$output" >&2
    return 1
  fi

  # -----------------------------------------------------------------
  # Create the archive
  # -----------------------------------------------------------------
  case $ext in
    7z)            7z u                              "$output" "$@" ;;
    bz2)           bzip2  -vcf  "$@" > "$output" ;;
    gz)            gzip   -vcf  "$@" > "$output" ;;
    lzma)          lzma   -vc  -T0 "$@" > "$output" ;;
    lzo)           lzop   -vc       "$@" > "$output" ;;
    rar)           rar a           "$output" "$@"   ;;
    tar)           tar   -cvf      "$output" "$@"   ;;
    tbz|tar.bz2)   tar   -cvjf     "$output" "$@"   ;;
    tgz|tar.gz)    tar   -cvzf     "$output" "$@"   ;;
    tlz|tar.lzma)  XZ_OPT=-T0 tar --lzma -cvf "$output" "$@" ;;
    txz|tar.xz)    XZ_OPT=-T0 tar   -cvJf "$output" "$@" ;;
    tZ|tar.Z)      tar   -cvZf     "$output" "$@"   ;;
    xz)            xz    -vc  -T0 "$@" > "$output" ;;
    Z)             compress -vcf   "$@" > "$output" ;;
    zip)           zip -rull       "$output" "$@"   ;;
    zst)           zstd  -c   -T0 "$@" > "$output" ;;
    *) printf '%s\n' "$usage" >&2; return 1 ;;
  esac
}