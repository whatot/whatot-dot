#! /bin/bash
# set -x

# -d           -- do not attach new session to current terminal
# -n           -- name the initial window
# -s           -- name the session
# -t           -- specify target session

# /usr/bin/gnome-terminal --maximize --execute /usr/bin/tmux.sh
# /usr/bin/gnome-terminal --command=tmux --maximize

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
WORK_PATH="~/works/"
USER_TMP="~/tmp/"
USER_GIT="~/git/"

function tmux_dev7 {

tmux has-session -t dev7
if [[ $? != 0 ]]; then
	tmux new-session -s dev7 -n work1 -d
	tmux send-keys -t dev7 "cd $WORK_PATH" C-m

	tmux new-window -n work2 -t dev7
	tmux send-keys -t dev7:2 "cd $WORK_PATH" C-m

	tmux new-window -n work3 -t dev7
	tmux send-keys -t dev7:3 "cd $WORK_PATH" C-m

	tmux new-window -n in4 -t dev7
	tmux send-keys -t dev7:4 "cd $IN_PATH" C-m

	tmux new-window -n in5 -t dev7
	tmux send-keys -t dev7:5 "cd $IN_PATH" C-m

	tmux new-window -n in6 -t dev7
	tmux send-keys -t dev7:6 "cd $IN_PATH" C-m

	tmux new-window -n tmp7 -t dev7
	tmux send-keys -t dev7:7 "cd $USER_TMP" C-m

	tmux new-window -n tmp8 -t dev7
	tmux send-keys -t dev7:8 "cd $USER_TMP" C-m

	tmux new-window -n git9 -t dev7
	tmux send-keys -t dev7:9 "cd $USER_GIT" C-m

	tmux select-window -t dev7:1
	tmux select-pane -t dev7:1
fi
tmux attach -t dev7

}


if [[ -f /usr/bin/tmux ]]; then
	tmux_dev7
fi

