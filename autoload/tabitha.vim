" tabitha.vim - Switch between windows and tabs
" Author:       Rich Russon (flatcap) <rich@flatcap.org>
" Website:      https://flatcap.org
" Copyright:    2014-2015 Richard Russon
" License:      GPLv3 <http://fsf.org/>
" Version:      1.0

" Set some default values
if (!exists ('g:tabitha_navigate_windows')) | let g:tabitha_navigate_windows = 1 | endif
if (!exists ('g:tabitha_navigate_tabs'))    | let g:tabitha_navigate_tabs    = 1 | endif
if (!exists ('g:tabitha_wrap_around'))      | let g:tabitha_wrap_around      = 1 | endif
if (!exists ('g:tabitha_select_window'))    | let g:tabitha_select_window    = 1 | endif

function! tabitha#NextWindow (...)
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

function! tabitha#NextTab (...)
	" Parameters (default value)
	"	forwards      (1) -- direction of change
	"	wrap          (1) -- wrap around at end of window/tab list
	"	select_window (1) -- when switching tabs, pick the first/last window
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

function! tabitha#Switch (...)
	" Parameters (default value)
	"	forwards (1) -- direction of change
	let l:forwards = (a:0 > 0) ? a:1 : 1

	if (g:tabitha_navigate_windows)
		" Don't wrap windows if we're wrapping tabs
		let l:wrap = (g:tabitha_navigate_tabs) ? 0 : g:tabitha_wrap_around
		if (tabitha#NextWindow (l:forwards, l:wrap))
			return 1
		endif
	endif

	if (g:tabitha_navigate_tabs)
		if (tabitha#NextTab (l:forwards, g:tabitha_wrap_around, g:tabitha_select_window))
			return 1
		endif
	endif

	return 0
endfunction


