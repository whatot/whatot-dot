if 0 | endif  " Note: Skip initialization for vim-tiny or vim-small
set fileencodings=utf-8,gb18030,utf-16le,gbk,gb2312,latin1
set nocompatible

call plug#begin(expand('~/.vim/plugged'))

Plug 'Shougo/vimproc.vim', { 'do': 'make' }
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'Valloric/YouCompleteMe', { 'do': 'python2 ./install.py --clang-completer --system-libclang --system-boost --gocode-completer' }
nmap gd :YcmCompleter GoTo<CR>
nmap gy :YcmDiags<CR>
nmap gt :YcmCompleter GetType<CR>
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_complete_in_comments_and_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
" let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>']
" let g:ycm_add_preview_to_completeopt = 1
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_filetype_whitelist = { 'c': 1, 'cpp': 1, 'vim': 1, 'python':1, 'go':1 }
let g:ycm_filetype_specific_completion_to_disable = { 'gitcommit': 1 }
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<c-l>"
" let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'mileszs/ack.vim'
let g:ackprg = 'ag --nogroup --nocolor --column'
" https://github.com/ggreer/the_silver_searcher
" debian silversearcher-ag, others the_silver_searcher
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':p:t'  " filename too long
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#csv#enabled = 1
let g:airline_powerline_fonts=0
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'w0rp/ale'
" let g:ale_lint_on_save = 1
" let g:ale_lint_on_text_changed = 0
" let g:ale_lint_on_enter = 0
" I already wrap LocationList and Quickfix, so below is not needed
" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" nmap <silent> <C-j> <Plug>(ale_next_wrap)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'jiangmiao/auto-pairs'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'whatot/molokai'
Plug 'vim-scripts/FencView.vim'
Plug 'lilydjwg/fcitx.vim'
Plug 'whatot/gtags-cscope.vim'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'amix/vim-zenroom2'
Plug 'junegunn/goyo.vim'
nnoremap <silent> <leader>z :Goyo<cr>
let g:goyo_width = 80
let g:goyo_margin_top = 4
let g:goyo_margin_bottom = 4
let g:goyo_linenr = 0
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'sjl/gundo.vim'
noremap <leader>gd :GundoToggle<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'Yggdroot/indentLine'
Plug 'vim-scripts/L9'
Plug 'vim-scripts/LargeFile'
""编辑大文件,g:LargeFile设置最小值
Plug 'dkasak/manpageview'
Plug 'vim-scripts/matchit.zip'
Plug 'vimcn/matchit.vim.cnx'
" 对%命令进行扩展使得能在嵌套标签和语句之间跳转
" % 正向匹配      g% 反向匹配
" [% 定位块首     ]% 定位块尾
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'vim-scripts/The-NERD-Commenter'
Plug 'vimcn/NERD_commenter.cnx'
"[default],cc;,cu注释与取消注释快速切换
let NERDSpaceDelims = 1                   " 让注释符与语句之间留一个空格
let NERDCompactSexyComs = 1               " 多行注释时样子更好看
let NERD_c_alt_style = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
let NERDTreeIgnore=['\.d$[[dir]]', '\.o$[[file]]', '\.swp$[[file]]']
Plug 'tyok/nerdtree-ack', { 'on':  'NERDTreeToggle' }
Plug 'jistr/vim-nerdtree-tabs', { 'on':  'NERDTreeToggle' }
" nnoremap <silent> wf :NERDTreeToggle<CR>
" nnoremap <silent> wa :NERDTreeTabsToggle<CR>
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
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'pelodelfuego/vim-swoop'
" nmap <Leader>l :call Swoop()<CR>
" vmap <Leader>l :call SwoopSelection()<CR>
" nmap <Leader>ml :call SwoopMulti()<CR>
" vmap <Leader>ml :call SwoopMultiSelection()<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'majutsushi/tagbar'
Plug 'vimcn/tagbar.cnx'
nnoremap <silent> wt :TagbarToggle<CR>
let g:tagbar_width = 40
let g:tagbar_expand = 0  " 0向内拓展 - 1向外拓展
let g:tagbar_left = 1
" autocmd FileType c,cpp nested :TagbarOpen  " 默认开启tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'vim-scripts/tag_in_new_tab'
" Shift-Enter in normal mode opens a definition of identifier under cursor in a new tab. Uses tag files (see :help tags)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-outline'
Plug 'Shougo/neomru.vim'
Plug 'lambdalisue/unite-grep-vcs'
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
" 中文文档
Plug 'asins/vimcdoc'
Plug 'hsitz/VimOrganizer'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'Lokaltog/vim-easymotion'
let EasyMotion_leader_key = '<leader><leader>'
let EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'terryma/vim-expand-region'
"for visual selection
map + <Plug>(expand_region_expand)
map - <Plug>(expand_region_shrink)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'nvie/vim-flake8', { 'for': 'python' }
Plug 'tpope/vim-fugitive'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'terryma/vim-multiple-cursors'
" let g:multi_cursor_use_default_mapping=0
" " Default mapping
" let g:multi_cursor_next_key='<C-n>'
" let g:multi_cursor_prev_key='<C-p>'
" let g:multi_cursor_skip_key='<C-x>'
" let g:multi_cursor_quit_key='<Esc>'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
let g:session_autoload = 'no'
let g:session_directory = '~/.vim/sessions/'
let g:session_default_name = 'default'
let g:session_persist_colors = 0  " don't save colorscheme and bg
let g:session_autosave = 'yes'
let g:session_autosave_periodic = 5
set sessionoptions=buffers,sesdir,folds,tabpages,winsize,resize
" Don't persist options and mappings because it can corrupt sessions.
set sessionoptions-=options,localoptions,blank,help
nmap <F3> :SaveSession!<space>
nmap <C-F3> :OpenSession!<space>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'mhinz/vim-signify'
let g:signify_vcs_list = [ 'git', 'hg' ]
nnoremap <silent> wg :SignifyToggle<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'bronson/vim-trailing-whitespace'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add plugins to &runtimepath
call plug#end()
filetype plugin indent on
syntax on
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set font based on hostname()
if hostname() == 'b150'
    set guifont=Source\ Code\ Pro\ 11
