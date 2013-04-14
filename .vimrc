"~/.vimrc (configuration file for vim only)

" Encoding related
set fileencodings=utf-8,gb18030,gbk,gb2312,latin1  "后方被注释
set encoding=utf-8
"let &termencoding=&encoding

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vundle begin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"后方存在"set nocompatible    "设置 vim 为不兼容vi模式
filetype off                " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

"$ mkdir -p ~/.vim/bundle/
"$ git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

"不同代码源上的vim插件的安装和管理方法
"
"格式1：Github上其他用户的仓库（非vim-scripts账户里的仓库，所以要加Github用户名）
"Bundle 'tpope/vim-fugitive'
"格式2：vim-scripts里面的仓库，直接打仓库名即可。
"Bundle 'FuzzyFinder'
"Bundle 'L9'
"格式3：非Github的Git仓库
"Bundle 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'



Bundle 'STL-improved'
Bundle 'majutsushi/tagbar'
"浏览tag,[own]wt
Bundle 'tag_in_new_tab'
"Shift-Enter in normal mode opens a definition of identifier under cursor in a new tab. Uses tag files (see :help tags)
Bundle 'autoload_cscope.vim'
"自动载入cscope.out databases
Bundle 'CmdlineComplete'
"补全命令行keywords(在本文件中),use Ctrl-P or Ctrl-N
"Bundle 'xptemplate'
"[default]C-\,Code snippets engine for Vim, with snippets library.
Bundle 'snipMate'
"[default]Tab,TextMate's snippets features in Vim,代码段补全
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neosnippet'
"输入时提示
Bundle 'nvie/vim-flake8'
"<F7> flake8
Bundle 'rkulla/pydiction'
"Bundle 'Rip-Rip/clang_complete'
"clang补全,与omnicppcomplete冲突
"Bundle 'osyo-manga/neocomplcache-clang_complete'
"Bundle 'mbbill/code_complete'
Bundle 'scrooloose/syntastic'
Bundle 'plasticboy/vim-markdown'
Bundle 'vim-scripts/haskell.vim'
"Bundle 'lukerandall/haskellmode-vim'
Bundle 'ujihisa/neco-ghc'
"Bundle 'eagletmt/ghcmod-vim'

"Bundle 'mileszs/ack.vim'
"perl moudle App::Ack的一个后端,能99%代替grep, 需要下载ack-grep

Bundle 'bash-support.vim'
"Bundle 'slimv.vim'
""Slimv is a SWANK client for Vim,similarly to SLIME for Emacs
"Bundle 'adah1972/tellenc.git'
"查看文件编码
"Bundle 'translate.vim'
""looks up a word in dictionary file using egrep
Bundle 'bufexplorer.zip'
"[default],be,浏览buffers

" 快速导航文件
"Bundle 'wincent/Command-T'
"类似TextMate中的Command-T,Go to File
"Bundle 'autopreview'
"autopreview查看函数原型
"Bundle 'mbbill/echofunc'
"mbbill/echofunc查看函数定义
Bundle 'grep.vim'
"在目录中查找包含指定文件内容
Bundle 'a.vim'
"在.c/.cpp与.h间快速切换
" >>>头/源文件切换命令
" :A 头文件／源文件切换
" :AS 分割窗后并切换头/源文件(切割为上下两个窗口)
" :AV 垂直切割窗口后切换头/源文件(切割为左右两个窗口)
" :AT 新建Vim标签式窗口后切换
" :AN 在多个匹配文件间循环切换
" >>>将光标所在处单词作为文件名打开
" :IH 切换至光标所在文件
" :IHS 分割窗口后切换至光标所在文件(指将光标所在处单词作为文件名打开)
" :IHV 垂直分割窗口后切换
" :IHT 新建标签式窗口后切换
" :IHN 在多个匹配文件间循环切换
" >>>快捷键操作
" <Leader>ih 切换至光标所在文件*
" <Leader>is 切换至光标所在处(单词所指)文件的配对文件(如光标所在处为foo.h，则切换至foo.c/foo.cpp...)
" <Leader>ihn 在多个匹配文件间循环切换

Bundle 'kien/ctrlp.vim'
"[own]<C-W><C-U> or <C-W>u 模糊查询 file,buffer,mru,tag..

"Bundle 'OmniTags'
""维护 tags file
"Bundle 'wesleyche/Trinity'
""管理Source Explorer, Taglist and NERD Tree
"Bundle 'wesleyche/SrcExpl'
"Bundle 'SrcExpl'
""source explore,,与上面相同
"Bundle 'minibufexpl.vim'
""编辑多个文件，标签显示
Bundle 'L9'
""L9 provides some utility functions and commands for programming in Vim
Bundle 'FuzzyFinder'
""quickly reach the buffer/file/command/bookmark/tag you want
Bundle 'FavEx'
"经常编辑的文件添加到收藏夹，文件打开后，
"[default]:FF or \ff新增文件到收藏夹，:FD or \fd新增目录到收藏夹
"Bundle 'utl.vim'
"在文本文件中，实现极其强大的链接功能


" 代码注释
Bundle 'The-NERD-Commenter'
"[default],cc;,cu注释与取消注释快速切换
"Bundle 'mattn/zencoding-vim'
""web前端
Bundle 'FencView.vim'
""编码自动识别
"Bundle 'CRefVim'
""提供标准C函数与语法的快速引用
Bundle 'c.vim'
"Bundle 'CCTree'
"CCTree , in real-time inside Vim using a Cscope database
"Bundle 'OmniCppComplete'
""omnifunc cppcomplete function for C and C++ files
"Bundle 'Tabular'
"Bundle 'godlygeek/tabular'
""用来对齐文本,与上面相同
"Bundle 'sketch.vim'
""Line drawing/painting using the mouse

" 智能文件管理
Bundle 'scrooloose/nerdtree'
"[own]wf浏览目录
"Bundle 'The-NERD-tree'
""与上面相同
"Bundle 'tpope/vim-fugitive'
""Git wrapper
"Bundle 'tpope/vim-rails'
Bundle 'LargeFile'
""编辑大文件,g:LargeFile设置最小值

