case $(uname) in
    Darwin)
        export PATH="/opt/homebrew/opt/openjdk@11/bin:/opt/homebrew/bin:/opt/homebrew/sbin:${HOME}/.cargo/bin:${HOME}/go/bin:${HOME}/.rd/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
        # export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/bottles
        export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles/bottles
        ;;
    Linux)
        export JAVA_HOME="/usr/lib/jvm/default/"
        export CLASSPATH=${JAVA_HOME}/jre/lib/
        export PATH="/usr/lib/ccache":"${HOME}/go/bin":"${HOME}/.cargo/bin":"${HOME}/.local/bin":${PATH}
        export TERM="xterm-256color"
        ;;
    *) ;;
esac

export GOPATH="${HOME}/go/"
# export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"