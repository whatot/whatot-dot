#! /bin/bash
# set -x

# -d           -- do not attach new session to current terminal
# -n           -- name the initial window
# -s           -- name the session
# -t           -- specify target session

# /usr/bin/xfce4-terminal --maximize --execute /usr/bin/tmux.sh
# /usr/bin/gnome-terminal --maximize --command "/usr/bin/tmux.sh"

# tmux example

# split-window
# tmux new-window -n lua2 -t mydev
# tmux split-window -h -t mydev
# tmux send-keys -t mydev:5.1 "cd ~/git/redis/deps/lua/src/" C-m
# tmux send-keys -t mydev:5.2 "cd ~/base/ma_c/5/deps/lua/src/" C-m

# only create one window
# tmux new-window -n jemalloc -t mydev
# tmux send-keys -t mydev:6 "cd ~/git/jemalloc/include/jemalloc/internal" C-m

IN_PATH="~/install/"
PGC_PATH="~/works/pgc/"
USER_TMP="~/tmp/"
#IN_PATH="/tmp/install"

function tmux_company {

tmux has-session -t works125
if [[ $? != 0 ]]; then
	tmux new-session -s works125 -n pgc1 -d
	tmux send-keys -t works125 "cd $PGC_PATH" C-m

	tmux new-window -n pgc2 -t works125
	tmux send-keys -t works125:2 "cd $PGC_PATH" C-m

	tmux new-window -n pgc3 -t works125
	tmux send-keys -t works125:3 "cd $PGC_PATH" C-m

	tmux new-window -n in4 -t works125
	tmux send-keys -t works125:4 "cd $IN_PATH" C-m

	tmux new-window -n in5 -t works125
	tmux send-keys -t works125:5 "cd $IN_PATH" C-m

	tmux new-window -n in6 -t works125
	tmux send-keys -t works125:6 "cd $IN_PATH" C-m

	tmux new-window -n in7 -t works125
	tmux send-keys -t works125:7 "cd $IN_PATH" C-m

	tmux new-window -n tmp8 -t works125
	tmux send-keys -t works125:8 "cd $USER_TMP" C-m

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
if [[ $? != 0 ]]; then
	tmux new-session -s mydev -n '~git' -d
	tmux send-keys -t mydev "cd ~/git/" C-m

	tmux new-window -n work1 -t mydev
	tmux send-keys -t mydev:2 "cd ~/" C-m

	tmux new-window -n work2 -t mydev
	tmux send-keys -t mydev:3 "cd ~/" C-m

	tmux new-window -n kernel -t mydev
	tmux send-keys -t mydev:4 "cd ~/linux/" C-m

	tmux new-window -n goagent -t mydev
	tmux send-keys -t mydev:5 "cd ~/git/goagent/local/" C-m
	tmux send-keys -t mydev:5 "python2 proxy.py" C-m

	tmux new-window -n share -t mydev
	tmux send-keys -t mydev:6 "cd ~/" C-m

	tmux new-window -n pg -t mydev
	tmux send-keys -t mydev:7 "cd ~/git/" C-m

	tmux select-window -t mydev:1
	tmux select-pane -t mydev:1
fi
tmux attach -t mydev

}


HOSTNAME=`cat /etc/hostname`

if [[ -f /usr/bin/tmux ]]; then

	if [[ $# == 0 ]]; then

		if [[ $HOSTNAME == 'mirage' ]]; then
			tmux_company
		elif [[ $HOSTNAME == 'cru' ]]; then
			tmux_mydev
		fi

	elif [[ $# == 1 ]] && [[ $@ == 'my' ]]; then
		tmux_mydev
	elif  [[ $# == 1 ]] && [[ $@ == 'w' ]]; then
		tmux_company
	fi

fi
