# managed by chezmoi

switch "$DOTFILES_SHELL_OS"
    case Darwin
        fish_add_path --global --move --path "/usr/local/sbin"
        fish_add_path --global --move --path "/usr/local/bin"
        fish_add_path --global --move --path "$HOME/go/bin"
        fish_add_path --global --move --path "$HOME/.cargo/bin"
        fish_add_path --global --move --path "$HOME/.local/bin"
        fish_add_path --global --move --path "/opt/homebrew/opt/coreutils/libexec/gnubin"
        fish_add_path --global --move --path "/opt/homebrew/sbin"
        fish_add_path --global --move --path "/opt/homebrew/bin"
    case Linux
        fish_add_path --global --move --path "$HOME/go/bin"
        fish_add_path --global --move --path "$HOME/.cargo/bin"
        fish_add_path --global --move --path "$HOME/.local/bin"
        set -q TERM; or set -gx TERM xterm-256color
end

if test -d "$HOME/.orbstack/bin"; and not contains -- "$HOME/.orbstack/bin" $PATH
    fish_add_path --global --append --path "$HOME/.orbstack/bin"
end
