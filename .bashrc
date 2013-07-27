# Add vim as default editor
export EDITOR=vim
export PATH=$PATH:/opt/java/jre/bin
export TERM=vte-256color

alias ls='ls --color=auto -F'

# some more ls aliases
alias lh='ls -lh'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

alias rm='rm -I'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias more='less'

export HISTTIMEFORMAT="%F %T  "

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PATH=$PATH GST_ID3_TAG_ENCODING=GBK:UTF-8:GB18030
export PATH=$PATH GST_ID3V2_TAG_ENCODING=GBK:UTF-8:GB18030

export PAGER="`which less` -s"
export BROWSER="$PAGER"
export LESS_TERMCAP_mb=$'\E[01;34m'
export LESS_TERMCAP_md=$'\E[01;34m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;33m'

source ~/.git-completion.bash
source ~/.git-prompt.sh

[ ! "$UID" = "0" ] && archbey2

umask 022
# umask 077

source /usr/share/cdargs/cdargs-bash.sh
export PYTHONDOCS=/usr/share/doc/python2/html/

export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
export DE=gnome

# xmodmap /home/mir/.Xmodmap
export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