"under linux need exec 'dos2unix ~/.vim/bundle/QFixToggle/plugin/qfixtoggle.vim'
"Bundle 'QFixToggle'
"切换|quickfix|窗口
Bundle 'Colour-Sampler-Pack'
"帮助测试主题
"Bundle 'ScrollColors'
""切换主题
"Bundle 'altercation/vim-colors-solarized'
Bundle 'txt.vim'
"通用的文本文档语法
" Bundle 'mru.vim'
" [own],hg,Most Recently Used文件
"Bundle 'YankRing.vim'
"类似emacs删除环
"Bundle 'tpope/vim-surround'
""删除,改变或添加surroundings
Bundle 'DoxygenToolkit.vim'
"doxygen风格快速注释
"Bundle 'tczengming/headerGatesAdd.vim'
" C/C++防止头文件重复包含
"Bundle 'ShowMarks'
"切换显示marks
Bundle 'Lokaltog/vim-powerline'
"缤纷的状态栏 let g:Powerline_symbols = 'fancy'
Bundle 'kana/vim-smartinput'
"Deal with pairs of punctuations such as (), [], {}, and so on
"Bundle 'Townk/vim-autoclose'
""自动补全括号

Bundle 'Lokaltog/vim-easymotion'
"提供了一组对应默认移动操作的键绑定, 能搜索并高亮所有可能的选择以供跳转

Bundle 'matchit.zip'
"configure % to match more than just single characters
"Bundle 'ervandew/supertab'
"use <Tab> for all your insert completion needs (:help ins-completion)

"Bundle 'shemerey/vim-peepopen'
""项目中文件与目录名模糊查询
"Bundle 'Rainbow-Parenthesis'
""高亮匹配的括号with a rainbow of colors
"Bundle 'Engspchk'
""[default],ec,Spelling checker: On-the-fly spell checking, multi-language, alternate spellings


" 中文文档
Bundle 'asins/vimcdoc'
"Bundle 'vimcn/c.vim.cnx'
"Bundle 'vimcn/mru.vim.cnx'
Bundle 'vimcn/NERD_commenter.cnx'
Bundle 'vimcn/neocompletecache.cnx'
Bundle 'vimcn/tagbar.cnx'
"Bundle 'vimcn/NERD_tree.vim.cnx'
""被vimcdoc包含
"Bundle 'vimcn/vimwiki.vim.cnx'
Bundle 'vimcn/matchit.vim.cnx'
"Bundle 'vimcn/bufexplorer.vim.cnx'
""被vimcdoc包含
"Bundle 'vimcn/snipMate.vim.cnx'
"Bundle 'vimcn/taglist.vim.cnx'
"Bundle 'vimcn/project.vim.acp'
"Bundle 'vimcn/acp.vim.cnx'


filetype plugin indent on   " required!
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vundle end
"""""""""""""""""""""""""""""""""""""""""""""""""""""""


" ------------------------------------------------------------------
"  自编函数
" ------------------------------------------------------------------
"Toggle Menu and Toolbar
if has("gui_running")
    "au GUIEnter * simalt ~x " 窗口启动时自动最大化{这个没有用啊}
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
" ------------------------------------------------------------------
" 自动更新最后修改时间
function! AutoUpdateTheLastUpdateInfo()
    let s:original_pos = getpos(".")
    let s:regexp = "^\\s*\\([#\\\"\\*]\\|\\/\\/\\)\\s\\?[lL]ast \\([uU]pdate\\|[cC]hange\\):"
    let s:lu = search(s:regexp)
    if s:lu != 0
        let s:update_str = matchstr(getline(s:lu), s:regexp)
        call setline(s:lu, s:update_str . strftime("%Y-%m-%d %H:%M:%S", localtime()))
        call setpos(".", s:original_pos)
    endif
endfunction
"autocmd BufWritePost *.{h,hpp,c,cpp} call AutoUpdateTheLastUpdateInfo()
"autocmd BufNewFile *.{h,hpp,c,cpp} exec 'call append(0, "\/\/ Last Update:" . strftime("%Y-%m-%d %H:%M:%S", localtime()))'
" ------------------------------------------------------------------



" ------------------------------------------------------------------
"  总体细节设置
" ------------------------------------------------------------------
"
" Enable syntax highlighting
syntax on

" set guifont=文泉驿等宽正黑\ Medium\ 10
set guifont=Yahei\ Mono\ 12

set shiftround
set diffopt+=vertical,context:3,foldcolumn:0
"set fileencodings=ucs-bom,utf-8,gb18030,gbk,gb2312,cp936,latin1  "前面存在
set fileformats=unix,dos,mac
set formatoptions=croqn2mB1
"set formatoptions=tcqro     " 使得注释换行时自动加上前导的空格和星号
set helplang=cn

set number


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

set delcombine " 组合字符一个个地删除
set ambiwidth=double   " ambiwidth 默认值为 single。在其值为 single 时，若 encoding 为 utf-8，gvim 显示全角符号时就会出问题，会当作半角显示。

" 不设定的话在插入状态无法用退格键和Delete键删除回车符
set backspace=indent,eol,start

" 光标到达行尾或者行首时，特定键继续移动转至下一行或上一行
set whichwrap+=b,s,<,>,[,]

set display=lastline  "解决自动换行格式下, 如高度在折行之后超过窗口高度结果这一行看不到的问题

" Tab related
set shiftwidth=8
set smarttab
set tabstop=8
set softtabstop=8

set list "显示tab,eol
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,nbsp:~ "eol:$

set maxcombine=4
set winaltkeys=no

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
set cindent "usage: select codes, press '=' key, the codes whichwrapill autoindenting

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
set wildmode=longest:full,full

"set mouse=a    " " 设定在任何模式下鼠标都可用
set mousemodel=popup

