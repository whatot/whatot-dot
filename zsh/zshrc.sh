# shellcheck disable=SC2148,SC1090,SC1091

zmodload zsh/zprof
# enable zprof module, start zsh, then call zprof cmd

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
    export NO_PROXY="^\\(localhost\\|10\\..*\\|192\\.168\\..*\\)"
    export ALL_PROXY="${url}"
    export HTTP_PROXY="${url}"
    export HTTPS_PROXY="${url}"
  fi
}
proxyinfo() {
  echo "NO_PROXY = ${NO_PROXY}"
  echo "ALL_PROXY = ${ALL_PROXY}"
  echo "HTTP_PROXY = ${HTTP_PROXY}"
  echo "HTTPS_PROXY = ${HTTPS_PROXY}"
}

config_java_about() {
  # for gradle proxy setting
  export GRADLE_OPTS="-Dhttp.proxyHost=${PROXY_HOST} -Dhttp.proxyPort=${PROXY_PORT} \
      -Dhttps.proxyHost=${PROXY_HOST} -Dhttps.proxyPort=${PROXY_PORT} \
      -Dhttp.nonProxyHosts=*.nonproxyrepos.com|localhost"

  # for error message in en
  export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8 -Duser.language=en"

  alias mvalidate="mvn validate -U"
  alias mdeploy='mvn clean deploy -Dmaven.test.skip=true'
  alias mtree='mvn clean dependency:tree -U'
  alias msource='mvn dependency:sources'
  alias fmt='mvn com.coveo:fmt-maven-plugin:format -o'
  alias mqc='mvn com.coveo:fmt-maven-plugin:format -o && ${MVN} compile --offline'
  alias mcc='mvn clean compile -U'
  alias mcco='mvn clean compile -U --offline'
  alias mqt='mvn test -DfailIfNoTests=false --offline'
  alias mtt='mvn clean test -U -DfailIfNoTests=false'
  alias mtto='mvn clean test -U -DfailIfNoTests=false --offline'
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

config_prezto() {
  prezto_path="${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
  if [[ -s "${prezto_path}" ]]; then
    source "${prezto_path}"
  else
    echo "prezto not found"
    return 0
  fi
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

# load prezto with plugins
config_prezto

# starship last
eval "$(starship init zsh)"

# refresh zsh completion
[ ! "$(find "${HOME}"/.zcompdump -mtime 1)" ] || compinit
compinit -C
