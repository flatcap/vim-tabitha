# tabitha.vim

## Introduction

Tabitha helps you switch between windows, tabs and files.

The plugin creates two mappings: `<Tab>` to move forwards and `<S-Tab>` to move backwards.
Pressing `<Tab>` in normal mode will move the focus to the next window.  If there are no more windows, the next tab will be selected.

If there is only one window and one tab, then Tabitha will switch to the next file in the arglist.

By pressing `<S-Tab>` the focus will be moved to the previous window, tab or file.

The default mappings support a count.  Therefore pressing `3<Tab>` will move the focus forward three windows, tabs or files.

## Configuration

The behaviour of Tabitha is controlled by five global variables:

```viml
let g:tabitha_navigate_windows = 1
let g:tabitha_navigate_tabs    = 1
let g:tabitha_navigate_files   = 1
let g:tabitha_wrap_around      = 1
let g:tabitha_select_window    = 1
```

The default behaviour is to switch to the next window.  If there are no more windows, then the first window of the next tab will be selected.  When the final window of the final tab is reached, the focus will wrap around to the first window of the first tab.

By choosing which variables to set, you can choose to cycle through:

- Just Windows
- Windows and Tabs
- Just Tabs
- Just Files

When switching between tabs, the `select_window` option controls whether the focus should be set to the first window in that tab.

## Mappings

By default, Tabitha will create two mappings:

    <Tab>   Move forwards through windows
    <S-Tab> Move backwards through windows

These can be disabled by setting:

```viml
let g:tabitha_create_mappings = 0
```

You can create your own mappings which call Tabitha, e.g.

```viml
" Move focus forwards
nnoremap <silent> <F3> :call tabitha#Switch (1)<CR>
" Move focus backwards
nnoremap <silent> <F4> :call tabitha#Switch (0)<CR>
```

## API

Tabitha introduces four functions to vim.  Their behaviour is configured by five variables, described in 'Configuation', above.

```viml
function! tabitha#NextWindow (...)
function! tabitha#NextTab (...)
function! tabitha#NextFile (...)
function! tabitha#Switch (...)
```

### NextWindow

NextWindow moves the cursor to the next/previous window.
It takes two optional parameters.
It returns 1 if the focus was changed, 0 otherwise.

```viml
tabitha#NextWindow (forwards, wrap)
```

| Parameter | Default  | Description                       |
| --------- | -------- | --------------------------------- |
| forwards  | 1 (true) | direction of change               |
| wrap      | 1 (true) | wrap around at end of window list |

e.g.

```viml
call tabitha#NextWindow ()
call tabitha#NextWindow (1, 1)
```

### NextTab

NextTab moves the cursor to the next/previous tab.
It takes three optional parameters.
It returns 1 if the focus was changed, 0 otherwise.

```viml
tabitha#NextTab (forwards, wrap, select_window)
```

| Parameter     | Default  | Description                                     |
| ------------- | -------- | ----------------------------------------------- |
| forwards      | 1 (true) | direction of change                             |
| wrap          | 1 (true) | wrap around at end of tab list                  |
| select_window | 1 (true) | when switching tabs, pick the first/last window |

e.g.

```viml
call tabitha#NextTab ()
call tabitha#NextTab (1, 0, 0)
```

### NextFile

NextFile moves the cursor to the next/previous file.
It takes two optional parameters.
It returns 1 if the focus was changed, 0 otherwise.

```viml
tabitha#NextFile (forwards, wrap)
```

| Parameter | Default  | Description                     |
| --------- | -------- | ------------------------------- |
| forwards  | 1 (true) | direction of change             |
| wrap      | 1 (true) | wrap around at end of file list |

e.g.

```viml
call tabitha#NextFile ()
call tabitha#NextFile (1, 1)
```

### Switch

Switch moves the cursor to the next/previous window/tab/file (dependent on configuration).
It takes one optional parameter.
It returns the number of times the focus moved, 0 if nothing changed.

```viml
tabitha#Switch (forwards)
```

| Parameter | Default  | Description         |
| --------- | -------- | ------------------- |
| forwards  | 1 (true) | direction of change |

e.g.

```viml
call tabitha#Switch ()
call tabitha#Switch (1)
```

## Naming

The plugin is whimsically named after the default key mapping.
The name 'Tabitha' is derived from an Aramaic word meaning gazelle.

## License

Copyright &copy; Richard Russon (flatcap).
Distributed under the GPLv3 <http://fsf.org/>

## See also

- [flatcap.org](https://flatcap.org)
- [GitHub](https://github.com/flatcap/vim-tabitha)