set nobackup                " 覆盖文件时不备份
set writebackup             " 写备份但关闭vim后自动删除
set nocompatible            " 设定 gvim 运行在增强模式下
set noignorecase            " 默认区分大小写
set nolinebreak             " 在单词中间断行
set nostartofline
set nojoinspaces
"set nowrapscan "搜索不回绕,默认回绕
set wrap                    " 自动换行显示
"set autochdir    " 自动切换当前目录为当前文件所在的目录
set autoread  "自动读取改变了的编辑中的文件

set scrolljump =1           " 当光标达到上端或下端时 翻滚的行数
set sidescroll =5           " 当光标达到水平极端时 移动的列数
set scrolloff =5            " 当光标距离极端(上,下,左,右)多少时发生窗口滚

set clipboard+=unnamed   " 与Windows共享剪贴板


" Avoid command-line redraw on every entered character by turning off Arabic
" shaping (which is implemented poorly).
if has('arabic')
  set noarabicshape
endif


set tags=tags
set tags+=./../tags,./../../tags,./../../../tags

"如果你想补全系统函数，可以用 ctags 生成包含所有系统头文件的标签文件: >
"  % ctags -R -f ~/.vim/systags /usr/include /usr/local/include
"在 vimrc 文件中，把这个标签文件增加到 'tags' 选项中: >
set tags+=~/.vim/systags


" 每行超过80个的字符用下划线标示
"au BufRead,BufNewFile *.asm,*.c,*.cpp,*.java,*.cs,*.sh,*.lua,*.pl,*.pm,*.py,*.rb,*.hs,*.vim 2match Underlined /.\%81v/

" 超过80个的字符高亮
"au BufWinEnter * let w:m1=matchadd('Search', '\%<88v.\%>81v', -1)
"au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)


autocmd FileType c set tabstop=8 shiftwidth=8
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab


" ###################################################
" map
" ###################################################


"FuzzyFinder vimrc example:
let g:fuf_modesDisable = []
let g:fuf_mrufile_maxItem = 400
let g:fuf_mrucmd_maxItem = 400
nnoremap <silent> sj     :FufBuffer<CR>
nnoremap <silent> sk     :FufFileWithCurrentBufferDir<CR>
nnoremap <silent> sK     :FufFileWithFullCwd<CR>
nnoremap <silent> s<C-k> :FufFile<CR>
nnoremap <silent> sl     :FufCoverageFileChange<CR>
nnoremap <silent> sL     :FufCoverageFileChange<CR>
nnoremap <silent> s<C-l> :FufCoverageFileRegister<CR>
nnoremap <silent> sd     :FufDirWithCurrentBufferDir<CR>
nnoremap <silent> sD     :FufDirWithFullCwd<CR>
nnoremap <silent> s<C-d> :FufDir<CR>
nnoremap <silent> sn     :FufMruFile<CR>
nnoremap <silent> sN     :FufMruFileInCwd<CR>
nnoremap <silent> sm     :FufMruCmd<CR>
nnoremap <silent> su     :FufBookmarkFile<CR>
nnoremap <silent> s<C-u> :FufBookmarkFileAdd<CR>
vnoremap <silent> s<C-u> :FufBookmarkFileAddAsSelectedText<CR>
nnoremap <silent> si     :FufBookmarkDir<CR>
nnoremap <silent> s<C-i> :FufBookmarkDirAdd<CR>
nnoremap <silent> st     :FufTag<CR>
nnoremap <silent> sT     :FufTag!<CR>
nnoremap <silent> s<C-]> :FufTagWithCursorWord!<CR>
nnoremap <silent> s,     :FufBufferTag<CR>
nnoremap <silent> s<     :FufBufferTag!<CR>
vnoremap <silent> s,     :FufBufferTagWithSelectedText!<CR>
vnoremap <silent> s<     :FufBufferTagWithSelectedText<CR>
nnoremap <silent> s}     :FufBufferTagWithCursorWord!<CR>
nnoremap <silent> s.     :FufBufferTagAll<CR>
nnoremap <silent> s>     :FufBufferTagAll!<CR>
vnoremap <silent> s.     :FufBufferTagAllWithSelectedText!<CR>
vnoremap <silent> s>     :FufBufferTagAllWithSelectedText<CR>
nnoremap <silent> s]     :FufBufferTagAllWithCursorWord!<CR>
nnoremap <silent> sg     :FufTaggedFile<CR>
nnoremap <silent> sG     :FufTaggedFile!<CR>
nnoremap <silent> so     :FufJumpList<CR>
nnoremap <silent> sp     :FufChangeList<CR>
nnoremap <silent> sq     :FufQuickfix<CR>
nnoremap <silent> sy     :FufLine<CR>
nnoremap <silent> sh     :FufHelp<CR>
nnoremap <silent> se     :FufEditDataFile<CR>
nnoremap <silent> sr     :FufRenewCache<CR>



nnoremap <Space> za
nmap ' <C-W>
nmap 'm :marks<CR>
nmap gb :setl fenc=gb18030<CR>



" Set Up and Down non-linewise
"noremap <Up> gk
"noremap <Down> gj

nnoremap <F12> :%s/[ \t\r]\+$//g<CR>
"nmap <S-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

nmap t= mxHmygg=G`yzt`x
nmap ta ggVG

"清除高亮
nmap <silent> <M-n> :nohls<CR>

" w开头
nnoremap <silent> wf :NERDTreeToggle<CR>
nnoremap <silent> we :exec("NERDTree ".expand('%:h'))<CR>
"nnoremap <silent> wn :Sexplore!<CR>
nnoremap <silent> wt :TagbarToggle<CR>
noremap <silent> <F11> :BufExplorer<CR>
noremap <silent> <m-F11> :BufExplorerHorizontalSplit<CR>
" noremap <silent> <c-F11> :BufExplorerVerticalSplit<CR>


" FuzzyFinder
"nmap <M-L> :FufFile<CR>


" 选中状态下 Ctrl+c 复制
vnoremap <C-c> "+y
" Shift + Delete 插入系统剪切板中的内容
noremap <S-Del> "+p
inoremap <S-Del> <esc>"+pa
vnoremap <S-Del> d"+P


