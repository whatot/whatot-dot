case $(uname) in
  Darwin)
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
      export PATH="/opt/homebrew/opt/rustup/bin:/opt/homebrew/opt/ccache/libexec:/opt/homebrew/opt/openjdk@17/bin:/opt/homebrew/bin:/opt/homebrew/sbin:${HOME}/.cargo/bin:${HOME}/go/bin:${HOME}/.rd/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
      export JAVA_HOME="/opt/homebrew/opt/openjdk@17"
    else
      export PATH="/usr/local/opt/rustup/bin:/opt/local/opt/ccache/libexec:/usr/local/opt/openjdk@17/bin:${HOME}/.cargo/bin:${HOME}/go/bin:${HOME}/.rd/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
      export JAVA_HOME="/usr/local/opt/openjdk@17"
    fi
    export ANDROID_HOME=$HOME/Library/Android/sdk
    export PATH=$PATH:$ANDROID_HOME/emulator
    export PATH=$PATH:$ANDROID_HOME/platform-tools
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
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

# https://emacs-lsp.github.io/lsp-mode/page/performance/#use-plists-for-deserialization
export LSP_USE_PLISTS=true
