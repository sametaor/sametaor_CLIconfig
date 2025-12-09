
function copypath --description 'Copy absolute path to clipboard'
	set file (count $argv) -gt 0; and set file $argv[1]; or set file .
	if not string match -r '^/' $file
		set file (pwd)/$file
	end
	printf '%s' $file | clipcopy
	set_color --bold
	echo "$file copied to clipboard."
	set_color normal
end
