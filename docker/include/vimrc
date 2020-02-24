" syntax highlighting
syntax on

" no welcome msg
set shortmess+=I

" numbered lines
set number

" fix slow escape
set ttimeoutlen=0

" spend more time on syntax highlight
" set synmaxcol=10000
autocmd BufEnter * :syntax sync fromstart

" send more characters for redraws
set ttyfast

" search highlight
set incsearch

" set colorscheme
if &t_Co >= 256 || has("gui_running")
   colorscheme ir_black
endif

" show status line
set laststatus=2

" show status line suggestions
set wildmenu

" netrw
let g:netrw_banner = 0

" spelling toggle
nnoremap <F5> :set nospell!<CR>

" spelling suggestion
nnoremap <F6> z=
