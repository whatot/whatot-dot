#!/usr/bin/env bash
set -eu
#set -eux

function brew_install() {
    pkg_name=$1

    if brew ls --versions "$pkg_name" > /dev/null; then
        echo "$pkg_name installed"
    else
        echo "to install $pkg_name"
        brew install $*
    fi
}

function brew_cask_install() {
    pkg_name=$1

    if brew list --cask --versions "$pkg_name" > /dev/null; then
        echo "$pkg_name installed"
    else
        echo "to install $pkg_name"
        brew install --cask "$pkg_name"
    fi
}

if [ ! -d "$(xcode-select --print-path)" ]; then
    xcode-select --install
fi

if [[ "$(command -v brew)" != *"brew"* ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew tap homebrew/cask-fonts
    brew tap d12frosted/emacs-plus
fi

brew_install coreutils
brew_install binutils
brew_install diffutils
brew_install ed
brew_install findutils
brew_install gawk
brew_install gnu-indent
brew_install gnu-sed
brew_install gnu-tar
brew_install gnu-which
brew_install gnutls
brew_install grep
brew_install gzip
brew_install screen
brew_install watch
brew_install wdiff
brew_install wget

brew_install tree
brew_install axel
brew_install rsync
brew_install git
brew_install zsh
brew_install htop
brew_install ranger

brew_install cmake
brew_install rustup-init
brew_install the_silver_searcher
brew_install bear
brew_install shellcheck
brew_install editorconfig
brew_install ydcv
brew_install plantuml
brew_install fd
brew_install proselint
brew_install discount
brew_install sccache
brew_install prettier
brew_install jq
brew_install ripgrep

brew_cask_install iina

brew_cask_install font-source-code-pro
brew_cask_install macvim
brew_cask_install meld

# install emacs and link
brew_install emacs-plus@28 --with-native-comp
brew link --overwrite emacs-plus

ln -sf /opt/homebrew/opt/emacs-plus@28/Emacs.app /Applications
ln -sf /opt/homebrew/bin/rustup-init /opt/homebrew/bin/rustup

echo "finined!"
