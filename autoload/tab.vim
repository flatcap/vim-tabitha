" Copyright 2014-2015 Richard Russon (flatcap)
"
" Switch to next Window, skipping the Quickfix Window
" If there's only one Window, try the next Tab.

function! tab#TabSkip(direction)
	if (winnr ('$') > 1)
		if (a:direction)
			let l:cmd = 'w'
		else
			let l:cmd = 'W'
		endif

		execute 'wincmd ' . l:cmd
		if (&buftype == 'quickfix')
			execute 'wincmd ' . l:cmd
		endif
	elseif (tabpagenr ('$') > 1)
		if (a:direction)
			normal! gt
		else
			normal! gT
		endif
	endif
endfunction

