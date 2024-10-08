#!/usr/bin/env zsh

# Initialize homebrew
if [[ $(uname -m) == 'arm64' ]]; then
  eval $(/opt/homebrew/bin/brew shellenv)
fi

# shortcut to this dotfiles path is $ZSH
export ZSH=$HOME/dotfiles

# https://gist.github.com/QinMing/364774610afc0e06cc223b467abe83c0
lazy_load() {
    # $1: space separated list of alias to release after the first load
    # $2: file to source
    # $3: name of the command to run after it's loaded
    # $4+: argv to be passed to $3
    printf '\e[1;90m%-6s\e[m\n' "Lazy loading $1 ..." >&2

    # $1.split(' ') using the s flag. In bash, this can be simply ($1) #http://unix.stackexchange.com/questions/28854/list-elements-with-spaces-in-zsh
    # Single line won't work: local names=("${(@s: :)${1}}"). Due to http://stackoverflow.com/questions/14917501/local-arrays-in-zsh   (zsh 5.0.8 (x86_64-apple-darwin15.0))
    local -a names
    if [[ -n "$ZSH_VERSION" ]]; then
        names=("${(@s: :)${1}}")
    else
        names=($1)
    fi
    unalias "${names[@]}"
    . $2
    shift 2
    $*
}

group_lazy_load() {
    local script
    script=$1
    shift 1
    for cmd in "$@"; do
        alias $cmd="lazy_load \"$*\" $script $cmd"
    done
}

# all of our zsh files
typeset -U config_files
config_files=($ZSH/**/*.zsh)

# load the path files
for file in ${(M)config_files:#*/path.zsh}
do
  source $file
done

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# load everything but the path and completion files
for file in ${${${config_files:#*/path.zsh}:#*/completion.zsh}:#*/final.zsh}
do
  source $file
done


# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit

# load every completion after autocomplete loads
for file in ${(M)config_files:#*/completion.zsh}
do
  source $file
done

for file in ${(M)config_files:#*/final.zsh}
do
  source $file
done

unset config_files
unset -f group_lazy_load

# use .localrc for SUPER SECRET CRAP that you don't
# want in your public, versioned repo.
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi
