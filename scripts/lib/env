#!/usr/bin/env bash

dotfiles_parse_env_line() {
  local file=$1
  local line_number=$2
  local line=$3
  local key
  local value

  [[ -z "${line//[[:space:]]/}" || "${line}" == \#* ]] && return 0
  if [[ "${line}" != *=* ]]; then
    printf 'invalid env line: %s:%s: missing "="\n' "${file}" "${line_number}" >&2
    return 1
  fi

  key=${line%%=*}
  value=${line#*=}
  key="${key#"${key%%[![:space:]]*}"}"
  key="${key%"${key##*[![:space:]]}"}"
  value="${value#"${value%%[![:space:]]*}"}"
  value="${value%"${value##*[![:space:]]}"}"

  if [[ ! "${key}" =~ ^[A-Za-z_][A-Za-z0-9_]*$ ]]; then
    printf 'invalid env line: %s:%s: invalid key "%s"\n' "${file}" "${line_number}" "${key}" >&2
    return 1
  fi

  case "${value}" in
    \"*\")
      value=${value:1:${#value}-2}
      ;;
    \"*)
      printf 'invalid env line: %s:%s: unterminated double-quoted value\n' "${file}" "${line_number}" >&2
      return 1
      ;;
    \'*\')
      value=${value:1:${#value}-2}
      ;;
    \'*)
      printf 'invalid env line: %s:%s: unterminated single-quoted value\n' "${file}" "${line_number}" >&2
      return 1
      ;;
    *\"* | *\'*)
      printf 'invalid env line: %s:%s: quotes must wrap the entire value\n' "${file}" "${line_number}" >&2
      return 1
      ;;
  esac

  if [[ ${!key+x} == x ]]; then
    return 0
  fi

  export "${key}=${value}"
}

dotfiles_load_private_env() {
  local file
  local line
  local line_number
  local files=()

  if [[ -n ${DOTFILES_ENV_FILE:-} ]]; then
    files+=("${DOTFILES_ENV_FILE}")
  else
    files+=("${HOME}/.dotfiles.env" "${HOME}/.env_private")
  fi

  for file in "${files[@]}"; do
    [[ -r "${file}" ]] || continue
    line_number=0
    exec 3<"${file}"
    while IFS= read -r line <&3 || [[ -n "${line}" ]]; do
      line_number=$((line_number + 1))
      if ! dotfiles_parse_env_line "${file}" "${line_number}" "${line}"; then
        exec 3<&-
        return 1
      fi
    done
    exec 3<&-
  done
}
