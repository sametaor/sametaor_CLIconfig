# doas toggle for Fish (Esc Esc to toggle 'doas' prefix)
function __doas_toggle
	set -l cmd (commandline)
	if string match -r '^doas ' -- $cmd
		commandline (string replace -r '^doas ' '' -- $cmd)
	else
		commandline -r "doas $cmd"
	end
end
bind \e\e '__doas_toggle'
