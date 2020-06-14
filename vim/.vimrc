" disable vi compatabillity layer
:set nocompatible

" file browsing plugin (built-in)
:filetype plugin on

" enable relative line numbers and make current line actual line number
:set number relativenumber
:set nu rnu

" syntax highlighting
:syntax on

" no wrap, horizontal scrolling is needed
:set nowrap

" set path to current directory as well as the next two levels deep in
" directory structure
:set path+=**

" fancy wildmenu when autofilling ambiguous filenames
:set wildmenu

" command to make tags for files in current working directory
:command! MakeTags !ctags -R .

" tag jumping command
:inoremap <Space><Space> <Esc>/<++><Enter>"_c4l

" place tag
:noremap <Space><Space> a<++><Esc>

" C LANG MACROS

" for loop
:autocmd FileType c inoremap ;f for(;<Space><++>;<Space><++>){<++>}<Esc>T(i

" conditional
:autocmd FileType c inoremap ;c if(){<++>}<Esc>T(i
