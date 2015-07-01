set fileencodings=utf-8,gb18030,gbk,gb2312,latin1
set encoding=utf-8
"let &termencoding=&encoding

filetype off                  " required!

call plug#begin('~/.vim/plugged')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug start
" https://github.com/junegunn/vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer --system-libclang' }
nmap yg :YcmCompleter GoTo<CR>
nmap yd :YcmDiags<CR>
nmap yt :YcmCompleter GetType<CR>
let g:syntastic_c_checkers = ['YouCompleteMe']
let g:syntastic_c_check_header = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_extra_conf_globlist = ['~/git/*', '~/works/*','!~/*']
let g:ycm_complete_in_comments_and_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
" let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>']
" let g:ycm_add_preview_to_completeopt = 1
" let g:ycm_autoclose_preview_window_after_completion = 1
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
Plug 'bling/vim-airline'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':p:t'  " filename too long
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#csv#enabled = 1
let g:airline_powerline_fonts=1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'vim-scripts/a.vim'
"设置include(.h)文件存在何处.
let alternateSearchPath = 'sfr:.,sfr:./include,sfr:../include,sfr:../inc'
"当没有找到相应的.h文件时,不自动创建
let alternateNoDefaultAlternate = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'jiangmiao/auto-pairs'
" Plug 'autoload_cscope.vim'
Plug 'vim-scripts/bash-support.vim'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'vim-scripts/bufexplorer.zip'
noremap <silent> <F10> :BufExplorer<CR>
noremap <silent> <m-F10> :BufExplorerHorizontalSplit<CR>
noremap <silent> <c-F10> :BufExplorerVerticalSplit<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug 'chrisbra/csv.vim'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug 'hari-rangarajan/CCTree'
Plug 'vim-scripts/Colour-Sampler-Pack'
Plug 'vim-scripts/FencView.vim'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'vim-scripts/grep.vim'
let g:Grep_Default_Options = '--binary-files=without-match'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'whatot/gtags-cscope.vim'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug 'amix/vim-zenroom2'
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
Plug 'vim-scripts/L9'
Plug 'vim-scripts/LargeFile'
""编辑大文件,g:LargeFile设置最小值
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
Plug 'scrooloose/nerdtree'
let NERDTreeIgnore=['.d$[[dir]]', '.o$[[file]]']

Plug 'tyok/nerdtree-ack'
Plug 'jistr/vim-nerdtree-tabs'
" nnoremap <silent> wf :NERDTreeToggle<CR>
nnoremap <silent> wa :NERDTreeTabsToggle<CR>
nnoremap <silent> wf :NERDTreeMirrorToggle<CR>
nnoremap <silent> we :exec("NERDTree ".expand('%:h'))<CR>
let g:NERDChristmasTree = 1               " 色彩显示
let g:NERDTreNERDShowHidden = 1           " 显示隐藏文件
let g:NERDTreeWinPos = 'left'             " 窗口显示位置
let g:NERDTreeHighlightCursorline = 0     " 高亮当前行
let g:NERDTreeWinSize = 30                " 设置显示宽度
let NERDTreeChDirMode = 2
let NERDTreeShowBookmarks = 0
let g:nerdtree_tabs_open_on_gui_startup = 0
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'rust-lang/rust.vim'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'vim-scripts/STL-improved'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'scrooloose/syntastic'
let g:syntastic_check_on_open = 1
let g:syntastic_python_checkers = ['flake8']
" let g:syntastic_c_checkers = ['make']
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_loc_list_height = 8
let g:syntastic_enable_highlighting = 1
let g:syntastic_ignore_files=['^/usr/include/', '\c\.xml$', '\c\.txt$', '\c\.cnx$']
let g:syntastic_c_compiler_options = '-std=c11 -pedantic -Wall -Wextra -Wfloat-equal -ftrapv'
let g:syntastic_cpp_compiler_options = '-std=c++11 -pedantic -Wall -Wextra -Weffc++'
nmap <M-up> :lprev<cr>
nmap <M-down> :lnext<cr>
nmap <M-Left> :ll<cr>
nmap <M-Right> :Errors<cr>
" Quickfix and errors
map <silent> <F8> <ESC>:if exists("g:qfix_win")\|ccl\|else\|cope\|endif<Cr>|map! <F8> <C-o><F8>
nmap <C-Up> :cp<Cr>
nmap <C-Down> :cn<Cr>
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
Plug 'vim-scripts/TaskList.vim'
" <leader>t
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-outline'
Plug 'Shougo/neomru.vim'
" Plug 'hewes/unite-gtags'
" Plug 'osyo-manga/unite-quickfix'
" Plug 'tsukkee/unite-tag'
" Plug 'Shougo/unite-help'
" http://bling.github.io/blog/2013/06/02/unite-dot-vim-the-plugin-you-didnt-know-you-need/
let g:unite_source_rec_max_cache_files = 2000
let g:unite_source_find_max_candidates = 2000
let g:unite_source_history_yank_enable = 1
let g:unite_enable_start_insert = 1
let g:unite_enable_short_source_names = 1
let g:unite_source_rec_async_command =
    \ 'ag --follow --nocolor --nogroup --hidden -g ""'
