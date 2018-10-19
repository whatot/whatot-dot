#!/usr/bin/env bash
set -eu
#set -eux

function brew_install() {
    pkg_name=$1

    if brew ls --versions "$pkg_name" > /dev/null; then
        echo "$pkg_name installed"
    else
        echo "to install $pkg_name"
        brew install "$pkg_name"
    fi
}

function brew_cask_install() {
    pkg_name=$1

    if brew cask ls --versions "$pkg_name" > /dev/null; then
        echo "$pkg_name installed"
    else
        echo "to install $pkg_name"
        brew cask install "$pkg_name"
    fi
}

if [ ! -d "$(xcode-select --print-path)" ]; then
    xcode-select --install
fi

if [[ "$(command -v brew)" != *"brew"* ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew tap homebrew/dupes
    brew tap caskroom/fonts
    brew tap d12frosted/emacs-plus
fi

brew_install tree
brew_install wget
brew_install axel
brew_install coreutils
brew_install rsync
brew_install git
brew_install zsh
brew_install htop
brew_install gnu-tar
brew_install gnutls

brew_install cmake
brew_install maven
brew_install ant
brew_install rustup-init
brew_install the_silver_searcher
brew_install bear
brew_install cquery
brew_install shellcheck

brew_cask_install iina

brew_cask_install font-source-code-pro
brew_cask_install macvim
brew_cask_install jetbrains-toolbox

# install emacs and link
brew_install emacs-plus
rm /Applications/Emacs.app
ln -s /usr/local/Cellar/emacs-plus/*/Emacs.app/ /Applications/

echo "finined!"
