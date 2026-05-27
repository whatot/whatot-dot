# managed by chezmoi

status is-interactive; or return

if command -q bat
    alias cat='bat'
end

switch "$DOTFILES_SHELL_OS"
    case Darwin
        alias ll='ls -alFG'
    case Linux
        alias ll='ls -alF --color=auto'
    case '*'
        alias ll='ls -alF'
end

function ..
    cd ..
end

function ...
    cd ../..
end

alias m='mise run'
alias pn='pnpm'
alias gst='git status'
alias gdi='git diff'
alias gf='git pull'
alias myip='curl myip.ipip.net'

if command -q brew
    alias bubu='brew update && brew outdated && brew upgrade && brew cleanup'
end