nnoremap sp :execute 'Unite' 'file_rec/async:'.unite#util#path2project_directory(getcwd())<CR>
" nnoremap <leader>r :<C-u>Unite -start-insert <CR>
nnoremap sm :<C-u>Unite file_mru<CR>
nnoremap sa :<C-u>Unite mapping<CR>
" nnoremap s/ :<C-u>Unite -start-insert grep:.<cr>
nnoremap s/ :execute 'Unite' 'grep:'.unite#util#path2project_directory(getcwd())<CR>
nnoremap sy :Unite history/yank<cr>
" nnoremap ss :Unite -quick-match buffer<cr>
nnoremap ss :Unite -start-insert buffer<cr>
" nnoremap sf :<C-u>Unite -buffer-name=resume resume<CR>
" nnoremap sd :<C-u>Unite -buffer-name=files -default-action=lcd directory_mru<CR>
nnoremap so :<C-u>Unite outline<CR>
" nnoremap sh :<C-u>Unite help<CR>
" Unite-gtags
" nnoremap <leader>gg :execute 'Unite gtags/def:'.expand('<cword>')<CR>
" nnoremap <leader>gc :execute 'Unite gtags/context'<CR>
" nnoremap <leader>gr :execute 'Unite gtags/ref'<CR>
" nnoremap <leader>ge :execute 'Unite gtags/grep'<CR>
" vnoremap <leader>gg <ESC>:execute 'Unite gtags/def:'.GetVisualSelection()<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'Shougo/vimproc', { 'do': 'make' }
" $ cd ~/.vim/plugged/vimproc.vim
" $ make
Plug 'Shougo/vimfiler.vim'
Plug 'Shougo/vimshell.vim'
let g:vimshell_prompt_expr =
			\ 'escape(fnamemodify(getcwd(), ":~").">", "\\[]()?! ")." "'
let g:vimshell_prompt_pattern = '^\%(\f\|\\.\)\+> '
let g:vimshell_use_terminal_command = 'gnome-terminal -e'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 中文文档
Plug 'asins/vimcdoc'
Plug 'hsitz/VimOrganizer'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'octol/vim-cpp-enhanced-highlight'
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
Plug 'nvie/vim-flake8'
Plug 'tpope/vim-fugitive'
Plug 'plasticboy/vim-markdown'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'terryma/vim-multiple-cursors'
" let g:multi_cursor_use_default_mapping=0
" " Default mapping
" let g:multi_cursor_next_key='<C-n>'
" let g:multi_cursor_prev_key='<C-p>'
" let g:multi_cursor_skip_key='<C-x>'
" let g:multi_cursor_quit_key='<Esc>'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug 'hynek/vim-python-pep8-indent'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'xolox/vim-session'
Plug 'vim-misc'
let g:session_directory = '~/.vim/sessions/'
let g:session_default_name = 'default'
let g:session_persist_colors = 0  " don't save colorscheme and bg
let g:session_autosave = 'yes'
let g:session_autosave_periodic = 5
set sessionoptions=blank,buffers,sesdir,folds,tabpages,winsize,resize
" Don't persist options and mappings because it can corrupt sessions.
set sessionoptions-=options,localoptions
nmap <F3> :SaveSession!<space>
nmap <C-F3> :OpenSession!<space>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'mhinz/vim-signify'
let g:signify_vcs_list = [ 'git', 'hg' ]
let g:signify_update_on_bufenter = 0
let g:signify_cursorhold_normal = 0
let g:signify_cursorhold_insert = 0
let g:signify_line_highlight = 0
let g:signify_disable_by_default = 0
nmap wg <Plug>(signify-toggle)
" default
nmap <leader>gj <plug>(signify-next-jump)
nmap <leader>gk <plug>(signify-prev-jump)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#end()
filetype plugin indent on   " required!
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug end
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on

