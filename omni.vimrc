set fileencodings=utf-8,gb18030,gbk,gb2312,latin1
set encoding=utf-8
"let &termencoding=&encoding

filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'gmarik/vundle'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle ''
" g:SuperTabRetainCompletionType的值
" default为1，意为记住你上次的补全方式，直到使用其它的补全命令改变它；
" 为2，意味着记住上次的补全方式，直到按ESC退出插入模式为止；
" 为0，意味着不记录上次的补全方式。
" g:SuperTabDefaultCompletionType的值设置缺省的补全方式，缺省为CTRL-P。
let g:SuperTabRetainCompletionType = 2
" let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
let g:SuperTabDefaultCompletionType = "context"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
filetype plugin indent on    " required!
syntax on

source common.vimrc
