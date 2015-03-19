" Copyright 2014-2015 Richard Russon (flatcap)
"
" Tab to next window, skipping the quickfix window

function! tab#TabSkip(direction)
	if (a:direction)
		let cmd = "w"
	else
		let cmd = "W"
	endif

	execute "wincmd " . cmd
	if (&buftype == "quickfix")
		execute "wincmd " . cmd
	endif
endfunction

