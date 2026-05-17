#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd -P)"
TEMPLATE_PATH="${ROOT_DIR}/home/dot_gitconfig.tmpl"

render_template() {
  env "$@" chezmoi execute-template --source "${ROOT_DIR}" --file "${TEMPLATE_PATH}"
}

assert_contains() {
  local haystack=$1
  local needle=$2

  if [[ "${haystack}" != *"${needle}"* ]]; then
    printf 'missing expected snippet:\n%s\n' "${needle}" >&2
    return 1
  fi
}

assert_not_contains() {
  local haystack=$1
  local needle=$2

  if [[ "${haystack}" == *"${needle}"* ]]; then
    printf 'unexpected snippet present:\n%s\n' "${needle}" >&2
    return 1
  fi
}

case_no_include_rules() {
  local output

  output="$(render_template \
    DOTFILES_GIT_NAME="Test User" \
    DOTFILES_GIT_EMAIL="test@example.com")"

  assert_contains "${output}" $'[user]\n\temail = test@example.com\n\tname = Test User'
  assert_not_contains "${output}" '[includeIf "gitdir/i:'
}

case_single_include_rule() {
  local output

  output="$(render_template \
    DOTFILES_GIT_NAME="Test User" \
    DOTFILES_GIT_EMAIL="test@example.com" \
    DOTFILES_GIT_INCLUDE_RULES="~/work:~/.gitconfig_work")"

  assert_contains "${output}" $'[includeIf "gitdir/i:~/work/"]\n\tpath = ~/.gitconfig_work'
}

case_multiple_include_rules() {
  local output

  output="$(render_template \
    DOTFILES_GIT_NAME="Test User" \
    DOTFILES_GIT_EMAIL="test@example.com" \
    DOTFILES_GIT_INCLUDE_RULES="~/work:~/.gitconfig_work,~/client:~/.gitconfig_client")"

  assert_contains "${output}" $'[includeIf "gitdir/i:~/work/"]\n\tpath = ~/.gitconfig_work'
  assert_contains "${output}" $'[includeIf "gitdir/i:~/client/"]\n\tpath = ~/.gitconfig_client'
}

case_include_rule_normalizes_trailing_slash() {
  local output

  output="$(render_template \
    DOTFILES_GIT_NAME="Test User" \
    DOTFILES_GIT_EMAIL="test@example.com" \
    DOTFILES_GIT_INCLUDE_RULES="~/workspace/:~/.gitconfig_workspace")"

  assert_contains "${output}" $'[includeIf "gitdir/i:~/workspace/"]\n\tpath = ~/.gitconfig_workspace'
}

main() {
  case_no_include_rules
  case_single_include_rule
  case_multiple_include_rules
  case_include_rule_normalizes_trailing_slash
}

main "$@"