"set guifont=Droid\ Sans\ Mono\ 13
set guifont=Source\ Code\ Pro\ for\ Powerline\ 12
set shiftround
set diffopt+=vertical,context:3,foldcolumn:0
set fileformats=unix,dos,mac
set formatoptions=croqn2mB1
"set formatoptions=tcqro     " 使得注释换行时自动加上前导的空格和星号
set helplang=cn
set number
"set relativenumber

" 不要响铃，更不要闪屏
set novisualbell  " 不要闪烁
set noerrorbells  " 关闭遇到错误时的声音提示
set t_vb=
au GUIEnter * set t_vb=
set viminfo='100,:10000,<50,s10,h
set history=10000


if v:version >= 700
    set completeopt=menu,longest  ",preview
    set completeopt-=previewwindow
                            " 自动补全(ctrl-p)时的一些选项：
                            " 多于一项时显示菜单，最长选择，
                            " 显示当前选择的额外信息
endif

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
set tw=200                  " 在200个字符后，linebreak
set lbr
set fo+=mB

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

" Set Number format to null(default is octal) , when press CTRL-A on number
" like 007, it would not become 010
set nf=

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
set mousemodel=popup
set nobackup                " 覆盖文件时不备份
set writebackup             " 写备份但关闭vim后自动删除
set nocompatible            " 设定 gvim 运行在增强模式下
set ignorecase              " 默认不区分大小写
set smartcase               " 在搜索词里面有大写时，区分大小写
set nostartofline
set nojoinspaces
"set nowrapscan             " 搜索不回绕,默认回绕
set wrap                    " 自动换行显示
" set autochdir               " 自动切换当前目录为当前文件所在的目录
" autochdir don't work with vimfiler
set autoread                " 自动读取改变了的编辑中的文件
set scrolljump=1            " 当光标达到上端或下端时 翻滚的行数
set sidescroll=5            " 当光标达到水平极端时 移动的列数
set scrolloff=5             " 当光标距离极端(上,下,左,右)多少时发生窗口滚
set clipboard+=unnamed      " 与Windows共享剪贴板
set diffopt=context:3       " 设置不同之处显示上下三行
set foldmethod=indent
set foldlevel+=15           " 设置较大的foldlevel使得所有折叠被默认展开
                            " zr/zm zR/zM zc/zo zC/zO zd/zD [z ]z zj/zk
set switchbuf=usetab        " 如果包含，跳到第一个打开的包含指定缓冲区的窗口,
                            " 也考虑其它标签页里的窗口

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

set tags=tags
" set tags+=./../tags,./../../tags,./../../../tags

" Tab related
set shiftwidth=4
set smarttab
set tabstop=4
set softtabstop=4
set noexpandtab

set path=.,/usr/include/,./include,../include,../../include,../../../include,../../../../include

autocmd FileType c set tabstop=4 shiftwidth=4 noexpandtab
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab

" add for the ~/linux which contains the linux kernel src,
" So tabstop, shiftwidth, softtabstop = 8 and noexpandtab are needed
" :echo stridx(expand("~/linux/:p"), "linux") == strlen(expand("~/"))
" 1 means the file in dir "~/linux/", 0 means no.
" (username should include the "linux" string.)
let homestr_len = strlen(expand("~/"))
autocmd BufRead *.[ch] if stridx(expand("%:p"), "linux") == homestr_len |
    \ set tabstop=8 shiftwidth=8 softtabstop=8 noexpandtab |
    \ let g:syntastic_check_on_open = 0 |
    \ let g:syntastic_check_on_wq = 0 |
    \ let b:syntastic_checkers = [''] |
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

