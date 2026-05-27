# managed by chezmoi

status is-interactive; or return

if command -q bat
    function cat --wraps=bat --description 'Use bat as cat'
        bat $argv
    end
end

switch (uname -s)
    case Darwin
        function ll --wraps='ls -alFG' --description 'List files'
            ls -alFG $argv
        end
    case Linux
        function ll --wraps='ls -alF --color=auto' --description 'List files'
            ls -alF --color=auto $argv
        end
    case '*'
        function ll --wraps='ls -alF' --description 'List files'
            ls -alF $argv
        end
end

function .. --description 'Go up one directory'
    cd ..
end

function ... --description 'Go up two directories'
    cd ../..
end

function m --wraps='mise run' --description 'Run mise task'
    mise run $argv
end

function pn --wraps=pnpm --description 'Run pnpm'
    pnpm $argv
end

function gst --wraps='git status' --description 'Show git status'
    git status $argv
end

function gdi --wraps='git diff' --description 'Show git diff'
    git diff $argv
end

function gf --wraps='git pull' --description 'Pull git changes'
    git pull $argv
end

function myip --wraps=curl --description 'Show public IP'
    curl myip.ipip.net $argv
end

if command -q brew
    function bubu --description 'Update Homebrew packages'
        brew update
        and brew outdated
        and brew upgrade
        and brew cleanup
    end
end
