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
Bundle 'ervandew/supertab'
Bundle 'OmniCppComplete'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'

Bundle 'scrooloose/syntastic'
Bundle 'plasticboy/vim-markdown'

Bundle 'bash-support.vim'
Bundle 'bufexplorer.zip'

Bundle 'grep.vim'
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

Bundle 'L9'
Bundle 'FuzzyFinder'

" 代码注释
Bundle 'The-NERD-Commenter'
"[default],cc;,cu注释与取消注释快速切换

Bundle 'scrooloose/nerdtree'
"[own]wf浏览目录
"Bundle 'tpope/vim-fugitive'
""Git wrapper
Bundle 'LargeFile'
""编辑大文件,g:LargeFile设置最小值

Bundle 'tpope/vim-surround'
""删除,改变或添加surroundings
Bundle 'kana/vim-smartinput'
"Deal with pairs of punctuations such as (), [], {}, and so on

Bundle 'Lokaltog/vim-easymotion'
"提供了一组对应默认移动操作的键绑定, 能搜索并高亮所有可能的选择以供跳转

Bundle 'matchit.zip'
"configure % to match more than just single characters

Bundle 'hsitz/VimOrganizer'
Bundle 'mbbill/echofunc'

" 中文文档
Bundle 'asins/vimcdoc'
"Bundle 'vimcn/c.vim.cnx'
Bundle 'vimcn/NERD_commenter.cnx'
Bundle 'vimcn/tagbar.cnx'
"Bundle 'vimcn/vimwiki.vim.cnx'
Bundle 'vimcn/matchit.vim.cnx'
"Bundle 'vimcn/snipMate.vim.cnx'
"Bundle 'vimcn/project.vim.acp'
"Bundle 'vimcn/acp.vim.cnx'


filetype plugin indent on   " required!

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vundle end
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  总体细节设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax on

set guifont=Yahei\ Mono\ 12

set shiftround
set diffopt+=vertical,context:3,foldcolumn:0
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

" Format related
set tw=78
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

"set mouse=a     " 设定在任何模式下鼠标都可用
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
" set tags+=./../tags,./../../tags,./../../../tags

"如果你想补全系统函数，可以用 ctags 生成包含所有系统头文件的标签文件: >
"  % ctags -R -f ~/.vim/systags /usr/include /usr/local/include
"在 vimrc 文件中，把这个标签文件增加到 'tags' 选项中: >
" set tags+=~/.vim/systags
" set tags+=~/linux/tags
" cs add ~/linux/cscope.out


autocmd FileType c set tabstop=8 shiftwidth=8 noexpandtab
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"FuzzyFinder vimrc example:
let g:fuf_modesDisable = []
let g:fuf_mrufile_maxItem = 400
let g:fuf_mrucmd_maxItem = 400
nnoremap <silent> sj     :FufBuffer<CR>
" nnoremap <silent> sk     :FufFileWithCurrentBufferDir<CR>
" nnoremap <silent> sK     :FufFileWithFullCwd<CR>
" nnoremap <silent> s<C-k> :FufFile<CR>
" nnoremap <silent> sl     :FufCoverageFileChange<CR>
" nnoremap <silent> sL     :FufCoverageFileChange<CR>
" nnoremap <silent> s<C-l> :FufCoverageFileRegister<CR>
" nnoremap <silent> sd     :FufDirWithCurrentBufferDir<CR>
" nnoremap <silent> sD     :FufDirWithFullCwd<CR>
" nnoremap <silent> s<C-d> :FufDir<CR>
nnoremap <silent> sn     :FufMruFile<CR>
" nnoremap <silent> sN     :FufMruFileInCwd<CR>
nnoremap <silent> sm     :FufMruCmd<CR>
" nnoremap <silent> su     :FufBookmarkFile<CR>
" nnoremap <silent> s<C-u> :FufBookmarkFileAdd<CR>
" vnoremap <silent> s<C-u> :FufBookmarkFileAddAsSelectedText<CR>
" nnoremap <silent> si     :FufBookmarkDir<CR>
" nnoremap <silent> s<C-i> :FufBookmarkDirAdd<CR>
" nnoremap <silent> st     :FufTag<CR>
" nnoremap <silent> sT     :FufTag!<CR>
" nnoremap <silent> s<C-]> :FufTagWithCursorWord!<CR>
" nnoremap <silent> s,     :FufBufferTag<CR>
" nnoremap <silent> s<     :FufBufferTag!<CR>
" vnoremap <silent> s,     :FufBufferTagWithSelectedText!<CR>
" vnoremap <silent> s<     :FufBufferTagWithSelectedText<CR>
" nnoremap <silent> s}     :FufBufferTagWithCursorWord!<CR>
" nnoremap <silent> s.     :FufBufferTagAll<CR>
" nnoremap <silent> s>     :FufBufferTagAll!<CR>
" vnoremap <silent> s.     :FufBufferTagAllWithSelectedText!<CR>
" vnoremap <silent> s>     :FufBufferTagAllWithSelectedText<CR>
" nnoremap <silent> s]     :FufBufferTagAllWithCursorWord!<CR>
" nnoremap <silent> sg     :FufTaggedFile<CR>
" nnoremap <silent> sG     :FufTaggedFile!<CR>
nnoremap <silent> so     :FufJumpList<CR>
nnoremap <silent> sp     :FufChangeList<CR>
nnoremap <silent> sq     :FufQuickfix<CR>
nnoremap <silent> sy     :FufLine<CR>
" nnoremap <silent> sh     :FufHelp<CR>
" nnoremap <silent> se     :FufEditDataFile<CR>
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
nnoremap <silent> wt :TagbarToggle<CR>
noremap <silent> <F10> :BufExplorer<CR>
noremap <silent> <m-F10> :BufExplorerHorizontalSplit<CR>
noremap <silent> <c-F10> :BufExplorerVerticalSplit<CR>


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

