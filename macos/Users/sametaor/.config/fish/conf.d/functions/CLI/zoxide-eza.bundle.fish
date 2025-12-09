# zoxide + eza ephemeral ls after jump for Fish
function z
	if test (count $argv) -eq 0
		cd $HOME; __z_ephemeral_list; return
	end
	switch $argv[1]
		case '/*' '.*' '~*'
			cd $argv[1]; and __z_ephemeral_list; return
	end
	if type -q zoxide
		set dest (zoxide query -- $argv)
		if test -n "$dest"
			cd $dest
		else
			cd $argv[1] 2>/dev/null; or return
		end
	else
		cd $argv[1] 2>/dev/null; or return
	end
	__z_ephemeral_list
end
function __z_ephemeral_list
	tput smcup; tput civis
	if type -q eza
		eza -a -l --icons=always --color=always --hyperlink -F always --color-scale-mode=gradient --git --git-repos -o -G
	else
		ls -CF --color=auto
	end
	printf '\nPress any key to continue… '
	read -l -n 1 -t 10
	tput cnorm; tput rmcup
end
