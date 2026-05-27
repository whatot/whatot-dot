# shellcheck shell=sh
# managed by chezmoi

dotfiles_path_prefer() {
  [ -d "$1" ] || return

  dotfiles_entry=$1
  dotfiles_new_path=$dotfiles_entry
  dotfiles_old_ifs=$IFS
  IFS=:
  for dotfiles_path_entry in $PATH; do
    [ -n "$dotfiles_path_entry" ] || continue
    [ "$dotfiles_path_entry" = "$dotfiles_entry" ] && continue
    case ":$dotfiles_new_path:" in
      *":$dotfiles_path_entry:"*) ;;
      *) dotfiles_new_path="${dotfiles_new_path}:$dotfiles_path_entry" ;;
    esac
  done
  IFS=$dotfiles_old_ifs
  PATH=$dotfiles_new_path
}

dotfiles_path_append() {
  [ -d "$1" ] || return

  case ":${PATH:-}:" in
    *":$1:"*) ;;
    *) PATH="${PATH:+$PATH:}$1" ;;
  esac
}

dotfiles_load_env_file() {
  [ -f "$1" ] || return

  while IFS='=' read -r key value || [ -n "$key" ]; do
    case "$key" in
      '' | \#*) continue ;;
      [!A-Za-z_]* | *[!A-Za-z0-9_]*) continue ;;
    esac

    eval "[ -n \"\${$key+x}\" ]" && continue

    case "$value" in
      \"*\")
        value=${value#\"}
        value=${value%\"}
        ;;
      \'*\')
        value=${value#\'}
        value=${value%\'}
        ;;
    esac

    export "$key=$value"
  done <"$1"
}

export EDITOR="${EDITOR:-vim}"
export LC_MESSAGES="${LC_MESSAGES:-en_US.UTF-8}"
export HOMEBREW_NO_AUTO_UPDATE="${HOMEBREW_NO_AUTO_UPDATE:-1}"

dotfiles_load_env_file "$HOME/.dotfiles.env"
dotfiles_load_env_file "$HOME/.env_private"

case "$(uname -s)" in
  Darwin)
    dotfiles_path_prefer "/usr/local/sbin"
    dotfiles_path_prefer "/usr/local/bin"
    dotfiles_path_prefer "$HOME/go/bin"
    dotfiles_path_prefer "$HOME/.cargo/bin"
    dotfiles_path_prefer "$HOME/.local/bin"
    dotfiles_path_prefer "/opt/homebrew/opt/coreutils/libexec/gnubin"
    dotfiles_path_prefer "/opt/homebrew/sbin"
    dotfiles_path_prefer "/opt/homebrew/bin"
    ;;
  Linux)
    dotfiles_path_prefer "$HOME/go/bin"
    dotfiles_path_prefer "$HOME/.cargo/bin"
    dotfiles_path_prefer "$HOME/.local/bin"
    export TERM="${TERM:-xterm-256color}"
    ;;
esac

dotfiles_path_append "$HOME/.orbstack/bin"

export PATH
export GOPATH="${GOPATH:-$HOME/go/}"
export HOMEBREW_BOTTLE_DOMAIN="${HOMEBREW_BOTTLE_DOMAIN:-https://mirrors.ustc.edu.cn/homebrew-bottles}"
export HOMEBREW_API_DOMAIN="${HOMEBREW_API_DOMAIN:-https://mirrors.ustc.edu.cn/homebrew-bottles/api}"
export RUSTUP_DIST_SERVER="${RUSTUP_DIST_SERVER:-https://rsproxy.cn}"
export RUSTUP_UPDATE_ROOT="${RUSTUP_UPDATE_ROOT:-https://rsproxy.cn/rustup}"
export PUB_HOSTED_URL="${PUB_HOSTED_URL:-https://pub.flutter-io.cn}"
export FLUTTER_STORAGE_BASE_URL="${FLUTTER_STORAGE_BASE_URL:-https://storage.flutter-io.cn}"

unset -f dotfiles_path_prefer
unset -f dotfiles_path_append
unset -f dotfiles_load_env_file
unset dotfiles_entry dotfiles_new_path dotfiles_old_ifs dotfiles_path_entry key value
