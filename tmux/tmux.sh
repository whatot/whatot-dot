#! /bin/bash
export AP_7x27_PROJECT="~/Developer/MSM7x27A-ICS-AP"
export MP_7x27_PROJECT="~/Developer/MSM7x27A-ICS-MP"

export AP_8x25_PROJECT="~/Developer/MSM8x25-ICS-AP"
export MP_8x25_PROJECT="~/Developer/MSM8x25-ICS-MP"

if [ -z "$TMUX" ]; then
    tmux has-session -t development7x27
    if [ $? != 0 ]; then
        # init 7x27 AP
        tmux new-session -s development7x27 -n AP_7x27 -d
        tmux send-keys -t development7x27 "cd $AP_7x27_PROJECT&&. ./build/envsetup.sh&&choosecombo 1 13 1" C-m
        tmux split-window -h -p 40 -t development7x27:1
        tmux send-keys -t development7x27 "cd $AP_7x27_PROJECT&&. ./build/envsetup.sh&&choosecombo 1 13 1" C-m
        tmux split-window -v -t development7x27:1.2
        tmux send-keys -t development7x27 "cd $AP_7x27_PROJECT&&. ./build/envsetup.sh&&choosecombo 1 13 1" C-m

        # init 7x27 MP
        tmux new-window -n MP_7x27 -t development7x27

        tmux send-keys -t development7x27:2 "cd $MP_7x27_PROJECT/modem_proc/build/ms" C-m
        tmux split-window -h -p 40 -t development7x27:2
        tmux send-keys -t development7x27:2 "cd $MP_7x27_PROJECT/modem_proc/build/ms" C-m
        tmux split-window -v -t development7x27:2.2
        tmux send-keys -t development7x27 "cd $MP_7x27_PROJECT/modem_proc/build/ms" C-m

        tmux select-window -t development7x27:1
        tmux select-pane -t development7x27:1 -L
    fi

        tmux send-keys -t development7x27:1.3 "export DISPLAY=$DISPLAY" C-m
        tmux send-keys -t development7x27:2.3 "export DISPLAY=$DISPLAY" C-m

    tmux has-session -t development8x25
    if [ $? != 0 ]; then
        # init 8x25 AP
        tmux new-session -s development8x25 -n AP_8x25 -d
        tmux send-keys -t development8x25 "cd $AP_8x25_PROJECT&&. ./build/envsetup.sh&&choosecombo 1 17 3" C-m
        tmux split-window -h -p 40 -t development8x25:1
        tmux send-keys -t development8x25 "cd $AP_8x25_PROJECT&&. ./build/envsetup.sh&&choosecombo 1 17 3" C-m
        tmux send-keys -t development8x25 'top' C-m
        tmux split-window -v -t development8x25:1.2
        tmux send-keys -t development8x25 "cd $AP_8x25_PROJECT&&. ./build/envsetup.sh&&choosecombo 1 17 3" C-m

        # init 8x25 MP
        tmux new-window -n MP_8x25 -t development8x25

        tmux send-keys -t development8x25:2 "cd $MP_8x25_PROJECT/modem_proc/build/ms" C-m
        tmux split-window -h -p 40 -t development8x25:2
        tmux send-keys -t development8x25:2 "cd $MP_8x25_PROJECT/modem_proc/build/ms" C-m
        tmux split-window -v -t development8x25:2.2
        tmux send-keys -t development8x25 "cd $MP_8x25_PROJECT/modem_proc/build/ms" C-m

        tmux select-window -t development8x25:1
        tmux select-pane -t development8x25:1 -L
    fi

        tmux send-keys -t development8x25:1.3 "export DISPLAY=$DISPLAY" C-m
        tmux send-keys -t development8x25:2.3 "export DISPLAY=$DISPLAY" C-m

    tmux attach -t development7x27
fi

