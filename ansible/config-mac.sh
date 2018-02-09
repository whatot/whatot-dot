#!/usr/bin/env bash
set -eu
#set -eux

function brew_install() {
    case "$#" in
        1)
            bin_name=$1
            pkg_name=$1
            ;;
        2)
            bin_name=$1
            pkg_name=$2
            ;;
        *)
            exit -1
            ;;
    esac

    echo "install $pkg_name"

    if [[ "$(which $bin_name)" != *"$bin_name"* ]]; then
        brew install "$pkg_name"
    fi
}

if [ ! -d "$(xcode-select --print-path)" ]; then
    xcode-select --install
fi

if [[ "$(which brew)" != *"brew"* ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew tap homebrew/dupes
fi

brew_install tree
brew_install wget
brew_install axel
brew_install realpath coreutils
brew_install rsync
brew_install git
brew_install zsh

brew_install ghc
brew_install cabal cabal-install

brew_install cmake
brew_install mvn maven
brew_install rustup rustup-init
brew_install ag the_silver_searcher
brew_install emacs

echo "finined!"
