" Copyright 2014-2015 Richard Russon (flatcap)
"
" Switch to next Window or Tab

" Set some default values
if (!exists ('g:tab_navigate_windows')) | let g:tab_navigate_windows = 1 | endif
if (!exists ('g:tab_navigate_tabs'))    | let g:tab_navigate_tabs    = 1 | endif
if (!exists ('g:tab_wrap_around'))      | let g:tab_wrap_around      = 1 | endif
if (!exists ('g:tab_select_window'))    | let g:tab_select_window    = 1 | endif

function! tab#NextWindow (...)
	" Parameters (default value)
	"	forwards (1) -- direction of change
	"	wrap     (1) -- wrap around at end of window/tab list
	let l:forwards = (a:0 > 0) ? a:1 : 1
	let l:wrap     = (a:0 > 1) ? a:2 : 1

	let l:win_num = winnr()

	if (l:forwards)
		let l:win_max = winnr('$')
		if (l:wrap || (l:win_num < l:win_max))
			wincmd w
			return 1
		endif
	else
		if (l:wrap || (l:win_num > 1))
			wincmd W
			return 1
		endif
	endif
	return 0
endfunction

function! tab#NextTab (...)
	" Parameters (default value)
	"	forwards      (1) -- direction of change
	"	wrap          (1) -- wrap around at end of window/tab list
	"	select_window (1) -- when swiching tabs, pick the first/last window
	let l:forwards      = (a:0 > 0) ? a:1 : 1
	let l:wrap          = (a:0 > 1) ? a:2 : 1
	let l:select_window = (a:0 > 2) ? a:3 : 1

	let l:tab_num = tabpagenr()

	if (l:forwards)
		let l:tab_max = tabpagenr('$')
		if (l:wrap || (l:tab_num < l:tab_max))
			normal! gt
			if (l:select_window)
				wincmd t
			endif
			return 1
		endif
	else
		if (l:wrap || (l:tab_num > 1))
			normal! gT
			if (l:select_window)
				wincmd b
			endif
			return 1
		endif
	endif
	return 0
endfunction

function! tab#TabSkip (...)
	" Parameters (default value)
	"	forwards (1) -- direction of change
	let l:forwards = (a:0 > 0) ? a:1 : 1

	if (g:tab_navigate_windows)
		" Don't wrap windows if we're wrapping tabs
		let l:wrap = (g:tab_navigate_tabs) ? 0 : g:tab_wrap_around
		if (tab#NextWindow (l:forwards, l:wrap))
			return 1
		endif
	endif

	if (g:tab_navigate_tabs)
		if (tab#NextTab (l:forwards, g:tab_wrap_around, g:tab_select_window))
			return 1
		endif
	endif

	return 0
endfunction


