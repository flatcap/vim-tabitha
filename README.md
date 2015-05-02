# tabitha.vim

## Introduction

Tabitha helps you switch between windows and tabs.

The plugin creates mappings to help you quickly navigate between windows and tabs.
Pressing &lt;Tab&gt; in normal mode will move the focus to the next window.
If there are no more windows, the next tab will be selected.

By pressing &lt;S-Tab&gt; the focus will be moved to the previous window, or tab.

## Configuration

The behaviour of Tabitha is controlled by four global variables:

    g:tabitha_navigate_windows
    g:tabitha_navigate_tabs
    g:tabitha_wrap_around
    g:tabitha_select_window


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

### tabitha#NextWindow (...)

NextWindow moves the cursor to the next/previous window.

    NextWindow (forwards, wrap)

It takes two optional parameters

    forwards - move the cursor forwards, right, or down.

## Naming

The plugin is whimsically named after the default key mapping.
The name 'Tabitha' is derived from an Aramaic word meaning gazelle.

## License

Copyright &copy; Richard Russon (flatcap).
Distributed under the GPLv3 &lt;http://fsf.org/&gt;

## See also

- [flatcap.org](https://flatcap.org)
- [GitHub](https://github.com/flatcap/vim-tabitha)