" {{{ plugin - bufexplorer.vim Buffers切换
" \be 全屏方式查看全部打开的文件列表
" \bv 左右方式查看   \bs 上下方式查看
"}}}

" {{{ plugin - matchit.vim 对%命令进行扩展使得能在嵌套标签和语句之间跳转
" % 正向匹配      g% 反向匹配
" [% 定位块首     ]% 定位块尾
"}}}


" Ctrl-S 保存文件
nmap <silent> <C-S> :update<CR>
imap <silent> <C-S> <ESC>:update<CR>
vmap <silent> <C-S> <ESC>:update<CR>

nmap <C-D> <C-W>q

" 上下移动一行文字
nmap <C-j> mz:m+<cr>`z
nmap <C-k> mz:m-2<cr>`z
vmap <C-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <C-k> :m'<-2<cr>`>my`<mzgv`yo`z

" 补全最长项
inoremap <expr> <C-L> pumvisible()?"\<C-E>\<C-N>":"\<C-N>"


" ###################################################
"  mapleader
" ###################################################

"设置自定义的<leader>快捷键
let mapleader=","
let g:mapleader=","

map <C-right> <ESC>:bnext<CR>
map <C-left> <ESC>:bprevious<CR>

map <leader>tn :tabnew %<CR>
map <leader>td :tabnew .<CR>
map <leader>tl :tabclose<CR>
map <leader>tm :tabmove
"标签栏只显示文件名
set guitablabel=%t

"Smart way to move btw. window
"map <M-j> <C-W>j
"map <M-k> <C-W>k
"map <M-h> <C-W>h
"map <M-l> <C-W>l

"nmap <silent> <leader>fe :Sexplore!<CR>
" nmap <silent> <leader>hg :MRU<CR>
nmap <silent> <leader>er :e ~/.vimrc<CR>
"nmap <silent> <leader>ec :e ~/.vim/snippets/c.snippets<CR>
nmap <silent> <Leader>cs :!cscope -Rbq<CR>
nmap <silent> <Leader>ct :!ctags -R --c++-kinds=+px --fields=+ilaS --extra=+q `pwd`<CR>
nmap <silent> <Leader>ft :!bash ~/.vim/filenametags <CR>



" ###################################################
"  自定义命令
" ###################################################

"   设置成 Linux 下适用的格式
command! Lin setl ff=unix fenc=utf8 nobomb eol
"   设置成 Windows 下适用的格式
command! Win setl ff=dos fenc=gb18030


" ###################################################
"  自动执行命令,与函数
" ###################################################

autocmd! BufWritePost .vimrc source $HOME/.vimrc    " .vimrc编辑后重载

" Restore the last quit position when open file.
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \     exe "normal g'\"" |
     \ endif


if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
	\ if &omnifunc == "" |
	\   setlocal omnifunc=syntaxcomplete#Complete |
	\ endif
endif


" ###################################################
" 插件配置
" ###################################################

" fencview.vim 对打开的文件的编码自动识别
" let g:fencview_autodetect = 1


" haskell 设置
" au Bufenter *.hs compiler ghc
" :let g:haddock_browser="/usr/bin/firefox"
" :let g:ghc="/usr/bin/ghc"
setlocal omnifunc=necoghc#omnifunc

" For Haskell
" :let hs_highlight_delimiters=1            " 高亮定界符
" :let hs_highlight_boolean=1               " 把True和False识别为关键字
" :let hs_highlight_types=1                 " 把基本类型的名字识别为关键字
" :let hs_highlight_more_types=1            " 把更多常用类型识别为关键字
" :let hs_highlight_debug=1                 " 高亮调试函数的名字
" :let hs_allow_hash_operator=1             " 阻止把#高亮为错误



" ###### Bundle 'altercation/vim-colors-solarized' ######
" solarized theme
"hi Normal ctermbg=NONE  "开启背景透明
set t_Co=256   " Explicitly tell vim that the terminal supports 256 colors,
"let g:solarized_termcolors=256
"let colorscheme = 'solarized'
"let colorscheme = 'desert'
let colorscheme = 'desertEx'
set background=dark

" 图形与终端
if has("gui_running")
  " 有些终端不能改变大小
  set columns=85
  set lines=33
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



" NERDTree options
" Auto change the root directory
let NERDTreeChDirMode=2
let g:NERDTreeWinSize = 25


" Tagbar options
let g:tagbar_width = 35
let g:tagbar_expand = 1  "向外拓展


" syntastic
let g:syntastic_check_on_open = 1
" let g:syntastic_error_symbol = '✗'
" let g:syntastic_warning_symbol = '⚠'
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_loc_list_height = 5
" let g:syntastic_enable_highlighting = 0
" let g:syntastic_mode_map = { 'passive_filetypes': ['scss', 'slim'] }


" Doxygen
let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
let g:DoxygenToolkit_blockFooter="--------------------------------------------------------------------------"
let g:DoxygenToolkit_authorName="whatot2@gmail.com"
let g:DoxygenToolkit_versionString="0.1.00"
let g:DoxygenToolkit_briefTag_funcName="yes"
"autocmd BufNewFile *.{h,hpp,c,cpp} DoxAuthor


" 设置命令行和状态栏 {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set ruler                  " 打开状态栏标尺
"set cmdheight=1            " 设定命令行的行数为 1
"set laststatus=2           " 显示状态栏 (默认值为 1, 无法显示状态栏)
"set statusline=%F%m%r,%Y,%{&fileformat}\ \ \ ASCII=\%b,HEX=\%B\ \ \ %l,%c%V\ %p%%\ \ \ [\ %L\ lines\ in\ all\ ]
                            " 设置在状态行显示的信息如下：
                            " %F    当前文件名
                            " %m    当前文件修改状态
                            " %r    当前文件是否只读
                            " %Y    当前文件类型
                            " %{&fileformat}5=
                            "       当前文件编码
                            " %b    当前光标处字符的 ASCII 码值
                            " %B    当前光标处字符的十六进制值
                            " %l    当前光标行号
                            " %c    当前光标列号
                            " %V    当前光标虚拟列号 (根据字符所占字节数计算)
                            " %p    当前行占总行数的百分比
                            " %%    百分号
                            " %L    当前文件总行数

