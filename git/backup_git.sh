#!/bin/sh
# 将现存的 git 项目的地址提取并处理加入 ./git-list.sh 中形成获取git脚本
# set -x

DIR=$(pwd)
cd $DIR

# 依次进入各子目录，获取 git clone的地址，并组合成 reget_git.sh
for dis in $( ls -l | grep "^d" | awk '{print $9 }' )
do
	cd $dis
	echo
	echo "###########################################################"
	echo "enter $dis !"
	echo
	if [ -d ".git" ]; then
		git remote -v | grep 'fetch' | \
			awk '{print $2}' | \
			sed 's/^/git clone /' >> /tmp/git_source.sh ;
	elif [ -d ".hg" ]; then
		cd .hg
		cat hgrc | grep $dis | \
			awk '{print $3}' | \
			sed 's/^/hg clone /' >> /tmp/git_source.sh
		cd ..
	else
		echo $dis >> $DIR/nobackup.list
	fi
	cd ..
done

sort /tmp/git_source.sh | uniq > $DIR/git_source.sh
rm /tmp/git_source.sh
