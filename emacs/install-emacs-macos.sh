#!/bin/bash
set -x

# https://emacs.stackexchange.com/questions/37240/how-install-emacs-26-or-whatever-latest-ver-on-mac

brew info emacs

brew unlink emacs
brew uninstall emacs
brew tap d12frosted/emacs-plus
brew unlink emacs-plus
brew install emacs-plus --devel

# The imagemagick@6 library and emacs devel change frequently
# so exclude them from automatic updates and do updates manually at convenient times:
brew pin imagemagick@6 emacs-plus

# SPC SPC spacemacs/recompile-elpa
