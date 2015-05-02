" Copyright 2014-2015 Richard Russon (flatcap)
"
" Switch to next Window or Tab

let g:tab_navigate_windows = 1
let g:tab_navigate_tabs    = 1
let g:tab_wrap_around      = 1
let g:tab_select_window    = 1

function! tab#NextWindow (forwards, wrap)
	" TODO default forwards=1, wrap=1
	let l:win_num = winnr()

	if (a:forwards)
		let l:win_max = winnr('$')
		if (a:wrap || (l:win_num < l:win_max))
			wincmd w
			return 1
		endif
	else
		if (a:wrap || (l:win_num > 1))
			wincmd W
			return 1
		endif
	endif
	return 0
endfunction

function! tab#NextTab (forwards, wrap, select_window)
	" TODO default forwards=1, wrap=1, select_window=1
	let l:tab_num = tabpagenr()

	if (a:forwards)
		let l:tab_max = tabpagenr('$')
		if (a:wrap || (l:tab_num < l:tab_max))
			normal! gt
			if (a:select_window)
				wincmd t
			endif
			return 1
		endif
	else
		if (a:wrap || (l:tab_num > 1))
			normal! gT
			if (a:select_window)
				wincmd b
			endif
			return 1
		endif
	endif
	return 0
endfunction

function! tab#TabSkip (forwards)
	" TODO default forwards=1

	if (g:tab_navigate_windows)
		if (tab#NextWindow (a:forwards, 0)) "g:tab_wrap_around))
			return 1
		endif
	endif

	if (g:tab_navigate_tabs)
		if (tab#NextTab (a:forwards, g:tab_wrap_around, g:tab_select_window))
			return 1
		endif
	endif

	return 0
endfunction

