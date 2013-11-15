##git使用说明

Linus为Linux Kernel Project发起的版本控制项目。

* HEAD代表当前最新状态。
* tag为某个状态的标签。
* SHA1为每个提交日志的唯一标识。



###install:

* apt-get install git-core
* yum install git
* pacman -S git



###git clone:

git仓库可以使用git clone获得：

	git clone git://url

也可以通过浏览器浏览。

	http://url/gitweb/

通过git pull更新仓库. 使用git init-db初始化自己的仓库。



###config:

开发人员需要为git仓库配置相关信息. 这样在提交代码时. 这些信息会自动
反映在git仓库的日志中。

	git config user.name "your name"
	git config user.email yourname@email_server
	git config core.editor vim
	git config core.paper "less -N"
	git config color.diff true
	git config alias.co checkout

git config alias表示. 可以用git co代表git checkout。
git var -l可以查看已经设置的配置。



###diff:

开发人员在本地进行开发后. 可以使用git diff查看改动。
除了直接比较当前开发后的改动外. git diff还可以：

	git diff tag                    比较tag和HEAD之间的不同。
	git diff tag file               比较一个文件在两者之间的不同。
	git diff tag1..tag2             比较两个tag之间的不同。
	git diff SHA11..SHA12           比较两个提交之间的不同。
	git diff tag1 tag2 file or
	git diff tag1:file tag2:file    比较一个文件在两个tag之间的不同。


ORIG_HEAD用于指向前一个操作状态. 因此在git pull之后如果想得到pull的内容就可以：

	git diff ORIG_HEAD

	git diff --stat                 用于生成统计信息。
	git diff --stat ORIG_HEAD



###apply:

	git apply相当于patch命令。
	--check 检查能否正常打上补丁. -v verbose模式.  -R reverse模式. 反打补丁。



###log:

	git log file                    查看一个文件的改动。
	git log -p                      查看日志和改动。
	git log tag1..tag2              查看两个tag之间的日志。
	git log -p tag1..tag2 file      查看一个文件在两个tag之间的不同。
	git log tag..                   查看tag和HEAD之间的不同。



###commit:

	git commit -a -e        提交全部修改文件. 并调用vim编辑提交日志。
	git reset HEAD^ or
	git reset HEAD~1        撤销最后一次提交。
	git reset --hard HEAD^  撤销最后一次提交并清除本地修改。
	git reset SHA1          回到SHA1对应的提交状态。



###add/delete/ls:

	git add -a              添加所有文件。除了.gitignore文件中的文件。
	git rm file             从git仓库中删除文件。
	git commit              添加或是删除后要提交。

	git ls-files -m         显示修改过的文件。
	git ls-files            显示所有仓库中的文件。

git中有四种对象：blob、tree、commit、tag。

blob代表文件. tree代表目录. commit代表提交历史. tag代表标签。

这四种对象都是由SHA1值表示的。在仓库的.git目录中保存了git管理仓库所需要的全部信息。

	git ls-tree HEAD file   显示file在HEAD中的SHA1值。
	git cat-file -t SHA1    显示一个SHA1的类型。
	git cat-file type SHA1  显示一个SHA1的内容。type是blob、tree、commit、tag之一。



###patch:

	git format-patch -1     生成最后一个提交对应的patch文件。
	git am < patch          把一个patch文件加入git仓库中。
	git am --resolved       如果有冲突. 在解决冲突后执行。
	git am --skip           放弃当前git am所引入的patch。



###conflict:

	git merge               用于合并两个分支。
	git diff                如果有冲突. 直接使用diff查看.
				冲突代码用<<<和>>>表示。手动修改冲突代码。
	git update-index        更新修改后的文件状态。
	git commit -a -e        提交为解决冲突而修改的代码。



###branch:

	git branch -a           查看所有分支。
	git branch new_branch   创建新的分支。
	git branch -d branch    删除分支。
	git checkout branch     切换当前分支。-f参数可以覆盖未提交内容。



###daemon:

有时更新公共代码仓库使用patch的方式. 或者直接
用``git pull git://ip/repo branch``
的方式更新每个人的代码。使用``git pull``的方式需要
提交代码的机器运行：
``git daemon --verbose --export-all --enable=receive-pack --base-path=/repo``



###request-pull:

	git request-pull start url      用于产生本次pull请求的统计信息。



###clean:

	git clean -dxf          用于清除未跟踪文件。
	git clean -dnf          可以显示需要删除的文件. 但不包括被.gitignore忽略的。
	git reset --hard HEAD   用于清除跟踪文件的修改。



-------------------------------------------------------------------------

## SVN. HG. GIT命令对照

2013-07-15

SVN. HG. GIT是三种常见的版本控制系统. 本文简单列出一些相似的操作命令。当然. 三种系统各有特点. 严格的对应关系是没有的。

1. 第一次下载. 包括源码和版本库：
svn checkout http://path/to/repo repo_name
hg clone http://path/to/repo  repo_name
git glone http://path/to/repo repo_name或者git glone git://path/to/repo repo_name

2. 下载服务器上最新的更新：
svn update
hg pull && hg update -C
git pull

3. 检出某个修订版本
svn checkout -r <rev>
hg update -C -r <rev>
git reset --hard -r <rev>

