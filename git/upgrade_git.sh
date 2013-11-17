#!/bin/sh
#进入~/git/,分别将各git版本库更新到最新
#2012-10-05-01:26

function update_git_hg ()
{
	cd $1

	local if_success
	if [[ -d ".git" ]]; then
		git pull || if_success=$?
		echo "updated $1 !"
		echo
		if [[ if_success != 0 ]]; then
			echo $1 >> ../error.log
		fi
		# git pull origin master;
		git submodule update
	fi

	if [[ -d ".hg" ]]; then
		hg update || echo "update $1 !"
	fi

	cd ..
}


echo
# create empty files although it exists
echo "" > error.log
# or ':> error.log'

for dis in $( ls -l | grep "^d" | awk '{print $9 }' )
do
	update_git_hg $dis &
done

wait

exit 0


# ls -l | grep "^d" | awk '{print $9 }'
#此句可以得到当前目录下仅仅一层子目录的名字

# find $DIR -type d -name '*' | sort
#此句可以得到当前目录下所有子目录的名字，递归

#;cd $8 ;mv ./01.swf ../$8.swf ;cd ..

