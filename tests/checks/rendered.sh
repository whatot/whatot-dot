#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=tests/lib/check-common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)/lib/check-common.sh"

render_template_specs() {
  local host_data_file=$1
  shift
  local spec
  local label
  local template_path
  local output_path

  for spec in "$@"; do
    IFS=':' read -r label template_path output_path <<<"${spec}"
    dotfiles_check_render_template "${template_path}" "${output_path}" "${host_data_file}"
  done
}

check_rendered_zsh_specs() {
  local spec
  local label
  local output_path

  for spec in "$@"; do
    IFS=':' read -r label output_path <<<"${spec}"
    run_step "zsh -n rendered ${label}" dotfiles_check_run_tool zsh -n "${output_path}"
  done
}

main() {
  local host_data_file
  local tmp_dir
  local tmp_home
  local rendered_zshrc
  local rendered_vimrc
  local -a render_specs=()
  local -a zsh_specs=()

  dotfiles_check_load_env
  run_step "preflight rendered dotfiles" "${ROOT_DIR}/scripts/preflight"
  host_data_file="$(dotfiles_host_file)"

  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "${tmp_dir:-}"' EXIT
  tmp_home="${tmp_dir}/home"
  mkdir -p "${tmp_home}/.vim/autoload" "${tmp_home}/.zsh"

  rendered_zshrc="${tmp_dir}/.zshrc"
  rendered_vimrc="${tmp_home}/.vimrc"

  render_specs=(
    "zshenv:${ROOT_DIR}/home/dot_zshenv.tmpl:${tmp_dir}/.zshenv"
    "zprofile:${ROOT_DIR}/home/dot_zprofile.tmpl:${tmp_dir}/.zprofile"
    "zshrc:${ROOT_DIR}/home/dot_zshrc.tmpl:${rendered_zshrc}"
    "network:${ROOT_DIR}/home/dot_zsh/network.zsh.tmpl:${tmp_home}/.zsh/network.zsh"
    "tools:${ROOT_DIR}/home/dot_zsh/tools.zsh.tmpl:${tmp_home}/.zsh/tools.zsh"
    "aliases:${ROOT_DIR}/home/dot_zsh/aliases.zsh.tmpl:${tmp_home}/.zsh/aliases.zsh"
    "prompt:${ROOT_DIR}/home/dot_zsh/prompt.zsh.tmpl:${tmp_home}/.zsh/prompt.zsh"
    "vimrc:${ROOT_DIR}/home/dot_vimrc.tmpl:${rendered_vimrc}"
  )
  zsh_specs=(
    "zshenv:${tmp_dir}/.zshenv"
    "zprofile:${tmp_dir}/.zprofile"
    "zshrc:${rendered_zshrc}"
    "network:${tmp_home}/.zsh/network.zsh"
    "tools:${tmp_home}/.zsh/tools.zsh"
    "aliases:${tmp_home}/.zsh/aliases.zsh"
    "prompt:${tmp_home}/.zsh/prompt.zsh"
  )

  render_template_specs "${host_data_file}" "${render_specs[@]}"

  cp "${ROOT_DIR}/home/dot_vim/"*.vim "${tmp_home}/.vim/"
  dotfiles_check_write_vim_plug_stub "${tmp_home}/.vim/autoload/plug.vim"

  check_rendered_zsh_specs "${zsh_specs[@]}"
  run_step "zsh source rendered zshrc" env HOME="${tmp_home}" PATH="/usr/bin:/bin:/usr/sbin:/sbin" zsh -fc \
    "source ${rendered_zshrc}; alias m >/dev/null; whence -w setup_prompt >/dev/null; whence -w setproxy >/dev/null"
  run_step "vim load rendered vimrc" env HOME="${tmp_home}" vim -Nu NONE -n -es \
    -c "set nomore" \
    -c "source ${rendered_vimrc}" \
    -c "quitall"
}

main "$@"
