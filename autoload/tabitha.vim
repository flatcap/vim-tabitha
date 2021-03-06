" tabitha.vim - Switch between windows and tabs
" Author:       Rich Russon (flatcap) <rich@flatcap.org>
" Website:      https://flatcap.org
" Copyright:    2014-2015 Richard Russon
" License:      GPLv3 <http://fsf.org/>
" Version:      1.0

" Set some default values
let g:tabitha_navigate_windows = get (g:, 'tabitha_navigate_windows', 1)
let g:tabitha_navigate_tabs    = get (g:, 'tabitha_navigate_tabs',    1)
let g:tabitha_navigate_files   = get (g:, 'tabitha_navigate_files',   1)
let g:tabitha_wrap_around      = get (g:, 'tabitha_wrap_around',      1)
let g:tabitha_select_window    = get (g:, 'tabitha_select_window',    1)

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
	let l:win_max = winnr ('$')

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
	let l:tab_max = tabpagenr ('$')

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

	" Files are numbered from 1 .. n
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

	let l:tabs  = (g:tabitha_navigate_tabs  && (tabpagenr ('$') > 1))
	let l:files = (g:tabitha_navigate_files && (argc()          > 1))

	let l:count  = v:count1
	let l:result = 0

	for l:i in range (1, l:count)
		let l:wins = (g:tabitha_navigate_windows && (winnr ('$') > 1))
		if (l:wins)
			" Don't wrap windows if we're navigating tabs
			let l:wrap = l:tabs ? 0 : g:tabitha_wrap_around
			if (tabitha#NextWindow (l:forwards, l:wrap))
				let l:result += 1
				continue
			endif
		endif

		if (l:tabs)
			if (tabitha#NextTab (l:forwards, g:tabitha_wrap_around, g:tabitha_select_window))
				let l:result += 1
				continue
			endif
		endif

		if (l:files && !l:wins && !l:tabs)
			" Special case of 1 window and 1 tab
			if (tabitha#NextFile (l:forwards, g:tabitha_wrap_around))
				let l:result += 1
				continue
			endif
		endif
	endfor

	return l:result
endfunction

