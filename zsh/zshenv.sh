case $(uname) in
Darwin)
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:/opt/homebrew/opt/rustup/bin:/opt/homebrew/opt/ccache/libexec:/opt/homebrew/opt/openjdk@21/bin:/opt/homebrew/bin:/opt/homebrew/sbin:${HOME}/.cargo/bin:${HOME}/go/bin:${HOME}/.rd/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
        export JAVA_HOME="/opt/homebrew/opt/openjdk@21"
    else
        export PATH="/usr/local/opt/rustup/bin:/opt/local/opt/ccache/libexec:/usr/local/opt/openjdk@21/bin:${HOME}/.cargo/bin:${HOME}/go/bin:${HOME}/.rd/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
        export JAVA_HOME="/usr/local/opt/openjdk@21"
    fi
    export ANDROID_HOME=$HOME/Library/Android/sdk
    # export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/bottles
    export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles/bottles
    ;;
Linux)
    export JAVA_HOME="/usr/lib/jvm/default/"
    export CLASSPATH=${JAVA_HOME}/jre/lib/
    export PATH="/usr/lib/ccache":"${HOME}/go/bin":"${HOME}/.cargo/bin":"${HOME}/.local/bin":${PATH}
    export TERM="xterm-256color"
    export ANDROID_HOME=$HOME/Android/Sdk
    ;;
*) ;;
esac

# android about
ANDROID_NDK_PARENT_DIR=$ANDROID_HOME/ndk
if [[ -d "${ANDROID_NDK_PARENT_DIR}" ]]; then
    export NDK_VERSION="$(ls -1 $ANDROID_HOME/ndk | tail -n 1)"
    export NDK_HOME="$ANDROID_HOME/ndk/$NDK_VERSION"
fi
unset ANDROID_NDK_PARENT_DIR
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

export GOPATH="${HOME}/go/"
# export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

# https://emacs-lsp.github.io/lsp-mode/page/performance/#use-plists-for-deserialization
export LSP_USE_PLISTS=true

# https://docs.flutter.cn/community/china/
export PUB_HOSTED_URL="https://mirrors.tuna.tsinghua.edu.cn/dart-pub"
export FLUTTER_STORAGE_BASE_URL="https://mirrors.tuna.tsinghua.edu.cn/flutter"
