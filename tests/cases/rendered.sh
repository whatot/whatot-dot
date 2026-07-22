#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=tests/cases/_common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)/_common.sh"

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

check_fish_specs() {
  local output_path
  local label

  for output_path in "$@"; do
    label=${output_path#"${ROOT_DIR}/home/dot_config/fish/"}
    run_step "fish -n ${label}" dotfiles_check_run_tool fish -n "${output_path}"
  done
}

check_platform_ignored_paths() {
  local linux_managed

  linux_managed="$(dotfiles_check_run_tool chezmoi managed \
    --source "${ROOT_DIR}" \
    --override-data '{"chezmoi":{"os":"linux"}}' \
    --path-style relative)"
  if printf '%s\n' "${linux_managed}" | grep -E '^Library(/|$)' >/dev/null; then
    echo "Library paths must not be managed on non-Darwin targets" >&2
    return 1
  fi
}

check_rustc_wrapper_environment() {
  local test_home=$1
  local profile_path="${ROOT_DIR}/home/dot_config/dotfiles/profile.sh"
  local fish_path="${ROOT_DIR}/home/dot_config/fish/conf.d/30-tools.fish"
  local output

  # The nested shell expands these variables.
  # shellcheck disable=SC2016
  output="$(env -u CODEX_SANDBOX -u RUSTC_WRAPPER HOME="${test_home}" bash -c '
    sccache() { :; }
    source "$1"
    printf "%s" "${RUSTC_WRAPPER-unset}"
  ' _ "${profile_path}")"
  [[ "${output}" == "sccache" ]]

  output="$(HOME="${test_home}" CODEX_SANDBOX=seatbelt RUSTC_WRAPPER=sccache bash -c '
    source "$1"
    printf "%s" "${RUSTC_WRAPPER-unset}"
  ' _ "${profile_path}")"
  [[ "${output}" == "unset" ]]

  output="$(HOME="${test_home}" CODEX_SANDBOX=seatbelt RUSTC_WRAPPER=custom-wrapper bash -c '
    source "$1"
    printf "%s" "${RUSTC_WRAPPER-unset}"
  ' _ "${profile_path}")"
  [[ "${output}" == "custom-wrapper" ]]

  # Fish expands these variables.
  # shellcheck disable=SC2016
  output="$(dotfiles_check_run_tool fish -c '
    set -e CODEX_SANDBOX
    set -e RUSTC_WRAPPER
    function sccache; end
    source $argv[1]
    printf "%s" "$RUSTC_WRAPPER"
  ' "${fish_path}")"
  [[ "${output}" == "sccache" ]]

  # Fish expands these variables.
  # shellcheck disable=SC2016
  output="$(dotfiles_check_run_tool fish -c '
    set -gx CODEX_SANDBOX seatbelt
    set -gx RUSTC_WRAPPER sccache
    source $argv[1]
    set -q RUSTC_WRAPPER; or printf unset
  ' "${fish_path}")"
  [[ "${output}" == "unset" ]]

  # Fish expands these variables.
  # shellcheck disable=SC2016
  output="$(dotfiles_check_run_tool fish -c '
    set -gx CODEX_SANDBOX seatbelt
    set -gx RUSTC_WRAPPER custom-wrapper
    source $argv[1]
    printf "%s" "$RUSTC_WRAPPER"
  ' "${fish_path}")"
  [[ "${output}" == "custom-wrapper" ]]
}

main() {
  local host_data_file
  local tmp_dir
  local tmp_home
  local rendered_zshrc
  local rendered_vimrc
  local fish_file
  local -a render_specs=()
  local -a zsh_specs=()
  local -a fish_specs=()

  dotfiles_check_load_env
  run_step "preflight rendered dotfiles" "${ROOT_DIR}/scripts/preflight"
  host_data_file="$(dotfiles_host_file)"

  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "${tmp_dir:-}"' EXIT
  tmp_home="${tmp_dir}/home"
  mkdir -p "${tmp_home}/.vim/autoload"

  rendered_zshrc="${tmp_dir}/.zshrc"
  rendered_vimrc="${tmp_home}/.vimrc"

  render_specs=(
    "zshenv:${ROOT_DIR}/home/dot_zshenv:${tmp_dir}/.zshenv"
    "zprofile:${ROOT_DIR}/home/dot_zprofile:${tmp_dir}/.zprofile"
    "zshrc:${ROOT_DIR}/home/dot_zshrc:${rendered_zshrc}"
    "vimrc:${ROOT_DIR}/home/dot_vimrc.tmpl:${rendered_vimrc}"
  )
  zsh_specs=(
    "zshenv:${tmp_dir}/.zshenv"
    "zprofile:${tmp_dir}/.zprofile"
    "zshrc:${rendered_zshrc}"
  )
  while IFS= read -r fish_file; do
    fish_specs+=("${fish_file}")
  done < <(find "${ROOT_DIR}/home/dot_config/fish" -type f -name '*.fish' | sort)

  render_template_specs "${host_data_file}" "${render_specs[@]}"
  run_step "chezmoiignore platform paths" check_platform_ignored_paths
  run_step "rustc wrapper environment" check_rustc_wrapper_environment "${tmp_home}"

  cp "${ROOT_DIR}/home/dot_vim/"*.vim "${tmp_home}/.vim/"
  dotfiles_check_write_vim_plug_stub "${tmp_home}/.vim/autoload/plug.vim"

  check_rendered_zsh_specs "${zsh_specs[@]}"
  check_fish_specs "${fish_specs[@]}"
  run_step "zsh source rendered zshrc" env HOME="${tmp_home}" PATH="/usr/bin:/bin:/usr/sbin:/sbin" zsh -fc \
    "source ${rendered_zshrc}; whence -w setproxy >/dev/null; whence -w unsetproxy >/dev/null"
  run_step "vim load rendered vimrc" env HOME="${tmp_home}" vim -Nu NONE -n -es \
    -c "set nomore" \
    -c "source ${rendered_vimrc}" \
    -c "quitall"
}

main "$@"
