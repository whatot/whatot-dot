set fileencodings=utf-8,gb18030,gbk,gb2312,latin1
set encoding=utf-8
"let &termencoding=&encoding

filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'gmarik/vundle'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'Valloric/YouCompleteMe'
let g:syntastic_c_checker='youcompleteme'
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_complete_in_comments_and_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>']
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger = "<C-\>"
let g:UltiSnipsJumpForwardTrigger = "<C-\>"
let g:UltiSnipsSnippetDirectories=["snippets", "bundle/UltiSnips/UltiSnips"]
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on    " required!
syntax on

source common.vimrc
