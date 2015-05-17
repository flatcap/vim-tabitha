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

if (get (g:, 'tabitha_create_mappings', 0))
	nnoremap <silent> <Plug>TabithaNextWindow      :<C-u>call tabitha#NextWindow(1)<CR>
	nnoremap <silent> <Plug>TabithaPreviousWindow  :<C-u>call tabitha#NextWindow(0)<CR>

	nnoremap <silent> <Plug>TabithaNextTab         :<C-u>call tabitha#NextTab(1)<CR>
	nnoremap <silent> <Plug>TabithaPreviousTab     :<C-u>call tabitha#NextTab(0)<CR>

	nnoremap <silent> <Plug>TabithaNextFile        :<C-u>call tabitha#NextFile(1)<CR>
	nnoremap <silent> <Plug>TabithaPreviousFile    :<C-u>call tabitha#NextFile(0)<CR>

	nnoremap <silent> <Plug>TabithaSwitchForwards  :<C-u>call tabitha#Switch(1)<CR>
	nnoremap <silent> <Plug>TabithaSwitchBackwards :<C-u>call tabitha#Switch(0)<CR>

	nmap <silent> <Tab>   <Plug>TabithaSwitchForwards
	nmap <silent> <S-Tab> <Plug>TabithaSwitchBackwards
endif

