#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=tests/lib/check-common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)/lib/check-common.sh"

main() {
  local host_data_file
  local tmp_dir
  local tmp_home
  local rendered_zshenv
  local rendered_zshrc
  local rendered_network
  local rendered_tools
  local rendered_aliases
  local rendered_prompt
  local rendered_vimrc

  dotfiles_check_load_env
  run_step "preflight rendered dotfiles" "${ROOT_DIR}/scripts/preflight"
  host_data_file="$(dotfiles_host_file)"

  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "${tmp_dir:-}"' EXIT
  tmp_home="${tmp_dir}/home"
  mkdir -p "${tmp_home}/.vim/autoload" "${tmp_home}/.zsh"

  rendered_zshenv="${tmp_dir}/.zshenv"
  rendered_zshrc="${tmp_dir}/.zshrc"
  rendered_network="${tmp_home}/.zsh/network.zsh"
  rendered_tools="${tmp_home}/.zsh/tools.zsh"
  rendered_aliases="${tmp_home}/.zsh/aliases.zsh"
  rendered_prompt="${tmp_home}/.zsh/prompt.zsh"
  rendered_vimrc="${tmp_home}/.vimrc"

  dotfiles_check_render_template "${ROOT_DIR}/home/dot_zshenv.tmpl" "${rendered_zshenv}" "${host_data_file}"
  dotfiles_check_render_template "${ROOT_DIR}/home/dot_zshrc.tmpl" "${rendered_zshrc}" "${host_data_file}"
  dotfiles_check_render_template "${ROOT_DIR}/home/dot_zsh/network.zsh.tmpl" "${rendered_network}" "${host_data_file}"
  dotfiles_check_render_template "${ROOT_DIR}/home/dot_zsh/tools.zsh.tmpl" "${rendered_tools}" "${host_data_file}"
  dotfiles_check_render_template "${ROOT_DIR}/home/dot_zsh/aliases.zsh.tmpl" "${rendered_aliases}" "${host_data_file}"
  dotfiles_check_render_template "${ROOT_DIR}/home/dot_zsh/prompt.zsh.tmpl" "${rendered_prompt}" "${host_data_file}"
  dotfiles_check_render_template "${ROOT_DIR}/home/dot_vimrc.tmpl" "${rendered_vimrc}" "${host_data_file}"

  cp "${ROOT_DIR}/home/dot_vim/"*.vim "${tmp_home}/.vim/"
  dotfiles_check_write_vim_plug_stub "${tmp_home}/.vim/autoload/plug.vim"

  run_step "zsh -n rendered zshenv" dotfiles_check_run_tool zsh -n "${rendered_zshenv}"
  run_step "zsh -n rendered zshrc" dotfiles_check_run_tool zsh -n "${rendered_zshrc}"
  run_step "zsh -n rendered network" dotfiles_check_run_tool zsh -n "${rendered_network}"
  run_step "zsh -n rendered tools" dotfiles_check_run_tool zsh -n "${rendered_tools}"
  run_step "zsh -n rendered aliases" dotfiles_check_run_tool zsh -n "${rendered_aliases}"
  run_step "zsh -n rendered prompt" dotfiles_check_run_tool zsh -n "${rendered_prompt}"
  run_step "zsh source rendered zshrc" env HOME="${tmp_home}" PATH="/usr/bin:/bin:/usr/sbin:/sbin" zsh -fc \
    "source ${rendered_zshrc}; alias m >/dev/null; whence -w setup_prompt >/dev/null; whence -w setproxy >/dev/null"
  run_step "zsh patch git alias completion" env HOME="${tmp_home}" PATH="/usr/bin:/bin:/usr/sbin:/sbin" zsh -fc \
    "source ${rendered_zshrc}; whence -w patch_git_completion_aliases >/dev/null; patch_git_completion_aliases; git help --aliases-for-completion >/dev/null 2>&1 || typeset -f __git_zsh_cmd_alias 2>/dev/null | grep -q \"git config --get-regexp '^alias\\\\.'\" || typeset -f _git | grep -q patch_git_completion_aliases"
  run_step "vim load rendered vimrc" env HOME="${tmp_home}" vim -Nu NONE -n -es \
    -c "set nomore" \
    -c "source ${rendered_vimrc}" \
    -c "quitall"
}

main "$@"