" ###### Lokaltog/vim-powerline缤纷的状态栏 ######
set laststatus=2            " always have status-line'
"if has("gui_running")
"  let g:Powerline_symbols = 'fancy'
let g:Powerline_symbols = 'unicode'
"endif
"set statusline=%F%m%r%h%w\ %{&ff}\ %Y\ [ascii:%b\ hex:0x\%02.2B]\ [%{(&fenc\ ==\ \"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]\ %=%l/%L,%v\ %p%%
set showcmd   " 在状态栏显示目前所执行的指令，未完成的指令片段亦会显示出来


" ###### minibufexpl.vim 编辑多个文件，标签显示 ######
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplModSelTarget = 1


" ###### Bundle 'xptemplate' ######
" <C-\>snippt补全


" ctrlp
noremap <C-W><C-U> :CtrlPMRU<CR>
nnoremap <C-W>u :CtrlPMRU<CR>
"let g:ctrlp_user_command = 'find %s -type f'
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|.rvm$'
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1


" grep.vim
let g:Grep_Default_Options = '--binary-files=without-match'


" -- cscope --
let g:autocscope_menus=0
" 设定是否使用 quickfix 窗口来显示 cscope 结果
set cscopequickfix=s-,c-,d-,i-,t-,e-

"'csto' 被设为 0，cscope 数据库先 被搜索，搜索失败的情况下在搜索标签文件
"设定了 'cscopetag'，这样所有的 :tag 命令就会实际上调用 :cstag。这包括 :tag、Ctrl-] 及 vim -t。
"结果是一般的 tag 命令不仅搜索由 ctags 产生的标签文 件，同时也搜索 cscope 数据库,但是好像有bug,二者共存时有的无法搜索
if has("cscope")
    set csprg=/usr/bin/cscope
    " Use both cscope and ctag
    set cscopetag
    " Show msg when cscope db added
    set cscopeverbose
    " Use cscope for definition search first
    set cscopetagorder=0
endif

nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

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

""1.生成一个 cscope 的数据库

""cscope -Rbq
""  :cs add /usr/src/linux/cscope.out /usr/src/linux/
""  :cs reset : 重新初始化所有连接. 用法 : cs reset
"测试（1）:cscope find g 函数名 （2） :cscope find c 函数名
":cw 显示多个结果

" 解决cscope与tag共存时ctrl+]有时不正常的bug
nmap <C-]> :tj <C-R>=expand("<cword>")<CR><CR>


" easymotion
let EasyMotion_leader_key = '<M-q>'
let EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'

" Engspchk
"let g:spchklang = "eng"
"let g:spchkdialect  = "usa"


"let g:SuperTabRetainCompletionType = 2
" 0 - 不记录上次的补全方式
" 1 - 记住上次的补全方式,直到用其他的补全命令改变它
" 2 - 记住上次的补全方式,直到按ESC退出插入模式为止
"let g:SuperTabDefaultCompletionType = '<C-X><C-U>'



"neocomplcache.vba 插件替代autocomplpop(acp.vim) omnicppcomplete.vim
" plugin - NeoComplCache.vim 自动补全插件
"-----------------------------------------------------------------
" 1、使用缓存，自动补全时效率高；
" 2、生成的关键词列表准确；
" 3、支持下划线分割的关键词，如apple_boy_cat，就可以只输入a_b_c，然后补全；
" 4、支持驼峰格式匹配关键词，如AppleBoyCat，就可以只输入ABC，然后补全；
" 5、既可以像AutoComplPop那样在Vim中输入的同时自动弹出补全列表，又可以自定义快捷键手动触发；
" 6、支持从文件名和目录名中匹配补全条件；
" 7、对于程序源文件，支持从语言API中匹配补全条件；
"-----------------------------------------------------------------

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " NeoComplCache
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " 停用 AutoComplPop.
  "let g:acp_enableAtStartup = 0
  " 启用 neocomplcache.
  let g:neocomplcache_enable_at_startup = 1

  let g:neocomplcache_enable_smart_case = 1
  " 启用大写字母补全.
  let g:neocomplcache_enable_camel_case_completion = 1
  " 启用下划线补全.
  let g:neocomplcache_enable_underbar_completion = 1
  " 设定最小语法关键词长度.
  let g:neocomplcache_min_syntax_length = 3
  let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
  	" 定义字典.
  let g:neocomplcache_dictionary_filetype_lists = {
      \ 'default' : '',
         \ }

  " 定义关键词.
  if !exists('g:neocomplcache_keyword_patterns')
      let g:neocomplcache_keyword_patterns = {}
  endif
  let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

  " 插件键映射.
  imap <C-k>     <Plug>(neocomplcache_snippets_expand)
  smap <C-k>     <Plug>(neocomplcache_snippets_expand)
  inoremap <expr><C-g>     neocomplcache#undo_completion()
  inoremap <expr><C-l>     neocomplcache#complete_common_string()

  " 类似于SuperTab用法 .
  "imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

  " 推荐的键映射.
  " <CR>: close popup and save indent.
  inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
  " <TAB>: completion. NO USE with snipmate
  let g:neosnippet#enable_snipmate_compatibility = 1
  "inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><C-Y>  neocomplcache#close_popup()
  inoremap <expr><C-e>  neocomplcache#cancel_popup()
  "inoremap <expr><Enter>  pumvisible() ? neocomplcache#close_popup()."\<C-n>" : "\<Enter>"
  inoremap <expr><Enter>  pumvisible() ? "\<C-Y>" : "\<Enter>"

  " 类似于AutoComplPop用法 .
  let g:neocomplcache_enable_auto_select = 1
  " 类似于 Shell 用法(不推荐).
  "set completeopt+=longest
  "let g:neocomplcache_enable_auto_select = 1
  "let g:neocomplcache_disable_auto_complete = 1
  "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
  "inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

  " Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd filetype cpp setlocal omnifunc=omni#cpp#complete#main
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType c setlocal omnifunc=ccomplete#Complete

"Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif

let g:neocomplcache_omni_patterns.ruby = '[^. */t]/./w*/|/h/w*::'
let g:neocomplcache_omni_patterns.php = '[^. /t]->/h/w*/|/h/w*::'
let g:neocomplcache_omni_patterns.c = '/%(/./|->/)/h/w*'
let g:neocomplcache_omni_patterns.cpp = '/h/w*/%(/./|->/)/h/w*/|/h/w*::'



" use neocomplcache & clang_complete
" neocomplcache option
"let g:neocomplcache_force_overwrite_completefunc=1
" clang_complete option
"let g:clang_complete_auto=1



" txt.vim
"高亮显示txt 需要txt.vim
au BufRead,BufNewFile * setfiletype txt


" 被FuzzyFinder与ctrlp功能包含 " mru
" let MRU_File = '~/.vim/vim_mru_files'
" let MRU_Max_Entries=200
" let MRU_Exclude_Files='\v^.*\~$|/COMMIT_EDITMSG$|/itsalltext/|^/tmp/'
" "  加载菜单太耗时
" let MRU_Add_Menu=0
" let MRU_Auto_Close=1
" let MRU_Max_Menu_Entries = 15


" showmarks setting
"let showmarks_enable = 0            " disable showmarks when vim startup
"let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
"let showmarks_ignore_type = "hqm"   " help, Quickfix, non-modifiable
",mt - 打开/关闭ShowMarks插件 ( 常用 )
",mo - 强制打开ShowMarks插件
",mh - 清除当前行的标记 ( 常用 )
",ma - 清除当前缓冲区中所有的标记 ( 常用 )
",mm - 在当前行打一个标记，使用下一个可用的标记名 ( 常用 )

"vim 自带Marks的使用, 如果不习惯可以使用插件ShowMarks(下面有介绍), 使能showmarks_enable = 1
"这个功能是VIM自带的功能, 习惯就好, 一切从简．可以查看帮助文档, 下面是简单介绍.
"
"(1) 设置标记 --> norm模式下, m + [a-z]. ( m - mark, [a-z] 也可以是[A-Z], 推荐只使用小写字母. )
"(2) 删除标记 --> 多种方法如下:
" 1. 删除标记所在的行．
" 2. 在其他行作相同的标记(eg. ma ).
" 3. 命令模式下 :delmarks a ( 简写 :delm a )
" 4. 命令模式下 :delmarks! ( 删除所有小写字母标记 )
" 5. 删除多个标记 :delmarks abcd (a,b,c,d都被删除, 也¯以 :delmarks a-d)
"(3) 使用标记 -->
" 1. 定位到标记位置(以a为例) --> `a or 'a ( 区别在于 `a到目标行的最左端,'a到目标行的第一个非空字符之前)
" 2. 对当前行到标记位置的操作--> d`a , y`a , c`a 分别表示对该区域的删除, 复制, 更改
" 3. 显示设置的标记信息 --> :marks (显示所有) :marks a (只显示a标记的信息)
"(4) 有用特殊标记(系统设置好的)
" 1. '' 或者 `` 从当前行跳回到最近一次跳到改行的位置去.
" 2. `. 从当前行跳回到最后一次修改的行的位置去.


" syntax/python.vim
let python_highlight_all = 1
let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'


"NERD_commenter.vim "可以使用cvim.zip, 但是这个觉到习惯一些
let NERDSpaceDelims=1 " 让注释符与语句之间留一个空格
let NERDCompactSexyComs=1 " 多行注释时样子更好看
let NERD_c_alt_style=1

