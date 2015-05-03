# tabitha.vim

## Introduction

Tabitha helps you switch between windows and tabs.

The plugin creates mappings to help you quickly navigate between windows and tabs.
Pressing &lt;Tab&gt; in normal mode will move the focus to the next window.
If there are no more windows, the next tab will be selected.

By pressing &lt;S-Tab&gt; the focus will be moved to the previous window, or tab.

## Configuration

The behaviour of Tabitha is controlled by four global variables:

    let g:tabitha_navigate_windows = 1
    let g:tabitha_navigate_tabs    = 1
    let g:tabitha_wrap_around      = 1
    let g:tabitha_select_window    = 1

## Mappings

By default, Tabitha will create two mappings:

    <Tab>   Move forwards through windows
    <S-Tab> Move backwards through windows

These can be disabled by setting:

    let g:tabitha_create_mappings = 0

You can create your own mappings which call Tabitha, e.g.

    nnoremap <silent> <F3> :call tabitha#Switch (1)<CR>
    nnoremap <silent> <F4> :call tabitha#Switch (0)<CR>

See the 'API' Section, below, for more details.

## API

Tabitha introduces three functions to vim.
They are configured by four variables, described in 'Configuation', above.

    function! tabitha#NextWindow (...)
    function! tabitha#NextTab (...)
    function! tabitha#Switch (...)

### NextWindow

NextWindow moves the cursor to the next/previous window.
It takes two optional parameters which both default to 1 (true)

    tabitha#NextWindow (forwards, wrap)

    forwards -- direction of change
    wrap     -- wrap around at end of window list

e.g.

    call tabitha#NextWindow (1, 1)

### NextTab

NextTab moves the cursor to the next/previous tab.
It takes three optional parameters which all default to 1 (true)

    tabitha#NextTab (forwards, wrap, select_window)

    forwards      -- direction of change
    wrap          -- wrap around at end of tab list
    select_window -- when switching tabs, pick the first/last window

e.g.

    call tabitha#NextTab (1, 0, 1)

### Switch

Switch moves the cursor to the next/previous window/tab
(dependent on configuration).
It takes one optional parameter which defaults to 1 (true)

    tabitha#Switch (forwards)

    forwards -- direction of change (0 for backwards)

e.g.

    call tabitha#Switch (1)

## Naming

The plugin is whimsically named after the default key mapping.
The name 'Tabitha' is derived from an Aramaic word meaning gazelle.

## License

Copyright &copy; Richard Russon (flatcap).
Distributed under the GPLv3 <http://fsf.org/>

## See also

- [flatcap.org](https://flatcap.org)
- [GitHub](https://github.com/flatcap/vim-tabitha)

