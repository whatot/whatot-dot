set fileencodings=utf-8,gb18030,gbk,gb2312,latin1
set encoding=utf-8
"let &termencoding=&encoding

filetype plugin indent on
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
"set nowrapscan             " 搜索不回绕,默认回绕
set wrap                    " 自动换行显示
"set autochdir              " 自动切换当前目录为当前文件所在的目录
set autoread                " 自动读取改变了的编辑中的文件
set scrolljump=1            " 当光标达到上端或下端时 翻滚的行数
set sidescroll=5            " 当光标达到水平极端时 移动的列数
set scrolloff=5             " 当光标距离极端(上,下,左,右)多少时发生窗口滚
set clipboard+=unnamed      " 与Windows共享剪贴板
set diffopt=context:3       " 设置不同之处显示上下三行
set foldmethod=indent
set foldlevel+=8            " 设置较大的foldlevel使得所有折叠被默认展开
                            " zr/zm zR/zM zc/zo zC/zO zd/zD [z ]z zj/zk
set switchbuf=usetab        " 如果包含，跳到第一个打开的包含指定缓冲区的窗口,
                            " 也考虑其它标签页里的窗口

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

autocmd FileType c set tabstop=4 shiftwidth=4 noexpandtab
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set pastetoggle=<F5> " when in insert mode, press <F5> to go to
" paste mode, where you can paste mass data that won't be autoindented

" disbale paste mode when leaving insert mode
au InsertLeave * set nopaste

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
noremap <S-Del> "+p
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

" 补全最长项
inoremap <expr> <C-L> pumvisible()?"\<C-E>\<C-N>":"\<C-N>"


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
    let dir = './'
    let i = 0
    let break = 0
    while isdirectory(dir) && i < max
        if filereadable(dir . 'GTAGS')
            execute 'cs add ' . dir . 'GTAGS ' . glob("`pwd`")
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
" let colorscheme = 'desert'
" let colorscheme = 'desertEx'
set background=dark

if has("gui_running")
    let colorscheme = 'desert'
else
    let colorscheme = 'desert256'
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
" set statusline +=%2*\ %{SyntasticStatuslineFlag()}%*
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%2*0x%04B\ %*          "character under cursor


":vertical diffsplit FILE_RIGHT "与已打开的文件进行比较
"设置不同之处显示上下三行
"set diffopt=context:3

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
