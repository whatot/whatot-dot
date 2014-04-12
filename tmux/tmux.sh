#! /bin/bash
# set -x

# -d           -- do not attach new session to current terminal
# -n           -- name the initial window
# -s           -- name the session
# -t           -- specify target session

# /usr/bin/xfce4-terminal --maximize --execute /usr/bin/tmux.sh
# /usr/bin/xfce4-terminal --command=tmux --maximize

# tmux example

# split-window
# tmux new-window -n lua2 -t mydev
# tmux split-window -h -t mydev
# tmux send-keys -t mydev:5.1 "cd ~/git/redis/deps/lua/src/" C-m
# tmux send-keys -t mydev:5.2 "cd ~/base/ma_c/5/deps/lua/src/" C-m

# only create one window
# tmux new-window -n jemalloc -t mydev
# tmux send-keys -t mydev:6 "cd ~/git/jemalloc/include/jemalloc/internal" C-m

function tmux_company {

tmux has-session -t works125
if [ $? != 0 ]; then
	tmux new-session -s works125 -n ~git -d
	tmux send-keys -t works125 "cd ~/git/" C-m

	tmux new-window -n postgresql -t works125
	tmux send-keys -t works125:2 "cd ~/git/postgresql/" C-m

	tmux new-window -n pgplus -t works125
	tmux send-keys -t works125:3 "cd ~/works/pgplus/" C-m

	tmux new-window -n pgxc -t works125
	tmux send-keys -t works125:4 "cd ~/works/pgxc/" C-m

	tmux new-window -n install -t works125
	tmux split-window -h -t works125
	tmux send-keys -t works125:5.1 "cd ~/install/" C-m
	tmux send-keys -t works125:5.2 "cd ~/install/" C-m

	tmux new-window -n install2 -t works125
	tmux send-keys -t works125:6 "cd ~/install/" C-m

	tmux new-window -n share -t works125
	tmux send-keys -t works125:7 "cd ~/" C-m

	tmux select-window -t works125:1
	tmux select-pane -t works125:1
fi
tmux attach -t works125

}

# changing -- "cd ~/../mirage/static/git/changing"
# kernel -- "cd ~/linux/"
# lua2 -- "cd ~/git/redis/deps/lua/src/" "cd ~/base/ma_c/5/deps/lua/src/"
# jemalloc -- "cd ~/git/jemalloc/include/jemalloc/internal"
# redis -- "cd ~/git/redis/src/"
# postgresql -- "cd ~/git/postgresql/"
# zlog -- "cd ~/git/zlog/"

function tmux_mydev {

tmux has-session -t mydev
if [ $? != 0 ]; then
	tmux new-session -s mydev -n '~git' -d
	tmux send-keys -t mydev "cd ~/git/" C-m

	tmux new-window -n scrapy -t mydev
	tmux send-keys -t mydev:2 "cd ~/tmp/pycharm/scrapy_learn/" C-m

	tmux new-window -n scrapy2 -t mydev
	tmux send-keys -t mydev:3 "cd ~/tmp/pycharm/scrapy_learn/" C-m

	tmux new-window -n kernel -t mydev
	tmux send-keys -t mydev:4 "cd ~/linux/" C-m

	tmux new-window -n share -t mydev
	tmux send-keys -t mydev:5 "cd ~/" C-m

	tmux new-window -n postgresql -t mydev
	tmux send-keys -t mydev:6 "cd ~/git/postgresql/" C-m

	tmux select-window -t mydev:1
	tmux select-pane -t mydev:1
fi
tmux attach -t mydev

}


function tmux_loong {

tmux has-session -t loong
if [ $? != 0 ]; then
	tmux new-session -s loong -n '~git' -d
	tmux send-keys -t loong "cd ~/git/" C-m

	tmux new-window -n share -t loong
	tmux send-keys -t loong:2 "cd ~/" C-m

	tmux new-window -n share2 -t loong
	tmux send-keys -t loong:3 "cd ~/" C-m

	tmux new-window -n changing -t loong
	tmux send-keys -t loong:4 "cd ~/git/changing" C-m

	tmux new-window -n lua2 -t loong
	tmux split-window -h -t loong
	tmux send-keys -t loong:5.1 "cd ~/git/redis/deps/lua/src/" C-m
	tmux send-keys -t loong:5.2 "cd ~/base/ma_c/5/deps/lua/src/" C-m

	tmux new-window -n redis -t loong
	tmux send-keys -t loong:6 "cd ~/git/redis/src/" C-m

	tmux new-window -n tengine -t loong
	tmux send-keys -t loong:7 "cd ~/git/tengine/" C-m

	tmux select-window -t loong:1
	tmux select-pane -t loong:1
fi
tmux attach -t loong

}


if [ -f /usr/bin/tmux ]; then

	if [ $# == 0 ]; then

		if [[ $(hostname -s) == 'mirage' ]]; then
			tmux_company
		elif [[ $(hostname -s) == 'cru' ]]; then
			tmux_mydev
		elif [[ $(hostname -s) == 'loo' ]]; then
			tmux_loong
		fi

	elif [ $# == 1 ] && [ $@ == 'my' ]; then
		tmux_mydev
	elif  [ $# == 1 ] && [ $@ == 'w' ]; then
		tmux_company
	elif  [ $# == 1 ] && [ $@ == 'l' ]; then
		tmux_loong
	fi

fi