elseif hostname() == 'x411'
    set guifont=Source\ Code\ Pro\ 13
else
    set guifont=Source\ Code\ Pro\ 13
endif

set shiftround
set diffopt+=vertical,context:3,foldcolumn:0
set fileformats=unix,dos,mac
set formatoptions=croqn2mB1
"set formatoptions=tcqro     " 使得注释换行时自动加上前导的空格和星号
set helplang=cn
set number
"set relativenumber
set hidden

" 不要响铃，更不要闪屏
set novisualbell  " 不要闪烁
set noerrorbells  " 关闭遇到错误时的声音提示
set t_vb=
au GUIEnter * set t_vb=
set viminfo='100,:10000,<50,s10,h
set history=10000

" for completer
set completeopt=menu,longest
set completeopt-=previewwindow

set delcombine              " 组合字符一个个地删除

" ambiwidth 默认值为 single。
" 在其值为 single 时，若 encoding 为 utf-8，gvim 显示全角符号时就会出问题，会当作半角显示。
set ambiwidth=double

" 不设定的话在插入状态无法用退格键和Delete键删除回车符
set backspace=indent,eol,start

" 光标到达行尾或者行首时，特定键继续移动转至下一行或上一行
set whichwrap+=b,s,<,>,[,]

" 解决自动换行格式下, 如高度在折行之后超过窗口高度结果这一行看不到的问题
set display=lastline

set list "显示tab,eol
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,nbsp:~ "eol:$

set maxcombine=4
set winaltkeys=no

" Format related
set nolinebreak             " 不在单词中间断行
set textwidth=200           " 在200个字符后，linebreak
set linebreak
set formatoptions+=mB       " :help fo-table

