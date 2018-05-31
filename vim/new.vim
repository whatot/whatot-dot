""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set fileencodings=utf-8,gb18030,utf-16le,gbk,gb2312,latin1
set nocompatible
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'Shougo/denite.nvim' | Plug 'Shougo/neomru.vim'
Plug 'asins/vimcdoc'
Plug 'bronson/vim-trailing-whitespace'
Plug 'luochen1990/rainbow'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-signify'
Plug 'pelodelfuego/vim-swoop'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'whatot/molokai'
call plug#end()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
nnoremap <silent> <space>c  :<C-u>Denite command<cr>
nnoremap <silent> <space>b  :<C-u>Denite buffer<cr>
nnoremap <silent> <space>f  :<C-u>Denite file_rec<cr>
nnoremap <silent> <space>r  :<C-u>Denite file_mru<cr>
nnoremap <silent> <space>p  :<C-u>Denite -resume<CR>
nnoremap <silent> <space>t  :call execute('Denite file_rec:'.expand('%:p:h'))<CR>
nnoremap <silent> <space>w  :<C-u>DeniteCursorWord  -auto-resize line<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> wf :NERDTreeToggle<CR>
nnoremap <silent> we :NERDTree %:h<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':p:t'
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#csv#enabled = 0
let g:airline_powerline_fonts=0
let g:airline_theme='molokai'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rainbow_active = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:signify_vcs_list = [ 'git', 'hg' ]
nnoremap <silent> wg :SignifyToggle<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme molokai
if has("mac")
    set guifont=Source\ Code\ Pro:h13
elseif has("unix")
    if hostname() == 'b150'
        set guifont=Source\ Code\ Pro\ 11
    elseif hostname() == 'x411'
        set guifont=Source\ Code\ Pro\ 13
    endif
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set helplang=cn
set number
set hidden
set list
set nolinebreak
set smartindent
set cindent
set smartcase
set wrap
set autochdir
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set colorcolumn=80
set cursorline
set background=dark
set laststatus=2
set showcmd
autocmd FileType make set noexpandtab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","
let g:mapleader=","
noremap \ ,
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! Lin setl ff=unix fenc=utf8 nobomb eol
command! Win setl ff=dos fenc=gb18030 nobomb eol
nnoremap <F12> :%s/[ \t\r]\+$//g<CR>
cnoremap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>
set pastetoggle=<F5>
" Ctrl+c to copy in vmode
vnoremap <C-c> "+y
" Shift + Delete 插入系统剪切板中的内容
nnoremap <S-Del> "+p
inoremap <S-Del> <esc>"+pa
vnoremap <S-Del> d"+P
" move one line up or down
nmap <C-j> mz:m+<cr>`z
nmap <C-k> mz:m-2<cr>`z
vmap <C-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <C-k> :m'<-2<cr>`>my`<mzgv`yo`z
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <leader>er :e $HOME/.vimrc<CR>
autocmd! BufWritePost $HOME/.vimrc source $HOME/.vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunction
autocmd BufWrite *.py :call DeleteTrailingWS()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_running")
    set guioptions-=m   " hide menu bar
    set guioptions-=T   " hide tool bar
    set guioptions-=L   " hide left scroll
    set guioptions-=r   " hide right scroll
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" alias gvim='gvim -c "call Maximize_Window()"'
function! Maximize_Window()
    silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunction
nmap <F11> :call Maximize_Window()<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
