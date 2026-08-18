
function ua --description 'Universal archiver'
	set usage "Archive files or directories using the chosen compression format.

Usage:   ua <format> <file|dir> [more files …]
Example: ua tbz PKGBUILD

Supported formats:
7z, bz2, gz, lzma, lzo, rar, tar, tbz (tar.bz2), tgz (tar.gz),
tlz (tar.lzma), txz (tar.xz), tZ (tar.Z), xz, Z, zip, zst."
	if test (count $argv) -lt 2
		echo $usage >&2
		return 1
	end
	set ext $argv[1]
	set input $argv[2]
	set files $argv[2..-1]
	if not test -e $input
		echo "$input not found" >&2
		return 1
	end
	set output
	if test (count $files) -gt 1
		set output (basename (dirname $input))
	else if test -f $input
		set base (basename $input)
		set output (string split . $base)[1]
	else
		set output (basename $input)
	end
	if test -f "$output.$ext"
		set output (mktemp --tmpdir "$output"_XXX)
		rm -f $output
	end
	set output "$output.$ext"
	if test -e $output
		echo "output file '$output' already exists. Aborting." >&2
		return 1
	end
	switch $ext
		case 7z
			7z u $output $files
		case bz2
			bzip2 -vcf $files > $output
		case gz
			gzip -vcf $files > $output
		case lzma
			lzma -vc -T0 $files > $output
		case lzo
			lzop -vc $files > $output
		case rar
			rar a $output $files
		case tar
			tar -cvf $output $files
		case tbz tar.bz2
			tar -cvjf $output $files
		case tgz tar.gz
			tar -cvzf $output $files
		case tlz tar.lzma
			env XZ_OPT=-T0 tar --lzma -cvf $output $files
		case txz tar.xz
			env XZ_OPT=-T0 tar -cvJf $output $files
		case tZ tar.Z
			tar -cvZf $output $files
		case xz
			xz -vc -T0 $files > $output
		case Z
			compress -vcf $files > $output
		case zip
			zip -rull $output $files
		case zst
			zstd -c -T0 $files > $output
		case '*'
			echo $usage >&2; return 1
	end
end
