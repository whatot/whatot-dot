# shellcheck disable=SC2148,SC1090,SC1091

export OS_TYPE
OS_TYPE="$(uname -s)"
is_linux() { [[ "${OS_TYPE}" == "Linux" ]]; }
is_darwin() { [[ "${OS_TYPE}" == "Darwin" ]]; }

init_before_all() {
	if [[ $(is_darwin) ]]; then
		source "${HOME}/.zshenv"
	fi
}

find_bin_path() {
	bin_name=$1
	for var in /opt/homebrew/bin /usr/local/bin /usr/bin ${HOME}/.local/bin ${HOME}/.cargo/bin ${HOME}/go/bin; do
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
		# echo "proxy wsl: ${PROXY_HOST}:${PROXY_PORT} "
	else
		export PROXY_HOST="127.0.0.1"
		# echo "proxy local: ${PROXY_HOST}:${PROXY_PORT} "
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
	alias bubu='brew update && brew outdated && brew upgrade && brew cleanup'
}

config_sccache() {
	sccache_path=$(find_bin_path "sccache")
	if [[ $? ]]; then
		export RUSTC_WRAPPER="${sccache_path}"
	else
		echo "sccache not found"
	fi
}

config_brew() {
	if [[ ! $(is_darwin) ]]; then
		return 1
	fi

	brew_path=$(find_bin_path "brew")
	if [[ $? ]]; then
		export HOMEBREW_NO_AUTO_UPDATE=1
		eval "$(${BREW_BIN} shellenv)"
		# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
		export FPATH="$(${brew_path} --prefix)/share/zsh/site-functions:${FPATH}"
	else
		echo "brew not found"
	fi
}

config_input_method() {
	if [[ $(is_linux) ]]; then
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
	alias yay="paru"
	alias ll='ls -alF --color'
	alias ..='cd ..'

	if [[ $(is_darwin) ]]; then
		alias vim='mvim -v'
	fi

	export LC_MESSAGES="en_US.UTF-8"
	export EDITOR='vim'
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

# unclassified part
config_mixed

# load prezto with plugins
config_prezto

# starship last
eval "$(starship init zsh)"
