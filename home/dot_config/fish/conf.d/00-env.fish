# managed by chezmoi

set -gx EDITOR vim
set -gx LC_MESSAGES en_US.UTF-8
set -gx HOMEBREW_NO_AUTO_UPDATE 1
set -g fish_greeting
set -g DOTFILES_SHELL_OS (uname -s)

function __dotfiles_setup_env
    set -gx GOPATH "$HOME/go/"

    set -q HOMEBREW_BOTTLE_DOMAIN; or set -gx HOMEBREW_BOTTLE_DOMAIN https://mirrors.ustc.edu.cn/homebrew-bottles
    set -q HOMEBREW_API_DOMAIN; or set -gx HOMEBREW_API_DOMAIN https://mirrors.ustc.edu.cn/homebrew-bottles/api

    set -q RUSTUP_DIST_SERVER; or set -gx RUSTUP_DIST_SERVER https://rsproxy.cn
    set -q RUSTUP_UPDATE_ROOT; or set -gx RUSTUP_UPDATE_ROOT https://rsproxy.cn/rustup

    set -q PUB_HOSTED_URL; or set -gx PUB_HOSTED_URL https://pub.flutter-io.cn
    set -q FLUTTER_STORAGE_BASE_URL; or set -gx FLUTTER_STORAGE_BASE_URL https://storage.flutter-io.cn
end

function __dotfiles_strip_quotes --argument-names value
    set -l value_length (string length -- "$value")
    if test "$value_length" -ge 2
        set -l first_char (string sub -s 1 -l 1 -- "$value")
        set -l last_char (string sub -s -1 -- "$value")
        if test "$first_char" = '"' -a "$last_char" = '"'
            string sub -s 2 -l (math --scale=0 "$value_length - 2") -- "$value"
            return
        end
        if test "$first_char" = "'" -a "$last_char" = "'"
            string sub -s 2 -l (math --scale=0 "$value_length - 2") -- "$value"
            return
        end
    end
    printf '%s\n' "$value"
end

function __dotfiles_load_env_file --argument-names file_path
    test -f "$file_path"; or return
    while read -l line
        set -l line (string trim -- "$line")
        test -n "$line"; or continue
        string match -qr '^#' -- "$line"; and continue
        string match -q '*=*' -- "$line"; or continue

        set -l parts (string split -m 1 '=' -- "$line")
        set -l key (string trim -- "$parts[1]")
        set -l value (string trim -- "$parts[2]")
        string match -qr '^[A-Za-z_][A-Za-z0-9_]*$' -- "$key"; or continue
        set -q "$key"; and continue

        set value (__dotfiles_strip_quotes "$value")
        set -gx "$key" "$value"
    end <"$file_path"
end

function __dotfiles_load_env
    __dotfiles_load_env_file "$HOME/.dotfiles.env"
    __dotfiles_load_env_file "$HOME/.env_private"
end

__dotfiles_load_env
__dotfiles_setup_env

functions -e __dotfiles_load_env __dotfiles_load_env_file __dotfiles_setup_env __dotfiles_strip_quotes
