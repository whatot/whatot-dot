#! /bin/bash
# set -x

# -d           -- do not attach new session to current terminal
# -n           -- name the initial window
# -s           -- name the session
# -t           -- specify target session

# /usr/bin/xfce4-terminal --maximize --execute /usr/bin/tmux.sh
# /usr/bin/xfce4-terminal --command=tmux --maximize


if [ -f /usr/bin/tmux ]; then

	if [[ $(hostname -s) == 'mirage' ]]; then

		tmux has-session -t works125
		if [ $? != 0 ]; then
			tmux new-session -s works125 -n ~git -d
			tmux send-keys -t works125 "cd ~/git/" C-m

			tmux new-window -n trunk -t works125
			tmux send-keys -t works125:2 "j trunk" C-m

			tmux new-window -n mac-3 -t works125
			tmux send-keys -t works125:3 "j 3" C-m

			tmux select-window -t works125:1
			tmux select-pane -t works125:1
		fi
		tmux attach -t works125

	elif [[ $(hostname -s) == 'cru' ]]; then

		tmux has-session -t mydev
		if [ $? != 0 ]; then
			tmux new-session -s mydev -n ~git -d
			tmux send-keys -t mydev "cd ~/git/" C-m

			tmux new-window -n mac-3 -t mydev
			tmux send-keys -t mydev:2 "j 3" C-m

			tmux new-window -n lua2 -t mydev
			tmux split-window -h -t mydev
			tmux send-keys -t mydev:3.1 "cd ~/git/redis/deps/lua/src/" C-m
			tmux send-keys -t mydev:3.2 "cd ~/base/ma_c/5/deps/lua/src/" C-m

			tmux new-window -n jemalloc -t mydev
			tmux send-keys -t mydev:4 "cd ~/git/jemalloc/include/jemalloc/internal" C-m

			tmux select-window -t mydev:1
			tmux select-pane -t mydev:1
		fi
		tmux attach -t mydev

	fi

fi

