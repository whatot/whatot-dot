#!/bin/sh
#进入~/git/,分别将各git版本库更新到最新
#2012-10-05-01:26



DIR=$(pwd)
cd $DIR

echo

for dis in $( ls -l | grep "^d" | awk '{print $9 }' )
do
	cd $dis ;
	echo "###########################################################"
	echo "enter $dis !"
	echo
	if [ -d ".git" ]; then
		git pull;
		# git pull origin master;
		git submodule update;
	fi
	echo
	echo "leave $dis !"
	cd ..
done



# ls -l | grep "^d" | awk '{print $9 }'
#此句可以得到当前目录下仅仅一层子目录的名字

# find $DIR -type d -name '*' | sort
#此句可以得到当前目录下所有子目录的名字，递归

#;cd $8 ;mv ./01.swf ../$8.swf ;cd ..

