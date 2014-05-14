#!/bin/bash
# 进入~/git/,分别将各git版本库更新到最新
# 2012-10-05-01:26
# set -x

function update_git_hg ()
{
	cd $1

	local if_success
	if [[ -d ".git" ]]; then
		git pull && git submodule update --init --recursive
		if_success=$?
		echo "updated $1 !"
		echo
		if [[ $if_success != 0 ]]; then
			echo $1 >> /tmp/upgrade_git_error.log
		fi
	fi

	if [[ -d ".hg" ]]; then
		hg pull & hg update
		echo "update $1 !"
	fi

	cd ..
}

function usage_exit()
{
	echo "Usage :"
	echo "./upgrade_git.sh DIR           update all the git repos in this DIR"
	echo "./upgrade_git.sh -h,--help     print this Usage"

	exit
}

# where to start
if [[ -n "$1" ]];then
	if [[ $1 == '-h' ]] || [[ $1 == '--help' ]] || [[ ! -d "$1" ]];then
		usage_exit
	fi
	TARGET_DIR=$1
else
	TARGET_DIR='./'
fi

ALL_DIR_NAMES=`ls -l $TARGET_DIR | grep "^d" | awk '{print $9 }'`
echo
# create empty files although it exists
echo "" > /tmp/upgrade_git_error.log
echo "" > ./error.log
# or ':> /tmp/upgrade_git_error.log'

for dis in $ALL_DIR_NAMES
do
	update_git_hg "$TARGET_DIR"/$dis &
done

wait

# 如果 upgrade_git_error.log, error.log 为空，则删除
if [[ $(wc -l /tmp/upgrade_git_error.log | awk '{print $1 }') == 1 ]]; then
	rm -f /tmp/upgrade_git_error.log
	if [[ -f ./error.log ]]; then
		rm -f ./error.log
	fi
else
	mv /tmp/upgrade_git_error.log ./error.log
fi

exit 0


# ls -l | grep "^d" | awk '{print $9 }'
#此句可以得到当前目录下仅仅一层子目录的名字

# find $DIR -type d -name '*' | sort
#此句可以得到当前目录下所有子目录的名字，递归

#;cd $8 ;mv ./01.swf ../$8.swf ;cd ..

