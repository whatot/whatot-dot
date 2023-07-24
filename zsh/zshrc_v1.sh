# shellcheck disable=SC2148,SC1090,SC1091

zmodload zsh/zprof
# enable zprof module, start zsh, then call zprof cmd

init_before_all() {
	if [[ ${OSTYPE} == 'Darwin'* ]]; then
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

	export PROXY_PORT=8899
	export PROXY_HOST="127.0.0.1"

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
	if [[ ${OSTYPE} == 'Darwin'* ]]; then
		brew_path=$(find_bin_path "brew")
		if [[ $? ]]; then
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
	if [[ ${OSTYPE} == 'Linux'* ]]; then
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

	if [[ ${OSTYPE} == 'Darwin'* ]]; then
		alias vim='mvim -v'
	fi

	export LC_MESSAGES="en_US.UTF-8"
	export EDITOR='vim'
}

config_ohmyzsh() {
	if [[ -d "/usr/share/oh-my-zsh/" ]]; then
		ZSH=/usr/share/oh-my-zsh/
		export DISABLE_AUTO_UPDATE="true"
	else
		ZSH=${HOME}/.oh-my-zsh/
		export DISABLE_AUTO_UPDATE="false"
	fi

	export ZSH_THEME="gentoo"
	if [[ $(is_darwin) ]]; then
		export ZSH_THEME="robbyrussell"
	fi

	ZSH_CACHE_DIR=${HOME}/.oh-my-zsh-cache
	if [[ ! -d ${ZSH_CACHE_DIR} ]]; then
		mkdir "${ZSH_CACHE_DIR}"
	fi
	source "${ZSH}/oh-my-zsh.sh"
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

# ohmyzsh last
config_ohmyzsh
