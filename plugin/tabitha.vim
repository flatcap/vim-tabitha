" tabitha.vim - Switch between windows and tabs
" Author:       Rich Russon (flatcap) <rich@flatcap.org>
" Website:      https://flatcap.org
" Copyright:    2014-2015 Richard Russon
" License:      GPLv3 <http://fsf.org/>
" Version:      1.0

if (exists ('g:loaded_tabitha') || &cp || (v:version < 700))
	finish
endif
let g:loaded_tabitha = 1

" Set some default values
if (!exists ('g:tabitha_navigate_windows')) | let g:tabitha_navigate_windows = 1 | endif
if (!exists ('g:tabitha_navigate_tabs'))    | let g:tabitha_navigate_tabs    = 1 | endif
if (!exists ('g:tabitha_wrap_around'))      | let g:tabitha_wrap_around      = 1 | endif
if (!exists ('g:tabitha_select_window'))    | let g:tabitha_select_window    = 1 | endif

if (!exists('g:tabitha_create_mappings') || (g:tabitha_create_mappings == 1))
	nnoremap <silent> <Tab>   :call tabitha#Switch (1)<CR>
	nnoremap <silent> <S-Tab> :call tabitha#Switch (0)<CR>
endif