" session
" :mksession
" :source session-file

set sessionoptions=blank,buffers,sesdir,folds,help,options,tabpages,winsize,resize
nmap <F3> :mksession! ~/.vim/sessions/
nmap <C-F3> :so ~/.vim/sessions/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  mapleader
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

nmap <silent> <leader>er :e ~/.vimrc<CR>
" nmap <Leader>cr :!cscope -Rbq<CR>
" nmap <Leader>ct :!ctags -R --c++-kinds=+px --fields=+ilaS --extra=+q `pwd`<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  自定义命令
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"   设置成 Linux 下适用的格式
command! Lin setl ff=unix fenc=utf8 nobomb eol
"   设置成 Windows 下适用的格式
command! Win setl ff=dos fenc=gb18030

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  自动执行命令,与函数
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! LoadKernelTagsAndCscope()
	execute 'cs add ~/linux/cscope.out'
	execute 'set tags=~/linux/tags'
endfunction
nmap <silent> <leader>ck :call LoadKernelTagsAndCscope()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! LoadSysTags()
	execute 'cs kill cscope.out'
	execute 'set tags-=~/linux/tags'
	execute 'set tags+=~/.vim/systags'
endfunction
nmap <silent> <leader>ss :call LoadSysTags()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd! BufWritePost .vimrc source $HOME/.vimrc    " .vimrc编辑后重载

" Restore the last quit position when open file.
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \     exe "normal g'\"" |
     \ endif

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
    let max = 5
    let dir = './'
    let i = 0
    let break = 0
    while isdirectory(dir) && i < max
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
endf
nmap <F7> :call AutoLoadCTagsAndCScope()<CR>
" call AutoLoadCTagsAndCScope()
" http://vifix.cn/blog/vim-auto-load-ctags-and-cscope.html

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 插件配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set t_Co=256   " Explicitly tell vim that the terminal supports 256 colors,
let colorscheme = 'desert'
"let colorscheme = 'desertEx'
set background=dark

" 图形与终端
if has("gui_running")
  " 有些终端不能改变大小
  set columns=88
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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" g:SuperTabRetainCompletionType的值
" default为1，意为记住你上次的补全方式，直到使用其它的补全命令改变它；
" 为2，意味着记住上次的补全方式，直到按ESC退出插入模式为止；
" 为0，意味着不记录上次的补全方式。
" g:SuperTabDefaultCompletionType的值设置缺省的补全方式，缺省为CTRL-P。

let g:SuperTabRetainCompletionType = 2
" let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
let g:SuperTabDefaultCompletionType = "context"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-- omnicppcomplete setting --
" set completeopt=menu,menuone
let OmniCpp_MayCompleteDot = 1 " autocomplete with .
let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
let OmniCpp_SelectFirstItem = 2 " select first item (but don't insert)
let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files
let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype  in popup window
let OmniCpp_GlobalScopeSearch=1
let OmniCpp_DisplayMode=1
let OmniCpp_DefaultNamespaces=["std"]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Tagbar options
let g:tagbar_width = 35
let g:tagbar_expand = 0  "向外拓展
let g:tagbar_left = 1


" syntastic
nmap <leader>ee :Errors<CR>
let g:syntastic_check_on_open = 1
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_c_checkers = ['make']
" let g:syntastic_error_symbol = '✗'
" let g:syntastic_warning_symbol = '⚠'
let g:syntastic_auto_loc_list = 2
let g:syntastic_loc_list_height = 5
" set statusline+=%{SyntasticStatuslineFlag()}
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
" let g:syntastic_enable_highlighting = 0
" let g:syntastic_mode_map = { 'passive_filetypes': ['scss', 'slim'] }

