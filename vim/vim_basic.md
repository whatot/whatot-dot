# vim_basic tips

http://vim-scripts.org/index.html

主要来源：[Git时代的VIM不完全使用教程](http://beiyuu.com/git-vim-tutorial/)

## VIM的模式

第一次使用VIM，会觉得无所适从，他并不像记事本，你敲什么键就显示什么，理解VIM的需要明白他的两种模式： - 命令模式 (Command Mode) - 编辑模式 (Insert Mode)

命令模式下，可以做移动、编辑操作；编辑模式则用来输入。键入i,o,s,a等即可进入编辑模式，后面解释原因。

模式的设计是VIM和其他编辑器最不同的地方，优势和劣势也全基于此而生。

## 基本操作

以下介绍的键盘操作，都是大小写敏感的，并且要在命令模式下完成，需注意：

### 以字为单位的移动

    h 向左移动一个字
    j 向下移动一行
    k 向上
    l 向右

这四个键在右手最容易碰到几个位置，最为常用。

### 以词为单位的移动

    w 下一個word w(ord)
    W 下一個word(跳过标点)
    b 前一個word b(ackward)
    B 前一个word(跳过标点)
    e 跳到当前word的尾端 e(nd)

### 行移动

    0 跳到当前行的开头
    ^ 跳到当前行第一个非空字符
    $ 跳到行尾

助记：0(第0个字符),^和$含义同正则表达式

### 段落移动

    { 上一段(以空白行分隔)
    } 下一段(以空白行分隔)
    % 跳到当前对应的括号上(适用各种配对符号)

### 跳跃移动

    /xxxx 搜索xxxx，然后可以用n下一个，N上一个移动
    # 向前搜索光标当前所在的字
    * 向后搜索光标当前所在的字
    fx 在当前行移动到光标之后第一个字符x的位置 f(ind)x
    gd 跳到光标所在位置词(word)的定义位置 g(o)d(efine)
    gg 到文档顶部
    G 到文档底部
    :x 跳到第x行(x是行号)
    ctrl+d 向下翻页 d(down)
    ctrl+u 向上翻页 u(p)

## 基本编辑

### 修改

    i 在光标当前位置向前插入 i(nsert)
    I 在本行第一个字符前插入
    a 在光标当前位置向后插入 a(fter)
    A 在本行末尾插入
    o 向下插入一行
    O 向上插入一行
    :w 保存
    :q 退出
    :wq 保存并退出

### 删除

    x 删除当前字符
    dd 删除当前行 d(elete)
    dw 删除当前光标下的词 d(elete)w(ord)

### 复制粘贴

    yy 复制当前行 y(ank)
    yw 复制当前光标下的词 y(ank)w(ord)
    p 粘贴 p(aste)
    P 粘贴在当前位置之前

## 进阶操作

限于篇幅，在这里我仅介绍下我非常常用的几个操作。

### 重复操作

因为VIM所有的操作都是原子化的，所以把这些操作程序化就非常简单了：

    5w 相当于按五次w键；
    6j 下移6行，相当于按六次j；
    3J 大写J,本来是将下一行与当前行合并，加上数量，就是重复操作3次；
    6dw和d6w 结果是一样，就是删除6个word；
    剩下的无数情况，自己类推吧。

### 高效编辑

    di" 光标在""之间，则删除""之间的内容
    yi( 光标在()之间，则复制()之间的内容
    vi[ 光标在[]之间，则选中[]之间的内容
    以上三种可以自由组合搭配，效率奇高，i(nner)
    dtx 删除字符直到遇见光标之后的第一个x字符
    ytx 复制字符直到遇见光标之后的第一个x字符

### 标记和宏(macro)

    ma 将当前位置标记为a，26个字母均可做标记，mb、mc等等；
    'a 跳转到a标记的位置；
    这是一组很好的文档内标记方法，在文档中跳跃编辑时很有用；
    qa 将之后的所有键盘操作录制下来，直到再次在命令模式按下q，并存储在a中；
    @a 执行刚刚记录在a里面的键盘操作；
    @@ 执行上一次的macro操作；
    宏操作是VIM最为神奇的操作之一，需要慢慢体会其强大之处；

VIM的基本操作，可以挖掘的东西非常多，不仅仅需要记忆，更需要自己去探索总结，熟练之后，效率会大幅度提升。后面会给出一些参考链接。

## 插件管理

### Vundle

终于到这篇Blog我最想讨论的部分了。VIM的强大不仅仅体现在操作的高效率，更有强大而充沛的插件做支援，插件丰富了之后，就面临查找和管理的问题。

在遇见[ Vundle ](https://github.com/gmarik/vundle)之前，我用[ Pathogen ](https://github.com/tpope/vim-pathogen)管理插件。Pathogen还算方便，只需要把相应插件，放在bundle目录下即可，不需要再像以前那样逐个放置单独的文件到相应目录，大大节省了劳动力，管理起来也一目了然，觉得还不错，至少比vimball那种需要执行命令安装的方式好一些。

我真希望我早些遇见Vundle。Vundle受到Pathogen和Vimball的启发，于是有了现在的模样。Vundle的逻辑是这样的：

* 在[Vim Script](http://vim-scripts.org/vim/scripts.html)选好你想要的插件；
* 在VIM的配置文件中写一句 Bundle plugin_name；
* 执行一下Vundle的初始化命令，插件就装好了；
* 升级和卸载也是同样的简单；

完美的世界！

### Vundle的配置

Vundle的安装很简单：

    git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

然后写配置文件.vimrc：

    set nocompatible " be iMproved
    filetype off " required!
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
    " let Vundle manage Vundle
    " required!
    Bundle 'gmarik/vundle'
    " vim-scripts repos
    Bundle 'vim-plugin-foo'
    Bundle 'vim-plugin-bar'
    filetype plugin indent on " required!

其中Bundle后面的内容，就是插件的名字，插件维护在[Vim-Script.org](http://vim-scripts.org/vim/scripts.html)。

然后，打开VIM之后，可以输入以下命令：

    "安装插件:
    :BundleInstall
    "更新插件:
    :BundleInstall!
    "卸载不在列表中的插件:
    :BundleClean

现在大部分的插件都已经从[Vim.org](http://www.vim.org/scripts/index.php)迁移到了[Vim-Script.org](http://vim-scripts.org/vim/scripts.html)，而且很多作者也认领了自己的插件，直接在这个Github的项目下更新，一个比Vim.org更科学更有效的生态环境，就这样完美的形成了。

在此非常严重的感谢vim-scripts.org的创建者[Scott Bronson](https://github.com/bronson)，和[ Vundle ](https://github.com/gmarik/vundle)的作者[gmarik](https://github.com/gmarik)。他们的创新和分享精神，让这个世界又美好了一些。

也感谢业界良心[Github](https://github.com/)。Vim-Scripts.org整站就是用[Github Pages](https://pages.github.com/)建立维护的，对于个人来说，这是很好的选择，有兴趣的同学可以参看我之前的博客：
[使用Github Pages建独立博客](http://beiyuu.com/github-pages/)。

## 插件介绍

## more links

* [Practical Vim](http://book.douban.com/subject/10599776/)，强烈推荐的一本系统介绍VIM的书籍
* [Vim Cheat Sheet](http://overapi.com/vim/)，有VIM的各种助记图，可以作为桌面
* [Vimer的程序世界](http://www.vimer.cn/)，不错的站，博主持续钻研VIM各种技巧
* [网友狂人收集的vim资料链接](http://hi.baidu.com/whqvzhjoixbbdwd/item/11315a5073667d0de6c4a5e9)
* [Best of Vim Tips](http://www.rayninfo.co.uk/vimtips.html)
* [面向前端开发者和TextMate粉丝的vim配置](http://www.limboy.com/2009/05/30/vim-setting/)
* [Vim代码折叠简介](http://scmbob.org/vim_fdm.html)
* [挑選 Vim 顏色(Color Scheme)](http://blog.longwin.com.tw/2009/03/choose-vim-color-scheme-2009/)
* [vimium](https://chrome.google.com/webstore/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb)，用VIM的操作习惯来控制Chrome的插件
