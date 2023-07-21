load_zsh_plugins() {
    for plugin in zsh-history-substring-search zsh-syntax-highlighting zsh-autosuggestions; do
        for dir in /usr/share/zsh/plugins /opt/homebrew/share; do
            full_path="${dir}/${plugin}/${plugin}.zsh"
            if [[ -f "${full_path}" ]]; then
                # echo "load ${full_path}"
                source "${full_path}"
            fi
        done
    done
}

find_bin_path() {
    local bin_name=$1
    for var in /opt/homebrew/bin /usr/bin ${HOME}/.local/bin ${HOME}/.cargo/bin ${HOME}/go/bin; do
        full_path="${var}/${bin_name}"
        if [[ -f "${full_path}" ]]; then
            echo "${full_path}"
            return 0
        fi
    done
    return 1
}

unsetproxy() {
    unset ALL_PROXY
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset all_proxy
    unset http_proxy
    unset https_proxy
}
setproxy() {
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
proxyinfo() {
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
}

config_sccache() {
    sccache_path=$(find_bin_path "sccache")
    if [[ $? -eq 0 ]]; then
        export RUSTC_WRAPPER="${sccache_path}"
    else
        echo "sccache not found"
    fi
}

config_brew() {
    export HOMEBREW_NO_AUTO_UPDATE=1

    BREN_PREFIX=/opt/homebrew
    BREW_BIN=${BREN_PREFIX}/bin/brew
    if [[ $? -eq 0 ]]; then
        eval "$(${BREW_BIN} shellenv)"
        # https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
        export FPATH="${BREN_PREFIX}/share/zsh/site-functions:${FPATH}"
    else
        echo "brew not found"
    fi
}

config_input_method() {
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS="@im=fcitx"
}

config_alias() {
    # podman machine init
    # sudo podman-mac-helper install
    # podman machine set --rootful
    # podman machine start
    # podman machine stop

    alias myip="curl myip.ipip.net"
    alias yay="paru"
    alias ll='ls -alF --color'
    alias ..='cd ..'

    export LC_MESSAGES="en_US.UTF-8"
    export EDITOR='vim'
}

# starship only
eval "$(starship init zsh)"

# turn on proxy by default
setproxy

# load zsh plugins in system
load_zsh_plugins

# java project
config_java_about

# sccache
config_sccache

# common part
config_alias

case $(uname) in
    Darwin)
        source ~/.zshenv
        alias vim='mvim -v'
        config_brew
        ;;
    Linux)
        config_input_method
        ;;
    *)
        echo "not supported os"
        ;;
esac

autoload -Uz compinit && compinit