4. 新增被跟踪文件
svn add /path/to/file
hg add /path/to/file
git add /path/to/file

4. 移除被跟踪文件
svn rm /path/to/file
hg remove /path/to/file
git rm /path/to/file

5. 生成补丁
svn diff  >patch_file
hg diff >patch_file
git diff >patch_file

6. 提交更改
svn commit
hg commit
git commit + git push

6. 查看当前状态
svn info
hg status
git status

7. 查看修订记录
svn log
hg log
git log

8. 启动服务器
svnserve -d
hg serve -p 8002 &
git daemon --base-path=/path/to/repo --export-all &


## Git常用操作命令收集：

### 1) 远程仓库相关命令

检出仓库：$ git clone git://github.com/jquery/jquery.git
查看远程仓库：$ git remote -v
添加远程仓库：$ git remote add [name] [url]
删除远程仓库：$ git remote rm [name]
修改远程仓库：$ git remote set-url --push [name] [newUrl]
拉取远程仓库：$ git pull [remoteName] [localBranchName]
推送远程仓库：$ git push [remoteName] [localBranchName]

* 如果想把本地的某个分支test提交到远程仓库. 并作为远程仓库的master分支. 或者作为另外一个名叫test的分支. 如下：
$ git push origin test:master         // 提交本地test分支作为远程的master分支
$ git push origin test:test              // 提交本地test分支作为远程的test分支

### 2）分支(branch)操作相关命令

查看本地分支：$ git branch
查看远程分支：$ git branch -r （如果还是看不到就先 git fetch origin 先）
创建本地分支：$ git branch [name] ----注意新分支创建后不会自动切换为当前分支
切换分支：$ git checkout [name]
创建新分支并立即切换到新分支：$ git checkout -b [name]
直接检出远程分支：$ git checkout -b [name] [remoteName] (如：git checkout -b myNewBranch origin/dragon)
删除分支：$ git branch -d [name] ---- -d选项只能删除已经参与了合并的分支. 对于未有合并的分支是无法删除的。如果想强制删除一个分支. 可以使用-D选项
合并分支：$ git merge [name] ----将名称为[name]的分支与当前分支合并
合并最后的2个提交：$ git rebase -i HEAD~2 ---- 数字2按需修改即可（如果需提交到远端$ git push -f origin master 慎用！）
创建远程分支(本地分支push到远程)：$ git push origin [name]
删除远程分支：$ git push origin :heads/[name] 或 $ git push origin :[name]

* 创建空的分支：(执行命令之前记得先提交你当前分支的修改. 否则会被强制删干净没得后悔)
$ git symbolic-ref HEAD refs/heads/[name]
$ rm .git/index
$ git clean -fdx

### 3）版本(tag)操作相关命令

查看版本：$ git tag
创建版本：$ git tag [name]
删除版本：$ git tag -d [name]
查看远程版本：$ git tag -r
创建远程版本(本地版本push到远程)：$ git push origin [name]
删除远程版本：$ git push origin :refs/tags/[name]
合并远程仓库的tag到本地：$ git pull origin --tags
上传本地tag到远程仓库：$ git push origin --tags
创建带注释的tag：$ git tag -a [name] -m 'yourMessage'

### 4) 子模块(submodule)相关操作命令

添加子模块：$ git submodule add [url] [path]
    如：$ git submodule add git://github.com/soberh/ui-libs.git src/main/webapp/ui-libs
初始化子模块：$ git submodule init  ----只在首次检出仓库时运行一次就行
更新子模块：$ git submodule update ----每次更新或切换分支后都需要运行一下
删除子模块：（分4步走哦）
1) $ git rm --cached [path]
2) 编辑“.gitmodules”文件. 将子模块的相关配置节点删除掉
3) 编辑“ .git/config”文件. 将子模块的相关配置节点删除掉
4) 手动删除子模块残留的目录

### 5）忽略一些文件、文件夹不提交

在仓库根目录下创建名称为“.gitignore”的文件. 写入不需要的文件夹名或文件. 每个元素占一行即可. 如
target
bin
*.db

### 6）后悔药

删除当前仓库内未受版本管理的文件：$ git clean -f
恢复仓库到上一次的提交状态：$ git reset --hard
回退所有内容到上一个版本：$ git reset HEAD^
回退a.py这个文件的版本到上一个版本：$ git reset HEAD^ a.py
回退到某个版本：$ git reset 057d
将本地的状态回退到和远程的一样：$ git reset –hard origin/master
向前回退到第3个版本：$ git reset –soft HEAD~3

### 7）Git一键推送多个远程仓库

编辑本地仓库的.git/config文件：
[remote "all"]
    url = git@github.com:dragon/test.git
    url = git@gitcafe.com:dragon/test.git
这样. 使用git push all即可一键Push到多个远程仓库中。

>资料参考：
Git Submodule 的認識與正確使用！
如何保持在 Git Submodule 代码的开放和私有共存
Git Submodule Tutorial
删除 git submodule
pages.github.com
Git获取远程分支
Git for Windows Unicode Support
Git一键推送多个远程仓库
图解Git
使用git合并多个提交
git:多个commit合并提交
git merge 和git rebase
版本控制系統 Git 精要
说明：Git for Windows 从 1.7.9 版本开始支持使用中文文件、文件夹名称了. 结束了跨平台中文乱码的问题。
