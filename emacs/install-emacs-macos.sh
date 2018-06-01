#!/bin/bash
set -x

# https://emacs.stackexchange.com/questions/37240/how-install-emacs-26-or-whatever-latest-ver-on-mac

brew unlink emacs
brew uninstall emacs

brew tap caskroom/fonts
brew tap d12frosted/emacs-plus
brew install emacs-plus --devel
brew cask install font-source-code-pro

# SPC SPC spacemacs/recompile-elpa