nnoremap <Space> za
nmap ' <C-W>
nmap 'm :marks<CR>
" nmap gb :setl fenc=gb18030<CR>

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  mapleader
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"设置自定义的<leader>快捷键
let mapleader=","
let g:mapleader=","
noremap \ ,

map <C-right> <ESC>:bnext<CR>
map <C-left> <ESC>:bprevious<CR>

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

nmap <silent> <leader>er :e ~/.vimrc<CR>
" nmap <Leader>cr :!cscope -Rbq<CR>
" nmap <Leader>ct :!ctags -R --c++-kinds=+px --fields=+ilaS --extra=+q `pwd`<CR>


" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  自动执行命令,与函数
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd! BufWritePost .vimrc source $HOME/.vimrc    " .vimrc编辑后重载

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

set cc=80

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
            execute 'cs add ' . dir . 'GTAGS ' . dir
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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set t_Co=256   " Explicitly tell vim that the terminal supports 256 colors,

" set background=dark
" let colorscheme = 'desert'

if has('gui_running')
	set background=light
	let colorscheme = 'solarized'
else
	set background=dark
	let colorscheme = 'desert'
endif


" 图形与终端
if has("gui_running")
    " 有些终端不能改变大小
    " set columns=88
    " set lines=33
    set cursorline
    exe 'colorscheme' colorscheme