"Default mapping:
"[count],cc " 以行为单位进行注释.
" ,c " comment , <--> , uncomment. ( 常用 )
" ,cm " 一段为单位进行注释. ( 常用 )
" ,cs " 简洁美观式注释. ( 常用 , 可以嵌套注释,用,cu取消注释 )
" ,cy " Same as ,cc except that the commented line(s) are yanked first.
" ,c$ " 注释当前光标到行末的内容.
" ,cA " 在行末进行手动输入注释内容.
" ,ca " 切换注释方式(/**/ <--> //). ( 常用 )
" ,cl " Same cc, 左对齐.
" ,cb " Same cc, 两端对其.
" ,cu " Uncomments the selected line(s). ( 常用 )



"单独切换打开NERD_tree
"-----------------------------------------------------------------
" plugin - NERD_tree.vim 以树状方式浏览系统中的文件和目录
" :ERDtree 打开NERD_tree :NERDtreeClose 关闭NERD_tree
" o 打开关闭文件或者目录 t 在标签页中打开
" T 在后台标签页中打开 ! 执行此文件
" p 到上层目录 P 到根目录
" K 到第一个节点 J 到最后一个节点
" u 打开上层目录 m 显示文件系统菜单（添加、删除、移动操作）
" r 递归刷新当前目录 R 递归刷新当前根目录
"-----------------------------------------------------------------

let g:NERDChristmasTree = 1 "色彩显示
let g:NERDTreNERDShowHidden = 1 "显示隐藏文件
let g:NERDTreeWinPos = 'left' "窗口显示位置
let g:NERDTreeHighlightCursorline = 0 "高亮当前行
let g:NERDTreeWinSize = 25 "设置显示宽度

"nmap :NERDTreeToggle.
" o.......打开所选文件或目录 ( 常用 )
" enter..............相当于o
" go......类似o, 但光标仍然停留在NERD_tree ( 常用 )
" t.......在新标签中打开所选文件
" T.......类似t, 但光标仍然停留在NERD_tree
" i.......在一个水平分割窗口中打开文件
" gi......类似i, 但光标仍然停留在NERD_tree
" s.......在一个垂直分割窗口中打开文件........|NERDTree-s|
" gs......类似s, 但光标仍然停留在NERD_tree
" O.......递归打开所选目录
" 鼠标双击.......相当于o, 没错支持鼠标的~!



" --------------------------------------------------------


"vim折叠功能
"折叠方式,可用选项 'foldmethod' 来设定折叠方式：set fdm=***
"有 6 种方法来选定折叠：
"manual 手工定义折叠
"indent 更多的缩进表示更高级别的折叠
"expr 用表达式来定义折叠
"syntax 用语法高亮来定义折叠
"diff 对没有更改的文本进行折叠
"marker 对文中的标志折叠
"
"常用的折叠快捷键
"zf 创建折叠 (marker 有效)
"zo 打开折叠
"zO 对所在范围内所有嵌套的折叠点展开
"zc 关闭当前折叠
"zC 对所在范围内所有嵌套的折叠点进行折叠
"[z 到当前打开的折叠的开始处。
"]z 到当前打开的折叠的末尾处。
"zM 关闭所有折叠 (我喜欢)
"zr 打开所有折叠
"zR 循环地打开所有折叠 (我喜欢)
"zE 删除所有折叠
"zd 删除当前折叠
"zD 循环删除 (Delete) 光标下的折叠，即嵌套删除折叠
"za 若当前打开则关闭，若当前关闭则打开 ( 这个就足够了)
"zA 循环地打开/关闭当前折叠
"zj 到下一折叠的开始处 ( 我喜欢 )
"zk 到上一折叠的末尾 ( 我喜欢 )
"set fdm=marker
"set foldmethod=indent
"要想在{ } 代码块中折叠，按空格键
"syntax 与 c.vim 中的 /cc 注释功能冲突
set fdm=marker

"关掉映射,经常带来麻烦
"nnoremap @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo') "使用空格打开或关闭折叠


"-------------------------------------------
"文件比较
"-------------------------------------------
":vertical diffsplit FILE_RIGHT "与已打开的文件进行比较
"设置不同之处显示上下三行
set diffopt=context:3

"命令模式（ESC键进入）：
"[c 跳转到下一个差异点
"]c 跳到上一个差异点
"dp 左边文件差异复制到右边文件(直接在键盘上行按下dp)
"do 右边文件差异复制到左边文件(直接在键盘上行按下do)
"zo 隐藏相同行
"zc 展开向同行
"u 撤销
"Ctrl+w 文件切换
":qa! 退出不保存
":wa 保存
":wqa 保存退出
":diffupdate 重新比较


" ###### bufexplorer.zip ######
" <mapleader> --> \

"'\be' (normal open)  or
"'\bs' (force horizontal split open)  or
"'\bv' (force vertical split open)
"r可以进行反向排序.
"d/D可以用来关闭文件.
"p可以用来显示/关闭绝对路径模式



"echofunc.vim 在命令行中显示函数信息
"直接下载解压即可( tags 插件已包含相似功能, 没必要装此插件 )
"这个插件的功能需要 tags 文件的支持, 并且在创建 tags 文件的时候要加选项"--fields=+lS" : ctags -R --fields=+lS
let g:EchoFuncKeyPrev=''
let g:EchoFuncKeyNext=''
let g:EchoFuncLangsUsed = ["c","java","cpp"]



"CCtree.Vim C Call-Tree Explorer 源码浏览工具 关系树 (赞)

"1. 除了cscope ctags 程序的安装,还需安装强力胶 ccglue(ctags-cscope glue): http://sourceforge.net/projects/ccglue/files/src/
" (1) ./configure && make && make install
" (2) $ccglue -S cscope.out -o cctree.out 或 $ccglue -S cscope1.out cscope2.out -o cctree.out
" (3) :CCTreeLoadXRefDBFromDisk cctree.out

"2. 映射快捷键(上面F1) 其中$CCTREE_DB是环境变量,写在~/.bashrc中
" map :CCTreeLoadXRefDBFromDisk $CCTREE_DB
" eg.
" export CSCOPE_DB=/home/tags/cscope.out
" export CCTREE_DB=/home/tags/cctree.out
" export MYTAGS_DB=/home/tags/tags

 " "注: 如果没有装ccglue ( 麻烦且快捷键不好设置,都用完了 )
 " (1) map xxx :CCTreeLoadDB $CSCOPE_DB "这样加载有点慢, cscope.out cctree.out存放的格式不同
 " (2) map xxx :CCTreeAppendDB $CSCOPE_DB2 "最将另一个库
 " (3) map xxx :CCTreSaveXRefDB $CSCOPE_DB "格式转化xref格式
 " (4) map xxx :CCTreeLoadXRefDB $CSCOPE_DB "加载xref格式的库 (或者如下)
 "map xxx :CCTreeLoadXRefDBFromDisk $CSCOPE_DB "加载xref格式的库
 " (5) map xxx :CCTreeUnLoadDB "卸载所有的数据库

 "3. 设置
"let g:CCTreeDisplayMode = 3 " 当设置为垂直显示时, 模式为3最合适. (1-minimum width, 2-little space, 3-witde)
"let g:CCTreeWindowVertical = 0 " 水平分割,垂直显示
"let g:CCTreeWindowMinWidth = 40 " 最小窗口
"let g:CCTreeUseUTF8Symbols = 1 "为了在终端模式下显示符号



"cvim.zip插件--编码必备
"下载地址: http://www.vim.org/scripts/script.php?script_id=213
"let g:C_MapLeader = ',' "默认的是'/'
"Ctrl+j 的使用:eg. 当你使用/if添加一个函数时,会多出一些类似<+xxx+>的东西(需要重新填写), ctrl+j可以帮你忙,试一下很强.
" 功能说明
"1.添加文件头注释（自动完成）
"2.添加c函数（标准模式执行/if, 再输入函数名）
"3.添加main函数（标准模式执行/im）
"4.添加函数注释 （标准模式执行/cfu）
"5.添加注释框架 （标准模式执行/cfr）
"6.添加头文件 （标准模式执行/p<包含头文件 或 /p"包含头文件）
"7.添加宏定义 （标准模式执行/pd)
"8.添加代码片段
"（标准模式执行/nr,需在~/.vim/c-support/codesnippets/中加入存放代码的文件)
" -- Help ---------------------------------------------------------------
" /hm show manual for word under the cursor (n,i)
" /hp show plugin help (n,i)



"a.vim实现源文件与头文件切换

let alternateSearchPath = 'sfr:.,sfr:./include,sfr:../include,sfr:../inc' "设置include(.h)文件存在何处.
let alternateNoDefaultAlternate = 1 "当没有找到相应的.h文件时,不自动创建

"   使用方法
":A 切换当前文件的头文件,在当前窗口打开(或者反过来) "先打开.h .c 文件存于buff中
":AS 功能同:A,但是切换到水平分割窗口的打开
":AV 功能同:A,但是切换到竖直分割的窗口打开
":AT 功能同:A,但是切换到标签页打开


" --------------------------------------------------------------------
" plugin - matchit.vim 对%命令进行扩展使得能在嵌套标签和语句之间跳转
" %              正向匹配
" g%            反向匹配
" [%            定位块首
" ]%             定位块尾
" --------------------------------------------------------------------


"寄存器
" q[a-z] --- 记录命令, 已q结束, @[a-z]引用 --- 很强大,需要习惯使用
" " "[a-z]p --- 可以将寄存器[a-z]中的命令以文本的方式输出,并进行修改
" " "[a-z]y$ --- 将寄存器修改后的内容存回到对应寄存器


"Visual 选中模式
" shift + v : 配合jk,上下键,整行选择
" ctrl + v : 配合hjkl,上下左右键,灵活选择区域
" o : 在选中的区域中对角线移动
" O : 在选中的区域中行左右移动
" gv : 重新选中原来的选中的区域
" : : 在选中区域后,shift+:到命令模式, : eg. '<,'>s/pattern/newstring/g --
" 在选中的区域中查找patte && replace
" ctrl + v 选中一列后, 按I插入字符,Esc退出 :
" 每一行都添加这个字符,很好的一个注释方法


"Command Mode
" :g/pattern/d --- delete line contained of string "pattern"


"窗口
"C-w 0 : 恢复窗口大小
"C-w = : 窗口等大
"C-w n_ : 窗口最大化
"C-w _ : 改变窗口的大小
"c-w C-c : 关闭窗口
"C-w C-] : 以函数所在文件分割窗口
"C-w C-c --- 关闭当前窗口
"C-w S-[hjkl] : 窗口位置放置
"shift + z + z : close vim edit. You need set auto write.

"vim t1.c t2.c t3.c -o2 : open thress files using two windows. if -o(no
"number), using three windows here.



"杂项

" !!date --- 插入日期
" read !date -R --- 插入日期 ( -R 显示日期的格式而已 man date )
" %s//s/+$// --- 删除多余的空格
" ctrl + K --- 插入特殊字符
" digraph --- 显示特殊字符,字符组合
" set ic --- 忽略大小写
" . --- 重复前次操作
" ctrl + a --- repeat record.
" ctrl + r --- 反撤消, 当u撤消后,又想恢复,可以使用
" daw && caw && cis --- delete a word && change a word && 修改一个句子
" cc && dd --- change one line reserving indent && delete one line
" CTRL+U ---- CTRL+D ---> half page move
" CTRL+E ---- CTRL+Y ---> one line move
" CTRL+F ---- CTRL+B ---> one page move
" CTRL + O --- 返回刚才位置,每按一次都会退回到之前的位置
" CTRL + I --- 与CTRL+O相反,每按一次退回来
" [i --- (将光标移到变量上)显示第一个局部变量定义处
" [I --- (将光标移到变量上)显示所有该变量的定义处
" '' --- 回到刚才停留处
" // ---- 精确查找


" 16进制编辑,码农必备,lol
" :%!xxd 16进制编辑
" :%!xxd -r 文本编辑


"Shell
"巧妙去除Linux下代码行中的^M符号和windows下代码编辑引起的警告错
":%s /^M//g ，其中^M的写法是按住ctrl不放，再按v，然后按M，再放ctrl


" #wash_error.sh
" #!/bin/sh
" ls *.h *.c | awk '{print $1}' > dealfile
" cat dealfile | while read file
" do
" echo " " >> $file
" done
" #dos2unix *.c *.h
"巧妙去除Linux下代码行中的^M符号和windows下代码编辑引起的警告错


"个人工程shell
"
"1. 创建cscope库 cs.sh
"
" #!/bin/sh
" #rm -f cscope.* tags
" find /root/Trunk/EC2108_C27/ /root/Trunk/Hippo/ -name "*.h" -o -name "*.c"
" -o -name "*.cc" -o -name "*.cpp" > cscope.files
" cscope -bkq -i cscope.files
" ccglue -S cscope.out -o cctree.out

"2. 创建文件查找库 filename.sh
"
" echo -e "!_TAG_FILE_SORTED/t2/t/2=foldcase/" > filenametags
" find /root/Trunk/EC2108_C27 -not -regex
" '.*/./(png/|gif/|db/|bak/|swp/|doc/|html/|htm/|jsp/|js/)' ! -path "*svn*"
" -type f -printf "%f/t%p/t1/n" | sort -f >> filenametags
" find /root/Trunk/Hippo/ -not -regex
" '.*/./(png/|gif/|db/|bak/|swp/|doc/|html/|htm/|jsp/|js/)' ! -path "*svn*"
" -type f -printf "%f/t%p/t1/n" | sort -f >> filenametags

"3. 创建tags库 tags.sh
"
" ctags -R --c++-kinds=+p --fields=+ialS --extra=+q /root/Trunk/EC2108_C27
" /root/Trunk/Hippo/

"4. 设置环境变量(写到~/.bashrc)
"
" export CSCOPE_DB=/home/tags/cscope.out
" export CCTREE_DB=/home/tags/cctree.out
" export MYTAGS_DB=/home/tags/tags

