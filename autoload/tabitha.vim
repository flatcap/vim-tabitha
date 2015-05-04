" tabitha.vim - Switch between windows and tabs
" Author:       Rich Russon (flatcap) <rich@flatcap.org>
" Website:      https://flatcap.org
" Copyright:    2014-2015 Richard Russon
" License:      GPLv3 <http://fsf.org/>
" Version:      1.0

" Set some default values
if (!exists ('g:tabitha_navigate_windows')) | let g:tabitha_navigate_windows = 1 | endif
if (!exists ('g:tabitha_navigate_tabs'))    | let g:tabitha_navigate_tabs    = 1 | endif
if (!exists ('g:tabitha_navigate_files'))   | let g:tabitha_navigate_files   = 1 | endif
if (!exists ('g:tabitha_wrap_around'))      | let g:tabitha_wrap_around      = 1 | endif
if (!exists ('g:tabitha_select_window'))    | let g:tabitha_select_window    = 1 | endif

function! tabitha#NextWindow (...)
	" NextWindow moves the cursor to the next/previous window.
	" Parameters (default value)
	"	forwards (1) -- direction of change
	"	wrap     (1) -- wrap around at end of window list
	" Returns
	"	1 - Focus changed
	"	0 - Nothing happened
	let l:forwards = (a:0 > 0) ? a:1 : 1
	let l:wrap     = (a:0 > 1) ? a:2 : 1

	" Windows are numbered from 1 .. n
	let l:win_num = winnr()
	let l:win_max = winnr('$')

	if (l:win_max == 1)
		return 0
	endif

	if (l:forwards)
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
	" NextTab moves the cursor to the next/previous tab.
	" Parameters (default value)
	"	forwards      (1) -- direction of change
	"	wrap          (1) -- wrap around at end of tab list
	"	select_window (1) -- when switching tabs, pick the first/last window
	" Returns
	"	1 - Focus changed
	"	0 - Nothing happened
	let l:forwards      = (a:0 > 0) ? a:1 : 1
	let l:wrap          = (a:0 > 1) ? a:2 : 1
	let l:select_window = (a:0 > 2) ? a:3 : 1

	" Tabs are numbered from 1 .. n
	let l:tab_num = tabpagenr()
	let l:tab_max = tabpagenr('$')

	if (l:tab_max == 1)
		return 0
	endif

	if (l:forwards)
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

function! tabitha#NextFile (...)
	" NextFile moves the cursor to the next/previous file.
	" Parameters (default value)
	"	forwards (1) -- direction of change
	"	wrap     (1) -- wrap around at end of tab list
	" Returns
	"	1 - Focus changed
	"	0 - Nothing happened
	let l:forwards = (a:0 > 0) ? a:1 : 1
	let l:wrap     = (a:0 > 1) ? a:2 : 1

	" We number the Files from 1 .. n
	let l:file_num = argidx() + 1
	let l:file_max = argc()

	if (l:file_max == 1)
		return 0
	endif

	if (l:forwards)
		if (l:wrap || (l:file_num < l:file_max))
			if (l:file_num == l:file_max)
				execute 'rewind'
			else
				execute 'next'
			endif
			return 1
		endif
	else
		if (l:wrap || (l:file_num > 1))
			if (l:file_num == 1)
				execute 'last'
			else
				execute 'previous'
			endif
			return 1
		endif
	endif
	return 0
endfunction

function! tabitha#Switch (...)
	" Switch moves the cursor to the next/previous window/tab/file
	" Parameters (default value)
	"	forwards (1) -- direction of change
	" Returns
	"	n - Focus changed n times
	"	0 - Nothing happened
	let l:forwards = (a:0 > 0) ? a:1 : 1

	let l:w = (g:tabitha_navigate_windows && (winnr('$')     > 1))
	let l:t = (g:tabitha_navigate_tabs    && (tabpagenr('$') > 1))
	let l:f = (g:tabitha_navigate_files   && (argc()         > 1))

	let l:count = v:count ? v:count : 1
	echom printf ('v %d, l %d', v:count, l:count)

	let l:result = 0

	for l:i in range (1, l:count)
		if (l:w)
			" Don't wrap windows if we're navigating tabs
			let l:wrap = l:t ? 0 : g:tabitha_wrap_around
			if (tabitha#NextWindow (l:forwards, l:wrap))
				let l:result += 1
				continue
			endif
		endif

		if (l:t)
			if (tabitha#NextTab (l:forwards, g:tabitha_wrap_around, g:tabitha_select_window))
				let l:result += 1
				continue
			endif
		endif

		if (l:f && !l:w && !l:t)
			" Special case of 1 window and 1 tab
			if (tabitha#NextFile (l:forwards, g:tabitha_wrap_around))
				let l:result += 1
				continue
			endif
		endif
	endfor

	return l:result
endfunction

