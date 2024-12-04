" slime.vim
" SLIME-like REPL functionality for vim.
"
" put this file into your .vim/plugins folder
"
" Instructions
" Open a :terminal and start your REPL
" Enter normal mode and execute :SetREPL to let vim know which terminal you
" want to use as a REPL.
"
" It typically looks like this:
"     :term
"     ... start REPL program ...
"     CTRL+w
"     :SetREPL
"
" Afterwards, you can move to the window with your text buffer and run
" lines of code from it.
"
" Use CTRL+C in normal mode to send the current line your cursor is on to the
" REPL buffer
"
" Use CTRL+C in visual mode to send the selected lines to your REPL buffer
"
" 12/2024
" - mjc

let s:repl_buf=-1

def slime#set_repl_buffer()
    s:repl_buf = bufnr('%')
enddef

def slime#inject_text(text: string)
    var bufnr = s:repl_buf
    if bufexists(bufnr) && getbufvar(bufnr, '&buftype') == 'terminal'
        call term_sendkeys(bufnr, text .. "\<CR>")
    else
        echoerr "Invalid buffer or not a terminal buffer"
    endif
enddef

command SetREPL call slime#set_repl_buffer()
nnoremap <silent><C-C> :call slime#inject_text(getline('.'))<CR>
vnoremap <silent><C-C> :<C-u>call slime#inject_text(escape(join(getline("'<", "'>"), "\n"), ''))<CR>
