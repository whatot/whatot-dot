#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=tests/lib/tmpl-common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)/lib/tmpl-common.sh"

TEMPLATE_PATH="${ROOT_DIR}/home/dot_gitconfig.tmpl"

case_no_include_rules() {
  local output

  output="$(dotfiles_tmpl_render "${TEMPLATE_PATH}" \
    DOTFILES_GIT_NAME="Test User" \
    DOTFILES_GIT_EMAIL="test@example.com")"

  dotfiles_tmpl_assert_contains "${output}" $'[user]\n\temail = test@example.com\n\tname = Test User'
  dotfiles_tmpl_assert_not_contains "${output}" '[includeIf "gitdir/i:'
}

case_single_include_rule() {
  local output

  output="$(dotfiles_tmpl_render "${TEMPLATE_PATH}" \
    DOTFILES_GIT_NAME="Test User" \
    DOTFILES_GIT_EMAIL="test@example.com" \
    DOTFILES_GIT_INCLUDE_RULES="~/work:~/.gitconfig_work")"

  dotfiles_tmpl_assert_contains "${output}" $'[includeIf "gitdir/i:~/work/"]\n\tpath = ~/.gitconfig_work'
}

case_multiple_include_rules() {
  local output

  output="$(dotfiles_tmpl_render "${TEMPLATE_PATH}" \
    DOTFILES_GIT_NAME="Test User" \
    DOTFILES_GIT_EMAIL="test@example.com" \
    DOTFILES_GIT_INCLUDE_RULES="~/work:~/.gitconfig_work,~/client:~/.gitconfig_client")"

  dotfiles_tmpl_assert_contains "${output}" $'[includeIf "gitdir/i:~/work/"]\n\tpath = ~/.gitconfig_work'
  dotfiles_tmpl_assert_contains "${output}" $'[includeIf "gitdir/i:~/client/"]\n\tpath = ~/.gitconfig_client'
}

case_include_rule_normalizes_trailing_slash() {
  local output

  output="$(dotfiles_tmpl_render "${TEMPLATE_PATH}" \
    DOTFILES_GIT_NAME="Test User" \
    DOTFILES_GIT_EMAIL="test@example.com" \
    DOTFILES_GIT_INCLUDE_RULES="~/workspace/:~/.gitconfig_workspace")"

  dotfiles_tmpl_assert_contains "${output}" $'[includeIf "gitdir/i:~/workspace/"]\n\tpath = ~/.gitconfig_workspace'
}

case_ignores_incomplete_include_rules() {
  local output

  output="$(dotfiles_tmpl_render "${TEMPLATE_PATH}" \
    DOTFILES_GIT_NAME="Test User" \
    DOTFILES_GIT_EMAIL="test@example.com" \
    DOTFILES_GIT_INCLUDE_RULES="~/work:~/.gitconfig_work,~/broken-only, :~/.gitconfig_empty,~/missing-path:")"

  dotfiles_tmpl_assert_contains "${output}" $'[includeIf "gitdir/i:~/work/"]\n\tpath = ~/.gitconfig_work'
  dotfiles_tmpl_assert_not_contains "${output}" '[includeIf "gitdir/i:~/broken-only/"]'
  dotfiles_tmpl_assert_not_contains "${output}" '[includeIf "gitdir/i:/"]'
  dotfiles_tmpl_assert_not_contains "${output}" 'path = ~/.gitconfig_empty'
  dotfiles_tmpl_assert_not_contains "${output}" '[includeIf "gitdir/i:~/missing-path/"]'
}

main() {
  case_no_include_rules
  case_single_include_rule
  case_multiple_include_rules
  case_include_rule_normalizes_trailing_slash
  case_ignores_incomplete_include_rules
}

main "$@"