elseif has("unix")
    set ambiwidth=single
    " 防止退出时终端乱码
    " 这里两者都需要。只前者标题会重复，只后者会乱码
    set t_fs=(B
    set t_IE=(B
    if &term =~ "256color"
        set cursorline
        exe 'colorscheme' colorscheme
    else
        " 在Linux文本终端下非插入模式显示块状光标
        if &term == "linux" || &term == "fbterm"
            set t_ve+=[?6c
            autocmd InsertEnter * set t_ve-=[?6c
            autocmd InsertLeave * set t_ve+=[?6c
            " autocmd VimLeave * set t_ve-=[?6c
        endif
        if &term == "fbterm"
            set cursorline
            exe 'colorscheme' colorscheme
        elseif $TERMCAP =~ 'Co#256'
            set t_Co=256
            set cursorline
            exe 'colorscheme' colorscheme
        else
            " 暂时只有这个配色比较适合了
            colorscheme default
            " 在终端下自动加载vimim输入法
            runtime so/vimim.vim
        endif
    endif
    " 在不同模式下使用不同颜色的光标
    " 不要在 ssh 下使用
    if &term =~ "256color" && !exists('$SSH_TTY')
        let color_normal = 'HotPink'
        let color_insert = 'RoyalBlue1'
        let color_exit = 'green'
        if &term =~ 'xterm\|rxvt'
            exe 'silent !echo -ne "\e]12;"' . shellescape(color_normal, 1) . '"\007"'
            let &t_SI="\e]12;" . color_insert . "\007"
            let &t_EI="\e]12;" . color_normal . "\007"
            exe 'autocmd VimLeave * :silent !echo -ne "\e]12;"' . shellescape(color_exit, 1) . '"\007"'
        elseif &term =~ "screen"
            if exists('$TMUX')
                if &ttymouse == 'xterm'
                    set ttymouse=xterm2
                endif
                exe 'silent !echo -ne "\033Ptmux;\033\e]12;"' . shellescape(color_normal, 1) . '"\007\033\\"'
                let &t_SI="\033Ptmux;\033\e]12;" . color_insert . "\007\033\\"
                let &t_EI="\033Ptmux;\033\e]12;" . color_normal . "\007\033\\"
                exe 'autocmd VimLeave * :silent !echo -ne "\033Ptmux;\033\e]12;"' . shellescape(color_exit, 1) . '"\007\033\\"'
            elseif !exists('$SUDO_UID') " or it may still be in tmux
                exe 'silent !echo -ne "\033P\e]12;"' . shellescape(color_normal, 1) . '"\007\033\\"'
                let &t_SI="\033P\e]12;" . color_insert . "\007\033\\"
                let &t_EI="\033P\e]12;" . color_normal . "\007\033\\"
                exe 'autocmd VimLeave * :silent !echo -ne "\033P\e]12;"' . shellescape(color_exit, 1) . '"\007\033\\"'
            endif
        endif
        unlet color_normal
        unlet color_insert
        unlet color_exit
    endif
endif

" 设置命令行和状态栏
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ruler                  " 打开状态栏标尺
"set cmdheight=1            " 设定命令行的行数为 1
set laststatus=2           " 显示状态栏 (默认值为 1, 无法显示状态栏)
set showcmd   " 在状态栏显示目前所执行的指令，未完成的指令片段亦会显示出来

" %F    当前文件名
" %m    当前文件修改状态
" %r    当前文件是否只读
" %Y    当前文件类型
" %b    当前光标处字符的 ASCII 码值
" %B    当前光标处字符的十六进制值
" %l    当前光标行号
" %c    当前光标列号
" %V    当前光标虚拟列号 (根据字符所占字节数计算)
" %p    当前行占总行数的百分比
" %%    百分号
" %L    当前文件总行数

" set statusline=%n\ %t%m%r%h%w\ %{&ff}\ %Y\ [%{(&fenc\ ==\ \"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]\ %{SyntasticStatuslineFlag()}\ %=%l/%L,%v\ %p%%

" hi User1 guifg=#eea040 guibg=#222222 ctermfg=6 ctermbg=0
" hi User2 guifg=#dd3333 guibg=#222222 ctermfg=5 ctermbg=0
" hi User3 guifg=#ff66ff guibg=#222222 ctermfg=4 ctermbg=0
" hi User4 guifg=#a0ee40 guibg=#222222 ctermfg=1 ctermbg=0
" hi User5 guifg=#eeee40 guibg=#222222 ctermfg=2 ctermbg=0

" set statusline=
" set statusline +=%1*\ %n\ %*            "buffer number
" set statusline +=%4*\ %t%m%r%h%w\ %*    "file name
" set statusline +=%3*%Y\ %*              "file type
" set statusline +=%5*[%{&ff}]\ %*        "file format
" set statusline +=%3*%{''.(&fenc!=''?&fenc:&enc).''}\ %*
" set statusline +=%3*\%{(&bomb?\",BOM\":\"\")}\ %*
" set statusline +=%2*\ %{SyntasticStatuslineFlag()}%*
" set statusline +=%1*%=%5l%*             "current line
" set statusline +=%2*/%L%*               "total lines
" set statusline +=%1*%4v\ %*             "virtual column number
" set statusline +=%2*0x%04B\ %*          "character under cursor

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

nnoremap <C-_>g :execute 'cscope find g '.expand('<cword>')<CR>
nnoremap <C-_>s :execute 'cscope find s '.expand('<cword>')<CR>
nnoremap <C-_>c :execute 'cscope find c '.expand('<cword>')<CR>
nnoremap <C-_>t :execute 'cscope find t '.expand('<cword>')<CR>
nnoremap <C-_>f :execute 'cscope find f '.expand('<cword>')<CR>
nnoremap <C-_>i :execute 'cscope find i '.expand('<cword>')<CR>
vnoremap <C-_>g <ESC>:execute 'cscope find g '.GetVisualSelection()<CR>
vnoremap <C-_>s <ESC>:execute 'cscope find s '.GetVisualSelection()<CR>
vnoremap <C-_>c <ESC>:execute 'cscope find c '.GetVisualSelection()<CR>
vnoremap <C-_>t <ESC>:execute 'cscope find t '.GetVisualSelection()<CR>
vnoremap <C-_>f <ESC>:execute 'cscope find f '.GetVisualSelection()<CR>
vnoremap <C-_>i <ESC>:execute 'cscope find i '.GetVisualSelection()<CR>

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


"" cscope使用方法
""下面是shell脚本，放到源码目录下运行
""#!/bin/sh
""find . -name "*.h" -o -name "*.c" -o -name "*.cc" > cscope.files
""cscope -bkq -i cscope.files
""ctags -R

""下面是对cscope -Rbkq 的解释

""-R: 在生成索引文件时，搜索子目录树中的代码
""-b: 只生成索引文件，不进入cscope的界面
""-k: 在生成索引文件时，不搜索/usr/include目录
""-q: 生成cscope.in.out和cscope.po.out文件，加快cscope的索引速度

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General abbreviations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%Y%m%d %H:%M:%S")<cr>
