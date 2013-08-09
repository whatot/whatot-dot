# GNU GLOBAL Source Code Tag System

http://blog.csdn.net/sencha_android/article/details/6878351

1. 下载GLOBAL
http://www.gnu.org/software/global/global.html
http://www.gnu.org/software/global/globaldoc.html

2. 编译安装
./configure --prefix=[your install dir]
make
make install

3. 使用时注意先gtags后htags，如果直接执行htags会提示找不到gtags。

如果是在普通用户权限安装global，比如--prefix=/work/yourname/usr目录下，安装以后有如下目录：bin,include,lib,share，需将bin目录设置到~/.bashrc中，这样就可以在任何路径下使用gtags和htags了。

	$cd your_src_dir
	$gtags           # make tag files(GTAGS,GRTAGS,GSYMS)
	$htags -v        # make hypertext(HTML/)

这样，打开HTML下的index.html文件就可以开始浏览了。

"htags -fcFnvta"生成ghtml,并将它们放入apache的html目录。 -f(支持cgi动态搜索) -c(压缩生成html) -F(使用frame风格) -n(行号） -a(制作Function索引) -t（欢迎标题:随意输入"Welcome into kernel tour"). "，可以直接用htags -Fnvta或者gtags -v && htags -sofFnvaIht 'welcome to android eclair tour'

	$ gtags -v
	$ htags -sanohITvt 'Welcome to XXX source tour!'
	$ firefox HTML/index.html

	$ htags --suggest

	$ cflow --tree --format=posix *.[ch] >cflow.out
	$ htags --cflow=cflow.out

http://www.gnu.org/software/global/globaldoc.html

---------------------------------------

# 介绍一下gnu global，比cscope更方便更快速的索引工具

http://forum.ubuntu.org.cn/viewtopic.php?t=343460

global、gtags、gtags-cscope三个命令。global是查询，gtags是生成索引文件，gtags-cscope是与cscope一样的界面

	$ cd project/
	$ gtags

这样就生成了整个目录的索引文件，包括GTAGS、GRTAGS、GPATH三个文件。

你也可以先用find命令生成一个文件列表，叫gtags.files，然后再执行gtags，就会只索引gtags.files里的文件。

	$ cd project/
	$ find . -name "*.[ch]" > gtags.files
	$ gtags

查询使用的命令是global和gtags-cscope。前者是命令行界面，后者是与cscope兼容的ncurses界面。这里就不多介绍了，重点是如何在vim里查询：

首先进入vim，然后:

	:set cscopeprg=gtags-cscope
	:cs add GTAGS

然后就可以像cscope一样，用cs find g等命令进行查询了。

当我们更改了某个文件以后，比如project/subdir1/subdir2/file1.c，想更新索引文件(索引文件是project/GTAGS)，只消这样：

	$ cd project/subdir1/subdir2/
	$ vim file1.c
	$ global -u

global -u这个命令会自动向上找到project/GTAGS，并更新其内容。而gtags相对于cscope的优势就在这里：增量更新单个文件的速度极快，几乎是瞬间完成。有了这个优势，我们就可以增加一个autocmd，每次:w的时候自动更新索引文件。

我的设置如下：

	" settings of cscope.
	" I use GNU global instead cscope because global is faster.
	set cscopetag
	set cscopeprg=gtags-cscope
	set cscopequickfix=c-,d-,e-,f-,g0,i-,s-,t-
	nmap <silent> <leader>j <ESC>:cstag <c-r><c-w><CR>
	nmap <silent> <leader>g <ESC>:lcs f c <c-r><c-w><cr>:lw<cr>
	nmap <silent> <leader>s <ESC>:lcs f s <c-r><c-w><cr>:lw<cr>
	command! -nargs=+ -complete=dir FindFiles :call FindFiles(<f-args>)
	au VimEnter * call VimEnterCallback()
	au BufAdd *.[ch] call FindGtags(expand('<afile>'))
	au BufWritePost *.[ch] call UpdateGtags(expand('<afile>'))

	function! FindFiles(pat, ...)
		let path = ''
		for str in a:000
			let path .= str . ','
		endfor

		if path == ''
			let path = &path
		endif

		echo 'finding...'
		redraw
		call append(line('$'), split(globpath(path, a:pat), '\n'))
		echo 'finding...done!'
		redraw
	endfunc

	function! VimEnterCallback()
		for f in argv()
			if fnamemodify(f, ':e') != 'c' && fnamemodify(f, ':e') != 'h'
				continue
			endif

			call FindGtags(f)
		endfor
	endfunc

	function! FindGtags(f)
		let dir = fnamemodify(a:f, ':p:h')
		while 1
			let tmp = dir . '/GTAGS'
			if filereadable(tmp)
				exe 'cs add ' . tmp . ' ' . dir
				break
			elseif dir == '/'
				break
			endif

			let dir = fnamemodify(dir, ":h")
		endwhile
	endfunc

	function! UpdateGtags(f)
		let dir = fnamemodify(a:f, ':p:h')
		exe 'silent !cd ' . dir . ' && global -u &> /dev/null &'
	endfunction


解释几句：

1. 我增加了一个命令叫FindFiles，是用来生成gtags.files文件的，用法如下:

	:FindFiles {pattern} subdir1 subdir2 ...

然后找到的文件就会都添加到当前buffer的最后。

比如，我们用git刚下下来一整套kernel的源码，放在linux-2.6目录下，然后我想生成列表文件，就可以这样：

	:e gtags.files
	:FindFiles **/*.[ch] arch/x86 arch/arm block crypto ...
	:w

只增加自己想要的目录，而不要的就不增加。

2. 我添加了三条autocmd，其中：

	au VimEnter * call VimEnterCallback()
	au BufAdd *.[ch] call FindGtags(expand('<afile>'))

这两条命令会在你打开一个c文件的时候，自动向上查找GTAGS文件，找到以后就会执行:cs add命令添加这个GTAGS文件。

	au BufWritePost *.[ch] call UpdateGtags(expand('<afile>'))

这条命令会在你修改一个c文件并:w以后，自动进入c文件所在目录并执行"global -u"更新索引文件。

最后，还有一个问题，cscope有一个-f参数，这个参数可以指定cscope.out文件的路径。而gtags-cscope的哲学不一样，它是自己一路向上寻找GTAGS文件，所以没有-f参数。而vim调用:cs add的时候，是会使用-f参数的。这样，当:cs add GTAGS文件的时候，就不能指定当前目录的子目录以外的路径。这也导致:cs add命令只能使用一个GTAGS文件。

针对这个问题，我写了一个vim的patch
http://forum.ubuntu.org.cn/viewtopic.php?f=68&t=342099
，在fork出gtags-cscope子进程以后会把子进程chdir()到GTAGS文件所在的目录，这样就OK了。

