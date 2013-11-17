#!/bin/sh
# 将现存的 git 项目的地址提取并处理加入 git_source.sh, git_source_big.sh
# set -x

tmp_address=''
MAX_SMALL=100000
NORMAL_ADDRESS_FILE='normal_gitsrc.sh'
BIG_ADDRESS_FILE='big_gitsrc.sh'

DIR=$(pwd)
cd $DIR

echo

# 依次进入各子目录，获取 git clone / hg clone 的地址，并组合成
# NORMAL_ADDRESS_FILE, BIG_ADDRESS_FILE
for dis in $( ls -l | grep "^d" | awk '{print $9 }' )
do
	cd $dis
	echo "###########################################################"
	echo "enter $dis !"
	echo

	# 将对应地址赋值到tmp_address中
	if [ -d ".git" ]; then
		tmp_address=`git remote -v | grep 'fetch' | \
			awk '{print $2}' | \
			sed 's/^/git clone /' `
	elif [ -d ".hg" ]; then
		tmp_address=`cat .hg/hgrc | grep $dis | \
			awk '{print $3}' | \
			sed 's/^/hg clone /' `
	else
		echo $dis >> $DIR/nobackup.list
	fi

	# 按大小将地址存放到不同文件中
	if (( $(du -s . | awk '{print $1}') > $MAX_SMALL )); then
		echo $tmp_address >> /tmp/$BIG_ADDRESS_FILE ;
	else
		echo $tmp_address >> /tmp/$NORMAL_ADDRESS_FILE ;
	fi
	tmp_address=''

	cd ..
done

# 行排序，去空行，去重复行后复制到当前目录，覆盖原文件，去除临时文件
sort /tmp/$NORMAL_ADDRESS_FILE| sed /^$/d | uniq > $DIR/$NORMAL_ADDRESS_FILE
sort /tmp/$BIG_ADDRESS_FILE | sed /^$/d | uniq > $DIR/$BIG_ADDRESS_FILE
rm /tmp/$NORMAL_ADDRESS_FILE
rm /tmp/$BIG_ADDRESS_FILE
