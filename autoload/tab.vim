" Copyright 2014 Richard Russon (flatcap)
"
" Tab to next window, skipping the quickfix window

function! tab#TabSkip()
	execute "wincmd w"
	if (&buftype == "quickfix")
		execute "wincmd w"
	endif
endfunction

