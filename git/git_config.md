## git config

### color , the first one is enough

	git config --global color.ui auto

	git config --global color.branch auto
	git config --global color.diff auto
	git config --global color.interactive auto
	git config --global color.status auto


### user information

	git config user.name xxx
	git config user.email xxx@xxx.com

**or**

	git config --global user.name xxx
	git config --global user.email xxx@xxx.com


### prefer

	git config --global core.editor vim
	git config --global merge.tool meld
	git config --global core.paper "less -N"


### git-completion in ~/.bash_profile

	http://repo.or.cz/w/git.git/blob_plain/HEAD:/contrib/completion/git-completion.bash

	if [ -f ~/.git-completion.bash ]; then
	. ~/.git-completion.bash
	fi


### alias in ~/.bash_profile

	alias ga='git add'
	alias gp='git push'
	alias gl='git log'
	alias gs='git status'
	alias gd='git diff'
	alias gm='git commit -m'
	alias gma='git commit -am'
	alias gb='git branch'
	alias gc='git checkout'
	alias gra='git remote add'
	alias grr='git remote rm'
	alias gpu='git pull'
	alias gcl='git clone'

	complete -o default -o nospace -F _git_branch gb
	complete -o default -o nospace -F _git_checkout gc


### Bash Prompt Branch Name in ~/.bash_profile

	green=$(tput setaf 2)
	blue=$(tput setaf 4)
	bold=$(tput bold)
	red=$(tput setaf 1)
	reset=$(tput sgr0)
	PS1='\u@\[$green\]\h\[$reset\]:\w\[$blue\]$(__git_ps1)\[$reset\] \$ '


### password input

	git config --global credential.helper=cache --timeout 3600


### push

	git config --global push.default matching

current           -- push current branch to branch of same name
matching          -- push all matching branches
nothing           -- do not push anything
tracking          -- push current branch to its upstream branch
 (current)   (default)


### git 中文转义

	git config core.quotepath false
