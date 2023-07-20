eval "$(starship init zsh)"

ZSH_AUTOSUGGESTIONS="/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
ZSH_HISTORY_SUBSTRING_SEARCH="/usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"
ZSH_SYNTAX_HIGHLIGHTING="/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if [[ -f ${ZSH_AUTOSUGGESTIONS} ]]; then
    source ${ZSH_AUTOSUGGESTIONS}
fi
if [[ -f ${ZSH_HISTORY_SUBSTRING_SEARCH} ]]; then
    source ${ZSH_HISTORY_SUBSTRING_SEARCH}
fi
if [[ -f ${ZSH_SYNTAX_HIGHLIGHTING} ]]; then
    source ${ZSH_SYNTAX_HIGHLIGHTING}
fi

PATH_CANDIDATES=("/opt/homebrew/bin" "/usr/bin" "/usr/local/bin" "${HOME}/.cargo/bin" "${HOME}/go/bin")
function find_bin_path() {
    local bin_name=$1
    for var in "${PATH_CANDIDATES[@]}"
    do
        full_path="${var}/${bin_name}"
        if [[ -f "${full_path}" ]]; then
           echo "${full_path}"
           return 0
        fi
    done
    return 1
}
function unsetproxy() {
    unset ALL_PROXY
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset all_proxy
    unset http_proxy
    unset https_proxy
}
function setproxy() {
    unsetproxy

    PROXY_PORT=8899

    ## determine proxy host
    if [[ -v WSL_INTEROP ]]; then
        hostip=$(grep nameserver /etc/resolv.conf | awk '{ print $2 }')
        export PROXY_HOST=${hostip}
        echo "proxy wsl: ${PROXY_HOST}:${PROXY_PORT} "
    else
        export PROXY_HOST="127.0.0.1"
        echo "proxy local: ${PROXY_HOST}:${PROXY_PORT} "
    fi

    export ALL_PROXY="http://${PROXY_HOST}:${PROXY_PORT}"
    export HTTP_PROXY="http://${PROXY_HOST}:${PROXY_PORT}"
    export HTTPS_PROXY="http://${PROXY_HOST}:${PROXY_PORT}"
}
function proxyinfo() {
    echo "ALL_PROXY = ${ALL_PROXY}"
    echo "HTTP_PROXY = ${HTTP_PROXY}"
    echo "HTTPS_PROXY = ${HTTPS_PROXY}"
}

# turn on proxy by default
setproxy

# for gradle proxy setting
export GRADLE_OPTS="-Dhttp.proxyHost=${PROXY_HOST} -Dhttp.proxyPort=${PROXY_PORT} \
  -Dhttps.proxyHost=${PROXY_HOST} -Dhttps.proxyPort=${PROXY_PORT} \
  -Dhttp.nonProxyHosts=*.nonproxyrepos.com|localhost"

case $(uname) in
    Darwin)
        source ~/.zshenv
        alias vim='mvim -v'
        export HOMEBREW_NO_AUTO_UPDATE=1
    ;;
    Linux)
        export GTK_IM_MODULE=fcitx
        export QT_IM_MODULE=fcitx
        export XMODIFIERS="@im=fcitx"
        alias gvim='gvim -c "call Maximize_Window()"'
    ;;
    *)
    ;;
esac

# podman machine init
# sudo podman-mac-helper install
# podman machine set --rootful
# podman machine start
# podman machine stop

alias mvalidate="mvn validate -U"
alias mdeploy='mvn clean deploy -Dmaven.test.skip=true'
alias mtree='mvn clean dependency:tree -U'
alias msource='mvn dependency:sources'

export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8 -Duser.language=en"
MVN=mvn
if [[ $(command -v mvnd) ]]; then
    MVN=mvnd
fi
alias fmt='${MVN} com.coveo:fmt-maven-plugin:format -o'
alias mqc='${MVN} com.coveo:fmt-maven-plugin:format -o && ${MVN} compile --offline'
alias mcc='${MVN} clean compile -U'
alias mcco='${MVN} clean compile -U --offline'
alias mqt='${MVN} test -DfailIfNoTests=false --offline'
alias mtt='${MVN} clean test -U -DfailIfNoTests=false'
alias mtto='${MVN} clean test -U -DfailIfNoTests=false --offline'

alias myip="curl myip.ipip.net"
alias yay="paru"
alias find="fd"
alias ll='ls -alF --color'
alias ..='cd ..'

export LC_MESSAGES="en_US.UTF-8"
export EDITOR='vim'

sccache_path=$(find_bin_path "sccache")
if [[ $? -eq 0 ]]; then
    export RUSTC_WRAPPER="${sccache_path}"
else
    echo "sccache not installed"
fi

export SDKMAN_DIR="${HOME}/.sdkman"
export SDKMAN_JDK11="11.0.19-amzn"
export SDKMAN_JDK17="17.0.7-amzn"

if [[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]]; then
    source "${SDKMAN_DIR}/bin/sdkman-init.sh"
    # sdk offline enable
    # sdk config
    function usejdk11() {
        sdk use java "${SDKMAN_JDK11}"
    }
    function usejdk17() {
        sdk use java "${SDKMAN_JDK17}"
    }
    function gradle_wrapper_jdk8() {
        usejdk11
        gradle wrapper --gradle-version 4.2.1
    }
fi
function init_sdkman() {
    curl -s "https://get.sdkman.io" | bash
    source "${SDKMAN_DIR}/bin/sdkman-init.sh"
    sdk config
    sdk install java "${SDKMAN_JDK17}"
    sdk install java "${SDKMAN_JDK11}"
    sdk list java
    sdk current java
}

BREW_BIN="$(command -v brew)"
if [[ $? -eq 0 ]]; then
    eval "$(brew shellenv)"

    # https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

autoload -Uz compinit && compinit
