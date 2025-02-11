""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set fileencodings=utf-8,gb18030,utf-16le,gbk,gb2312,latin1
set nocompatible
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'ctrlpvim/ctrlp.vim'
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
Plug 'vim-scripts/LargeFile'
Plug 'dense-analysis/ale'
Plug 'whatot/molokai'
Plug 'vim-autoformat/vim-autoformat'
call plug#end()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_working_path_mode = 'ra'
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
let g:LargeFile = 2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:signify_vcs_list = [ 'git', 'hg' ]
nnoremap <silent> wg :SignifyToggle<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:autoformat_autoindent = 1
let g:autoformat_retab = 1
let g:autoformat_remove_trailing_spaces = 1
let g:autoformat_verbosemode = 1
let g:formatdef_markdownfmt = '"~/go/bin/markdownfmt"'
let g:formatters_markdown = ['markdownfmt']
"" use two spaces to indent based on google style guide
"" https://google.github.io/styleguide/shellguide.html#s5-formatting
let g:formatdef_shfmt = '"shfmt -ci -i 2"'
let g:formatters_sh = ['shfmt']
autocmd BufWrite *.md,*.sh,*.sql :Autoformat
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme molokai
if has("mac")
    set guifont=Source\ Code\ Pro:h13
elseif has("unix")
    if hostname() == 'msi'
        set guifont=Source\ Code\ Pro\ 12
    elseif hostname() == "gs65"
        set guifont=Source\ Code\ Pro\ 13
    elseif hostname() == 'b150'
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
set novisualbell  " 不要闪烁
set noerrorbells  " 关闭遇到错误时的声音提示
autocmd FileType make setlocal noexpandtab
autocmd FileType markdown setlocal ts=2 sw=2 sts=2 expandtab autoindent
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
    set columns=999
    set lines=999
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" alias gvim='gvim -c "call Maximize_Window()"'
function! Maximize_Window()
    silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunction
nmap <F11> :call Maximize_Window()<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("mac")
    set clipboard=unnamed
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
