if 0 | endif  " Note: Skip initialization for vim-tiny or vim-small
set fileencodings=utf-8,gb18030,utf-16le,gbk,gb2312,latin1
set nocompatible

call plug#begin(expand('~/.vim/plugged'))
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'Lokaltog/vim-easymotion'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/unite-outline'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'SirVer/ultisnips'
Plug 'Yggdroot/indentLine'
Plug 'amix/vim-zenroom2'
Plug 'asins/vimcdoc'
Plug 'bronson/vim-trailing-whitespace'
Plug 'dkasak/manpageview'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/goyo.vim'
Plug 'lambdalisue/unite-grep-vcs'
Plug 'lilydjwg/fcitx.vim'
Plug 'luochen1990/rainbow'
Plug 'majutsushi/tagbar'
Plug 'maralla/completor.vim'
Plug 'mhinz/vim-signify'
Plug 'mileszs/ack.vim'
Plug 'pelodelfuego/vim-swoop'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'sheerun/vim-polyglot'
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tyok/nerdtree-ack', { 'on':  'NERDTreeToggle' }
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/L9'
Plug 'vim-scripts/LargeFile'
Plug 'w0rp/ale'
Plug 'whatot/molokai'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#end()
filetype plugin indent on
syntax on
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<c-l>"
" let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ackprg = 'ag --nogroup --nocolor --column'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':p:t'  " filename too long
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#csv#enabled = 1
let g:airline_powerline_fonts=0
let g:airline_theme='molokai'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:ale_lint_on_save = 1
" let g:ale_lint_on_text_changed = 0
" let g:ale_lint_on_enter = 0
" I already wrap LocationList and Quickfix, so below is not needed
" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" nmap <silent> <C-j> <Plug>(ale_next_wrap)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader>z :Goyo<cr>
let g:goyo_width = 80
let g:goyo_margin_top = 4
let g:goyo_margin_bottom = 4
let g:goyo_linenr = 0
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"[default],cc;,cu注释与取消注释快速切换
let NERDSpaceDelims = 1                   " 让注释符与语句之间留一个空格
let NERDCompactSexyComs = 1               " 多行注释时样子更好看
let NERD_c_alt_style = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeIgnore=['\.d$[[dir]]', '\.o$[[file]]', '\.swp$[[file]]']
nnoremap <silent> wf :NERDTreeMirrorToggle<CR>
nnoremap <silent> we :NERDTree %:h<CR>
let g:NERDChristmasTree = 1               " 色彩显示
let g:NERDTreNERDShowHidden = 1           " 显示隐藏文件
let g:NERDTreeWinPos = 'left'             " 窗口显示位置
let g:NERDTreeHighlightCursorline = 0     " 高亮当前行
let g:NERDTreeWinSize = 40                " 设置显示宽度
let NERDTreeChDirMode = 2
let NERDTreeShowBookmarks = 0
let NERDTreeShowHidden = 0  " using 'I' to toggle (show hidden files)
let g:nerdtree_tabs_open_on_gui_startup = 0
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rainbow_active = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nmap <Leader>l :call Swoop()<CR>
" vmap <Leader>l :call SwoopSelection()<CR>
" nmap <Leader>ml :call SwoopMulti()<CR>
" vmap <Leader>ml :call SwoopMultiSelection()<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> wt :TagbarToggle<CR>
let g:tagbar_width = 40
let g:tagbar_expand = 0  " 0向内拓展 - 1向外拓展
let g:tagbar_left = 1
" autocmd FileType c,cpp nested :TagbarOpen  " 默认开启tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:unite_source_rec_max_cache_files = 2000
let g:unite_source_find_max_candidates = 2000
let g:unite_source_history_yank_enable = 1
let g:unite_enable_start_insert = 1
let g:unite_enable_short_source_names = 1
let g:unite_source_rec_async_command = ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']
nnoremap sp :execute 'Unite' 'file_rec/async:'.unite#util#path2project_directory(getcwd())<CR>
nnoremap sr :<C-u>Unite file_mru<cr>
nnoremap sm :<C-u>Unite mapping<cr>
nnoremap sg :<C-u>Unite -quick-match grep/git:.<cr>
nnoremap sh :Unite history/unite<cr>
nnoremap sb :Unite -start-insert buffer<cr>
nnoremap so :<C-u>Unite outline<cr>
" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
    " Play nice with supertab
    let b:SuperTabDisabled=1
    " Enable navigation with control-j and control-k in insert mode
    imap <buffer> <C-j>   <Plug>(unite_select_next_line)
    imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let EasyMotion_leader_key = '<leader><leader>'
let EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map + <Plug>(expand_region_expand)
map - <Plug>(expand_region_shrink)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:multi_cursor_use_default_mapping=0
" " Default mapping
" let g:multi_cursor_next_key='<C-n>'
" let g:multi_cursor_prev_key='<C-p>'
" let g:multi_cursor_skip_key='<C-x>'
" let g:multi_cursor_quit_key='<Esc>'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:signify_vcs_list = [ 'git', 'hg' ]
nnoremap <silent> wg :SignifyToggle<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
set shiftround
set diffopt+=vertical,context:3,foldcolumn:0
set fileformats=unix,dos,mac
set formatoptions=croqn2mB1
set helplang=cn
set number
set hidden

set novisualbell
set noerrorbells
set t_vb=
au GUIEnter * set t_vb=
set viminfo='100,:10000,<50,s10,h
set history=10000
set completeopt=menu,longest
set completeopt-=previewwindow
" 组合字符一个个地删除
set delcombine

" 在其值为 single 时，若 encoding 为 utf-8，gvim 显示全角符号时就会出问题，会当作半角显示。
set ambiwidth=double

" 不设定的话在插入状态无法用退格键和Delete键删除回车符
set backspace=indent,eol,start

" 光标到达行尾或者行首时，特定键继续移动转至下一行或上一行
set whichwrap+=b,s,<,>,[,]

" 解决自动换行格式下, 如高度在折行之后超过窗口高度结果这一行看不到的问题
set display=lastline

" 显示tab,eol
set list
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,nbsp:~ "eol:$

set maxcombine=4
set winaltkeys=no

set nolinebreak             " 不在单词中间断行
set textwidth=200           " 在200个字符后，linebreak
set linebreak
set formatoptions+=mB       " :help fo-table

set cinoptions=g0,:0,N-s,(0
set smartindent
set autoindent
set cindent

set mps+=<:>        " 让<>可以使用%跳转
"set hid             " allow to change buffer without saving
set shortmess=atI   " shortens messages to avoid 'press a key' prompt
set lazyredraw      " do not redraw while executing macros (much faster)
" set synmaxcol=128

" Set Number format to null(default is octal,hex) , when press CTRL-A on number
" like 007, it would not become 010
set nrformats=hex

" In Visual Block Mode, cursor can be positioned where there is no actual character
set virtualedit=block

" Search related
set ignorecase  " Set search/replace pattern to ignore case
set smartcase   " Set smartcase mode on, If there is upper case character in the search patern, the 'ignorecase' option will be override.
"set showcmd     " display incomplete commands, 插件设置中存在
set incsearch   " do incremental searching
set hlsearch    " highlight search
set magic       " Enable magic matching
set showmatch
set wildmenu
" Ignore compiled files
set wildignore+=*.o,*~,*.pyc
set wildmode=longest:full,full
"set mouse=a     " 设定在任何模式下鼠标都可用
"set mousemodel=popup
set nobackup                " 覆盖文件时不备份
set writebackup             " 写备份但关闭vim后自动删除
set ignorecase              " 默认不区分大小写
set smartcase               " 在搜索词里面有大写时，区分大小写
set nostartofline
set nojoinspaces
"set nowrapscan             " 搜索不回绕,默认回绕
set wrap                    " 自动换行显示
set autochdir               " 自动切换当前目录为当前文件所在的目录
set autoread                " 自动读取改变了的编辑中的文件
set scrolljump=1            " 当光标达到上端或下端时 翻滚的行数
set sidescroll=5            " 当光标达到水平极端时 移动的列数
set scrolloff=5             " 当光标距离极端(上,下,左,右)多少时发生窗口滚
set clipboard+=unnamed      " 与Windows共享剪贴板
set diffopt=context:3       " 设置不同之处显示上下三行
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1
set switchbuf=usetab

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * <ESC>:execute '/'.GetVisualSelection()<CR>

" 重启后撤销历史可用 persistent undo
set undofile
set undodir=~/.vim/undodir/
set undolevels=1000 "maximum number of changes that can be undone

" Avoid command-line redraw on every entered character by turning off Arabic
" shaping (which is implemented poorly).
if has('arabic')
    set noarabicshape
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shiftwidth=4
set smarttab
set tabstop=4
set softtabstop=4
set expandtab
autocmd FileType make set noexpandtab

set path=.,/usr/include/,./include,../include,../../include,../../../include,../../../../include
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" when in insert mode, press <F5> to go to
" paste mode, where you can paste mass data that won't be autoindented
set pastetoggle=<F5>

" disbale paste mode when leaving insert mode
autocmd InsertLeave * set nopaste

" Fast switching between the last two files
nnoremap <leader><leader> <C-^>
nnoremap <Space> za
nmap ' <C-W>
nmap 'm :marks<CR>

" 清除行尾空白字符
nnoremap <F12> :%s/[ \t\r]\+$//g<CR>

nmap t= mxHmygg=G`yzt`x
nmap ta ggVG

" clean highlight for search
nmap <silent> <leader>n <ESC>:nohlsearch<CR>

" 选中状态下 Ctrl+c 复制
vnoremap <C-c> "+y
" Shift + Delete 插入系统剪切板中的内容
nnoremap <S-Del> "+p
inoremap <S-Del> <esc>"+pa
vnoremap <S-Del> d"+P

" Ctrl-Z 保存文件
nmap <silent> <C-Z> :update<CR>
imap <silent> <C-Z> <ESC>:update<CR>
vmap <silent> <C-Z> <ESC><ESC>:update<CR>
" nmap <C-D> <C-W>q
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

" 上下移动一行文字
nmap <C-j> mz:m+<cr>`z
nmap <C-k> mz:m-2<cr>`z
vmap <C-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <C-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Quickfix and errors
nmap <M-up> :lprev<cr>
nmap <M-down> :lnext<cr>
nmap <M-Left> :ll<cr>
nmap <M-Right> :Errors<cr>
map <silent> <F8> <ESC>:if exists("g:qfix_win")\|ccl\|else\|cope\|endif<Cr>|map! <F8> <C-o><F8>
nmap <C-Up> :cprevious<CR><CR>
nmap <C-Down> :cnext<CR><CR>
nmap <C-right> :bnext<CR><CR>
nmap <C-left> :bprevious<CR><CR>

let mapleader=","
let g:mapleader=","
noremap \ ,

" easier moving of code blocks
vnoremap < <gv
vnoremap > >gv

" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h

" Remove the Windows ^M - when the encodings gets messed up
nmap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
map q: :q
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   设置成 Linux 下适用的格式
command! Lin setl ff=unix fenc=utf8 nobomb eol
"   设置成 Windows 下适用的格式
command! Win setl ff=dos fenc=gb18030 nobomb eol

command! Tab8 set tabstop=8 shiftwidth=8 softtabstop=8 noexpandtab
command! Tab4 set tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
command! Tab2 set tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <leader>er :e $HOME/.vimrc<CR>

autocmd! BufWritePost $HOME/.vimrc source $HOME/.vimrc

" Restore the last quit position when open file.
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \     exe "normal g'\"" |
            \ endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Delete trailing white space on save, useful for Python and CoffeeScript ;)
function! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunction

autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! SetColorColumn()
    let col_num = virtcol(".")
    let cc_list = split(&cc, ',')
    if count(cc_list, string(col_num)) <= 0
        execute "set cc+=".col_num
    else
        execute "set cc-=".col_num
    endif
endfunction

nmap <leader>ch :call SetColorColumn()<CR>

set colorcolumn=80
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle Menu and Toolbar
if has("gui_running")
    set guioptions-=m       " 隐藏菜单栏
    set guioptions-=T        " 隐藏工具栏
    set guioptions-=L       " 隐藏左侧滚动条
    set guioptions-=r       " 隐藏右侧滚动条
    "set guioptions-=b       " 隐藏底部滚动条
    "set showtabline=0       " 隐藏Tab栏
endif
map <silent> <c-s-F2> :if &guioptions =~# 'T' <Bar>
            \set guioptions-=T <Bar>
            \set guioptions-=m <bar>
            \else <Bar>
            \set guioptions+=T <Bar>
            \set guioptions+=m <Bar>
            \endif<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 最大化窗口
" windows add -- GUIEnter * simalt ~x
" gnome or other DE, install wmctrl
" add to .zshrc or .bashrc -- alias gvim='gvim -c "call Maximize_Window()"'
function! Maximize_Window()
    silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunction
nmap <F11> :call Maximize_Window()<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256   " Explicitly tell vim that the terminal supports 256 colors,
set cursorline
set background=dark
colorscheme molokai
set ruler                  " 打开状态栏标尺
set laststatus=2           " 显示状态栏 (默认值为 1, 无法显示状态栏)
set showcmd   " 在状态栏显示目前所执行的指令，未完成的指令片段亦会显示出来
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" 如果需要使用菜单，uncomment下面2-3两行
set langmenu=zh_CN.UTF-8            "设置菜单语言
" source $VIMRUNTIME/delmenu.vim      "导入删除菜单脚本，删除乱码的菜单
" source $VIMRUNTIME/menu.vim         "导入正常的菜单脚本
language messages zh_CN.utf-8       "设置提示信息语言

