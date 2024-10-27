# shellcheck disable=SC2148,SC1090,SC1091
# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} End configuration added by Zim install


load_env_file() {
  file_path=$1

  if [[ -f "${file_path}" ]]; then
    eval "$(
      awk '!/^\s*#/' <"${file_path}" | awk '!/^\s*$/' | while IFS='' read -r line; do
        key=$(echo "$line" | cut -d '=' -f 1)
        value=$(echo "$line" | cut -d '=' -f 2-)
        echo "export $key=\"$value\""
      done
    )"
  fi
}

init_before_all() {
  uname_os=$(uname -s)
  export ZSH_OSTYPE=${uname_os}

  hostname_os=$(hostname -d)
  export ZSH_HOSTNAME=${hostname_os}

  if [[ ${ZSH_OSTYPE} == 'Darwin' ]]; then
    source "${HOME}/.zshenv"
  fi

  load_env_file "${HOME}/.env_private"
}

unsetproxy() {
  unset NO_PROXY
  unset ALL_PROXY
  unset HTTP_PROXY
  unset HTTPS_PROXY
  unset all_proxy
  unset http_proxy
  unset https_proxy
}
setproxy() {
  unsetproxy

  use_proxy=${USE_PROXY:-true}
  if [[ ${use_proxy} == "true" ]]; then
    url=${PROXY_URL:-http://127.0.0.1:8899}
    export PROXY_HOST=$(echo ${url} | awk -F'://|:' '{print $2}')
    export PROXY_PORT=$(echo ${url} | awk -F'://|:' '{print $3}')
    export NO_PROXY="^\\(localhost\\|10\\..*\\|192\\.168\\..*\\)"
    export ALL_PROXY="${url}"
    export HTTP_PROXY="${url}"
    export HTTPS_PROXY="${url}"
  fi
}
proxyinfo() {
  echo "PROXY_HOST = ${PROXY_HOST}"
  echo "PROXY_PORT = ${PROXY_PORT}"
  echo "NO_PROXY = ${NO_PROXY}"
  echo "ALL_PROXY = ${ALL_PROXY}"
  echo "HTTP_PROXY = ${HTTP_PROXY}"
  echo "HTTPS_PROXY = ${HTTPS_PROXY}"
}

config_java_about() {
  # for gradle proxy setting
  export GRADLE_OPTS="-Dhttp.proxyHost=${PROXY_HOST} -Dhttp.proxyPort=${PROXY_PORT} \
   -Dhttps.proxyHost=${PROXY_HOST} -Dhttps.proxyPort=${PROXY_PORT}"

  # for error message in en
  export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8 -Duser.language=en"

  alias mvalidate="mvn validate -U"
  alias mdeploy='mvn clean deploy -Dmaven.test.skip=true'
  alias mtree='mvn clean dependency:tree -U'
  alias msource='mvn dependency:sources'
  alias fmt='mvn com.coveo:fmt-maven-plugin:format -o'
  alias moo='mvn com.coveo:fmt-maven-plugin:format -o && mvn clean compile --offline'
  alias mcc='mvn com.coveo:fmt-maven-plugin:format -o && mvn clean compile -U'
  alias mtt='mvn clean test -U -DfailIfNoTests=false'

  alias bubu='brew update && brew outdated && brew upgrade && brew cleanup'
}

config_sccache() {
  sccache_path=$(which sccache)
  if [[ $? ]]; then
    export RUSTC_WRAPPER="${sccache_path}"
  else
    echo "sccache not found"
  fi
}

config_brew() {
  if [[ ${ZSH_OSTYPE} == 'Darwin' ]]; then
    brew_path=$(which brew)
    if [[ -x "${brew_path}" ]]; then
      export HOMEBREW_NO_AUTO_UPDATE=1
      eval "$(${brew_path} shellenv)"
      # https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
      export FPATH="$(${brew_path} --prefix)/share/zsh/site-functions:${FPATH}"
    else
      echo "brew not found"
    fi
  fi
}

config_input_method() {
  if [[ ${ZSH_OSTYPE} == 'Linux' ]]; then
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS="@im=fcitx"
  fi
}

config_mixed() {
  # podman machine init
  # sudo podman-mac-helper install
  # podman machine set --rootful
  # podman machine start
  # podman machine stop

  alias myip="curl myip.ipip.net"
  alias ll='ls -alF --color'
  alias ..='cd ..'
  alias gf="git pull"

  if [[ ${ZSH_OSTYPE} == 'Darwin' ]]; then
    alias vim='mvim -v'
  elif [[ ${ZSH_OSTYPE} == 'Linux' ]]; then
    if [[ ! -f "/usr/bin/yay" ]]; then
      alias yay="paru"
    fi
  fi

  export LC_MESSAGES="en_US.UTF-8"
  export EDITOR='vim'

  ulimit -n 10240
}

# init env, path about before all
init_before_all

# turn on proxy by default
setproxy

# java project
config_java_about

# rust build cache
config_sccache

# init brew if mac
config_brew

# unclassified part
config_mixed

# support direnv. add .envrc, then direnv allow.
eval "$(direnv hook zsh)"

# starship last
# eval "$(starship init zsh)"
