#!/usr/bin/env bash
set -eu
#set -eux

function brew_install() {
  pkg_name=$1

  if brew ls --versions "$pkg_name" >/dev/null; then
    echo "$pkg_name installed"
  else
    echo "to install $pkg_name"
    brew install "$*"
  fi
}

function brew_cask_install() {
  pkg_name=$1

  if brew list --cask --versions "$pkg_name" >/dev/null; then
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
fi

brew_install coreutils
brew_install binutils
brew_install diffutils
brew_install ed
brew_install eza
brew_install findutils
brew_install fzf
brew_install gawk
brew_install gnu-indent
brew_install gnu-sed
brew_install gnu-tar
brew_install gnu-which
brew_install gnutls
brew_install grep
brew_install gzip
brew_install watch
brew_install wdiff
brew_install wget

brew_install tree
brew_install axel
brew_install rsync
brew_install git
brew_install zsh
brew_install htop
brew_install btop

brew_install cmake
brew_install ninja
brew_install rustup-init
brew_install mold
brew_install the_silver_searcher
brew_install bear
brew_install shellcheck
brew_install editorconfig
brew_install plantuml
brew_install fd
brew_install proselint
brew_install discount
brew_install ccache
brew_install sccache
brew_install prettier
brew_install jq
brew_install ripgrep
brew_install shfmt
brew_install tokei
brew_install neofetch
brew_install tree-sitter
brew_install btop
brew_install openjdk@11
brew_install openjdk@21
brew_install bash-language-server
brew_install direnv
brew_install terraform
brew_install lua
brew_install lua-language-server
brew_install stylua
brew_install sqlfmt
brew_install docker-completion
brew_install kubectl
brew_install navi
brew_install connect
# for tldr to update cache, `tldr --update`
# macos cache dir: `~/Library/Caches/tealdeer`
brew_install tealdeer
brew_install nushell
brew_install zoxide
brew_install chezmoi
# https://mise.jdx.dev/getting-started.html
brew_install mise
# https://docs.helix-editor.com/
brew_install helix
# https://github.com/biomejs/biome
brew_install biome

brew_cask_install bruno
brew_cask_install macvim
brew_cask_install iina
brew_cask_install visual-studio-code
brew_cask_install sequel-ace
brew_cask_install font-hack-nerd-font
brew_cask_install font-jetbrains-mono-nerd-font
brew_cask_install font-lxgw-wenkai

echo "finined!"
