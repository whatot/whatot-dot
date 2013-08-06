# [原创]安装vim代码补全工具YouCompleteMe

http://cfylee.me/YouCompleteMeInstall.html

由于受不了ubuntu越来越难用的桌面环境，最近重装了我的linux系统，由ubuntu12.04 LTS换成 了opensuse12.3，前段时间看到一个vim的代码补全工具叫YouCompleteMe，觉得很不错，但是安 装比较麻,烦自己的vim版本还比较低就没有安装，现在opensuse12.3的vim版本能安装，就乘着周 末的时间折腾了下，走了许多弯路，最后终于安装成功，下面就把我的安装过程记录一下。
# 准备

1. 检查您的vim版本，vim版本要求在7.3.584以上，并且要求python2.x的支持，opensuse12 .3的默认vim7.3.831，达到了要求，但是不支持python2.x，所以要先卸载默认的vim，重新 编译安装vim时加上python支持，不过opensuse的源里又一个vim-enhaced的版本支持python ，所以直接安装它就好了。

	sudo zypper remove vim
	sudo zypper install vim-enhaced

	sudo apt-get install ....

2. 安装clang，clang的版本必须在3.2之上,这里很重要，直接关乎你安装好YouCompleteMe插件 后能不能用，安装clang的原因是clang中有一个叫libclang.so的动态链接库，需要给该插件 提供语法解析的支持，ubuntu系统可以直接下载clang官网上的llvm+clang的二进制，其他系 统最好还是用不同发行版自己的软件管理器来安装比较好，我的opensuse系统下载使用ubuntu 的clang二进制中的libclang.so用不了，我在这里耗费了很长时间才解决了libclang.so无法 使用的问题。

	sudo zypper install llvm-clang

3. 安装cmake和python-dev

    sudo zypper install cmake
    sudo zypper install python-devel

4. 安装YouCompleteMe插件，可以使用bundle(vim插件管理器)来安装YouCompleteMe在你的.vimrc加 ``Bundle 'Valloric/YouCompleteMe'``，然后启动vim.输入``:BundleInstall``安装完成之后，准备 工作就算完成了:)

# 编译ycm_core.so

1. 搭建ycm_core.so的编译环境，yum_core.so是vim 调用libclang.so的库，将/usr/lib/libclang.so 拷贝到~/.vim/bundle/YouCompleteMe/python，新建ycm_temp文件夹,用cmake生成makefile：

    cmake -G "Unix Makefiles" -DEXTERNAL_LIBCLANG_PATH=/usr/lib/libclang.so . ~/.vim/bundle/YouCompleteMe/cpp

2. 编译yum_core.so

    make ycm_core

3. 配置.ycm_extra_conf.py,这配置文件是有关补全规则的，可以根据自己工程的实际情况自己配置并 在.vimrc中加上它的路径,.yum_extra_conf.py的模板在/home/user/.vim/bundle/YouCompleteMe/cpp/ycm/ 它满足了99%的需要(文档里是这么说的:P),之后YouCompleteMe就安装完成了。

    let g:ycm_global_ycm_extra_conf =  'path'  //在.vimrc中加入这句



------------------------

http://rickey-nctu.blogspot.com/2013/05/vim-youcompleteme.html

$ sudo add-apt-repository ppa:fcwu-tw/ppa
$ sudo apt-get update
$ sudo apt-get install vim

$ sudo apt-get install build-essential cmake python-dev
$ cd ~/.vim/bundle
$ git clone https://github.com/Valloric/YouCompleteMe
$ cd ~/.vim/bundle/YouCompleteMe
$ ./install.sh --clang-completer