let g:syntastic_mode_map = { 'mode': 'active',
			\ 'active_filetypes': ['c', 'python'],
			\ 'passive_filetypes': ['text','vim','mkd','puppet','scss', 'slim','ruby','php' ] }


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

hi User1 guifg=#eea040 guibg=#222222 ctermfg=6 ctermbg=0
hi User2 guifg=#dd3333 guibg=#222222 ctermfg=5 ctermbg=0
hi User3 guifg=#ff66ff guibg=#222222 ctermfg=4 ctermbg=0
hi User4 guifg=#a0ee40 guibg=#222222 ctermfg=1 ctermbg=0
hi User5 guifg=#eeee40 guibg=#222222 ctermfg=2 ctermbg=0

set statusline=
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%4*\ %t%m%r%h%w\ %*    "file name
set statusline +=%3*%Y\ %*              "file type
set statusline +=%5*[%{&ff}]\ %*        "file format
set statusline +=%3*%{''.(&fenc!=''?&fenc:&enc).''}\ %*
set statusline +=%3*\%{(&bomb?\",BOM\":\"\")}\ %*
set statusline +=%2*\ %{SyntasticStatuslineFlag()}%*
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%2*0x%04B\ %*          "character under cursor

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

nmap <C-c>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-c>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-c>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-c>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-c>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-c>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-c>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-c>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" 0 或 s: 查找本 C 符号
" 1 或 g: 查找本定义
" 2 或 d: 查找本函数调用的函数
" 3 或 c: 查找调用指定函数的函数
" 4 或 t: 查找字符串
" 6 或 e: 查找本 egrep 模式
" 7 或 f: 查找本文件
" 8 或 i: 查找包含本文件的文件

" cscope commands:
" add  : Add a new database             (Usage: add file|dir [pre-path] [flags])
" find : Query for a pattern            (Usage: find c|d|e|f|g|i|s|t name)
       " c: Find functions calling this function
       " d: Find functions called by this function
       " e: Find this egrep pattern
       " f: Find this file
       " g: Find this definition
       " i: Find files #including this file
       " s: Find this C symbol
       " t: Find assignments to
" help : Show this message              (Usage: help)
" kill : Kill a connection              (Usage: kill #)
" reset: Reinit all connections         (Usage: reset)
" show : Show connections               (Usage: show)


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

""cscope -Rbq

" 解决cscope与tag共存时ctrl+]有时不正常的bug
nmap <C-]> :tj <C-R>=expand("<cword>")<CR><CR>


" easymotion
let EasyMotion_leader_key = '<M-q>'
let EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'


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



" 单独切换打开NERD_tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugin - NERD_tree.vim 以树状方式浏览系统中的文件和目录
" :ERDtree 打开NERD_tree
" :NERDtreeClose 关闭NERD_tree
" o 打开关闭文件或者目录 t 在标签页中打开
" T 在后台标签页中打开 ! 执行此文件
" p 到上层目录 P 到根目录
" K 到第一个节点 J 到最后一个节点
" u 打开上层目录 m 显示文件系统菜单（添加、删除、移动操作）
" r 递归刷新当前目录 R 递归刷新当前根目录
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:NERDChristmasTree = 1  "色彩显示
let g:NERDTreNERDShowHidden = 1  "显示隐藏文件
let g:NERDTreeWinPos = 'left'  "窗口显示位置
let g:NERDTreeHighlightCursorline = 0  "高亮当前行
let g:NERDTreeWinSize = 30  "设置显示宽度
let NERDTreeChDirMode=0
let NERDTreeShowBookmarks=0


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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vim折叠功能
"
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
set foldmethod=indent
"要想在{ } 代码块中折叠，按空格键
"syntax 与 c.vim 中的 /cc 注释功能冲突

"关掉映射,经常带来麻烦
"nnoremap @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo') "使用空格打开或关闭折叠


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 文件比较
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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


"a.vim实现源文件与头文件切换

let alternateSearchPath = 'sfr:.,sfr:./include,sfr:../include,sfr:../inc' "设置include(.h)文件存在何处.
let alternateNoDefaultAlternate = 1 "当没有找到相应的.h文件时,不自动创建

"   使用方法
":A 切换当前文件的头文件,在当前窗口打开(或者反过来) "先打开.h .c 文件存于buff中
":AS 功能同:A,但是切换到水平分割窗口的打开
":AV 功能同:A,但是切换到竖直分割的窗口打开
":AT 功能同:A,但是切换到标签页打开


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugin - matchit.vim 对%命令进行扩展使得能在嵌套标签和语句之间跳转
" %              正向匹配
" g%            反向匹配
" [%            定位块首
" ]%             定位块尾
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


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

