" Theme
colorscheme retrobox
set background=dark
set shm+=I

packadd! termdebug
let g:termdebug_wide = 1

filetype plugin indent on
syntax on

set backspace=indent,eol,start
set foldlevel=1
set foldmethod=manual
set foldnestmax=1
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set number relativenumber
set ruler
set smartcase
set splitright
set switchbuf=useopen
set wildmenu
set wrap linebreak

"skeletons
autocmd BufNewFile *.sh 0r ~/.vim/skeletons/bash.sh
autocmd BufNewFile *.py 0r ~/.vim/skeletons/python.py
autocmd BufNewFile *.c  0r ~/.vim/skeletons/c.c
autocmd BufNewFile *.html  0r ~/.vim/skeletons/html.html

au BufRead,BufNewFile *.sqc set filetype=c

" clear highlights
nnoremap <CR> :noh<CR>
" change vim's cwd to buffer file dir
nnoremap <leader>w :lcd %:p:h <CR>
" changes since last save
nnoremap <leader>d :w !diff --unified % - \| less<CR>
" toggle crosshair
nnoremap <leader>c :set cursorline! cursorcolumn!<CR>
" grabby ctrl
nnoremap <silent> <C-j> <ESC>:m +1<CR>
nnoremap <silent> <C-k> <ESC>:m -2<CR>

def SvnBlameLine()
	printf("svn blame %s | head -n %s | tail -n 1| head -c 6", expand('%'), line('.'))
		->system()
		->printf("svn log -r %s %s", expand('%'))
		->system()
		->split("\n")
		->popup_atcursor({ "padding": [0, 1, 1, 1] })
enddef
nnoremap <silent><leader>bs :call SvnBlameLine()<CR>

def GitBlameLine()
    printf("git blame -s -L %s,%s -- %s | head -c 8", line('.'), line('.'), expand('%'))
        ->system()
        ->printf("git log --stat -1 %s")
        ->system()
        ->split("\n")
        ->popup_atcursor({ "padding": [0, 1, 1, 1] })
enddef
nnoremap <silent><leader>bg :call GitBlameLine()<CR>

command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

let g:llama_config = {
    \ 'endpoint':         $LLAMA_CODE_API_URL .. '/infill',
    \ 'api_key':          $LLAMA_API_KEY,
    \ 'n_prefix':         256,
    \ 'n_suffix':         64,
    \ 'n_predict':        128,
    \ 't_max_prompt_ms':  500,
    \ 't_max_predict_ms': 3000,
    \ 'show_info':        2,
    \ 'auto_fim':         v:false,
    \ 'max_line_suffix':  8,
    \ 'ring_n_chunks':    64,
    \ 'ring_chunk_size':  64,
    \ 'ring_scope':       1024,
    \ 'ring_update_ms':   1000,
    \ }

function ToggleLlamaAutoFIM()
	let g:llama_config.auto_fim = !g:llama_config.auto_fim
	call llama#init()
endfunction
inoremap <silent><C-\> <ESC>:call ToggleLlamaAutoFIM()<CR>i

function SwitchLlamaServer(servername)
	let g:llama_config.endpoint = a:servername
	call llama#init()
endfunction

command LlamaLocal call SwitchLlamaServer('http://127.0.0.1:8012/infill')
command LlamaRemote call SwitchLlamaServer($LLAMA_CODE_API_URL .. '/infill')