" Indent related
" http://vimcdoc.sourceforge.net/doc/indent.html
" g0 类的public顶格写
" :0 将 case 标号放在 switch() 缩进位置之后的 N 个字符处
" N-s namespace 下顶格
" (0  条件语句多个条件在不同行时下一行与上一行对齐
set cinoptions=g0,:0,N-s,(0
set smartindent
set autoindent  " always set autoindenting on

" C-style indentdenting
" usage: select codes, press '=' key, the codes whichwrapill autoindenting
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

" Tab related
set shiftwidth=4
set smarttab
set tabstop=4
set softtabstop=4
set expandtab

set path=.,/usr/include/,./include,../include,../../include,../../../include,../../../../include

autocmd FileType make set noexpandtab
autocmd FileType puppet set tabstop=4 shiftwidth=4 softtabstop=4 expandtab

" add for the ~/linux which contains the linux kernel src,
" So tabstop, shiftwidth, softtabstop = 8 and noexpandtab are needed
" :echo stridx(expand("~/linux/:p"), "linux") == strlen(expand("~/"))
" 1 means the file in dir "~/linux/", 0 means no.
" (username should include the "linux" string.)
let homestr_len = strlen(expand("~/"))
autocmd BufRead *.[ch] if stridx(expand("%:p"), "linux") == homestr_len |
            \ set tabstop=8 shiftwidth=8 softtabstop=8 noexpandtab |
            \ set path=.,~/linux/include/ |
            \ set path+=~/linux/include/uapi/ |
            \ set path+=~/linux/include/asm-generic/ |
            \ set path+=~/linux/arch/x86/include |
            \ set path+=~/linux/arch/x86/include/generated |
            \ set path+=~/linux/arch/x86/include/uapi |
            \ set path+=~/linux/arch/x86/include/generated/uapi | endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set pastetoggle=<F5> " when in insert mode, press <F5> to go to
" paste mode, where you can paste mass data that won't be autoindented

" disbale paste mode when leaving insert mode
autocmd InsertLeave * set nopaste

" Fast switching between the last two files
nnoremap <leader><leader> <C-^>
nnoremap <Space> za
nmap ' <C-W>
nmap 'm :marks<CR>

nnoremap <F12> :%s/[ \t\r]\+$//g<CR>

nmap t= mxHmygg=G`yzt`x
nmap ta ggVG

" 清除高亮
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  mapleader
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"设置自定义的<leader>快捷键
let mapleader=","
let g:mapleader=","
noremap \ ,

" easier moving of code blocks
vnoremap < <gv
vnoremap > >gv

" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h

nmap <C-t><C-t> :tabnew<CR>
"nmap <C-t><C-d> :tabedit <c-r>=expand("%:p:h")<cr>/
nmap <C-t><C-w> :tabclose<CR>
"nmap <C-t><C-m> :tabmove
" :tabn[ext] {count} ----> <C-PageDown> {count} ----> gt
" :tabp[revious] {count} ----> <C-PageUp> {count} ----> gT
set guitablabel=%N\ %t\ %m            "标签栏显示标签页号,文件名,页号

" Remove the Windows ^M - when the encodings gets messed up
nmap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

iab xdate <c-r>=strftime("%Y%m%d %H:%M:%S")<cr>
map q: :q

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  自定义命令
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"   设置成 Linux 下适用的格式
command! Lin setl ff=unix fenc=utf8 nobomb eol
"   设置成 Windows 下适用的格式
command! Win setl ff=dos fenc=gb18030 nobomb eol

command! Tab8 set tabstop=8 shiftwidth=8 softtabstop=8 noexpandtab
command! Tab4 set tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
command! Tab2 set tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  自动执行命令,与函数
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <leader>er :e $HOME/.vimrc<CR>

autocmd! BufWritePost $HOME/.vimrc source $HOME/.vimrc        " vimrc编辑后重载

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
function! AutoLoadCTagsAndCScope()
    let max = 10
    let dir = expand("%:p:h") . '/'
    let i = 0
    let break = 0
    while isdirectory(dir) && i < max
        if filereadable(dir . 'GTAGS')
            execute 'lcd ' . dir
            execute 'cs add ' . dir . 'GTAGS ' . dir . ' -a'
            let break = 1
        endif
        if filereadable(dir . 'cscope.out')
            execute 'cs add ' . dir . 'cscope.out'
            let break = 1
        endif
        if filereadable(dir . 'tags')
            execute 'set tags =' . dir . 'tags'
            let break = 1
        endif
        if break == 1
            execute 'lcd ' . dir
            break
        endif
        let dir = dir . '../'
        let i = i + 1
    endwhile
endfunction
nmap <F7> :call AutoLoadCTagsAndCScope()<CR>
" call AutoLoadCTagsAndCScope()
" http://vifix.cn/blog/vim-auto-load-ctags-and-cscope.html

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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设置命令行和状态栏
set ruler                  " 打开状态栏标尺
"set cmdheight=1            " 设定命令行的行数为 1
set laststatus=2           " 显示状态栏 (默认值为 1, 无法显示状态栏)
set showcmd   " 在状态栏显示目前所执行的指令，未完成的指令片段亦会显示出来
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -- cscope --
let g:autocscope_menus=0
" 设定是否使用 quickfix 窗口来显示 cscope 结果
" set cscopequickfix=s-,c-,d-,i-,t-,e-
set cscopequickfix=c-,d-,e-,f-,g0,i-,s-,t-

"设定了 'cscopetag'，这样所有的 :tag 命令就会实际上调用 :cstag。这包括 :tag、Ctrl-] 及 vim -t。
"结果是一般的 tag 命令不仅搜索由 ctags 产生的标签文 件，同时也搜索 cscope 数据库,但是好像有bug,二者共存时有的无法搜索

set cscopeprg=gtags-cscope
" Use both cscope and ctag
set cscopetag
" Show msg when cscope db added
set cscopeverbose
" 'csto','cscopetagorder' 被设为 0，cscope数据库先被搜索，搜索失败的情况下在搜索标签文件
set cscopetagorder=0

nnoremap <C-Space>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-Space>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-Space>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-Space>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-Space>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nnoremap <C-Space>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
vnoremap <C-Space>g <ESC>:execute 'cscope find g '.GetVisualSelection()<CR>
vnoremap <C-Space>s <ESC>:execute 'cscope find s '.GetVisualSelection()<CR>
vnoremap <C-Space>c <ESC>:execute 'cscope find c '.GetVisualSelection()<CR>
vnoremap <C-Space>t <ESC>:execute 'cscope find t '.GetVisualSelection()<CR>
vnoremap <C-Space>f <ESC>:execute 'cscope find f '.GetVisualSelection()<CR>
vnoremap <C-Space>i <ESC>:execute 'cscope find i '.GetVisualSelection()<CR>

function! GetVisualSelection()
    let [s:lnum1, s:col1] = getpos("'<")[1:2]
    let [s:lnum2, s:col2] = getpos("'>")[1:2]
    let s:lines = getline(s:lnum1, s:lnum2)
    let s:lines[-1] = s:lines[-1][: s:col2 - (&selection == 'inclusive' ? 1 : 2)]
    let s:lines[0] = s:lines[0][s:col1 - 1:]
    return join(s:lines, ' ')
endfunction

" 解决cscope与tag共存时ctrl+]有时不正常的bug
nmap <C-]> :tj <C-R>=expand("<cword>")<CR><CR>

" 0 或 s: 查找本 C 符号
" 1 或 g: 查找本定义
" 2 或 d: 查找本函数调用的函数
" 3 或 c: 查找调用指定函数的函数
" 4 或 t: 查找字符串
" 6 或 e: 查找本 egrep 模式
" 7 或 f: 查找本文件
" 8 或 i: 查找包含本文件的文件

autocmd BufWritePost *.[ch] call UpdateGtags(expand('<afile>'))

function! UpdateGtags(f)
    let dir = fnamemodify(a:f, ':p:h')
    exe 'silent !cd ' . dir . ' && global -u &> /dev/null &'
endfunction

" fix 无法正常加载中文菜单
set langmenu=zh_CN.UTF-8            "设置菜单语言
source $VIMRUNTIME/delmenu.vim      "导入删除菜单脚本，删除乱码的菜单
source $VIMRUNTIME/menu.vim         "导入正常的菜单脚本
language messages zh_CN.utf-8       "设置提示信息语言


