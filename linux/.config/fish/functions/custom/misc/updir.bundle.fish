
function updir --description 'Move up N directories'
	set n (math "min(max(1, $argv[1]), 99)")
	if test -z "$n"; set n 1; end
	set relpath (string repeat -n $n '../')
	cd $relpath
end
for i in (seq 1 99)
	alias z$i "updir $i"
end
