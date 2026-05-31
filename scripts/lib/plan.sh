#!/usr/bin/env bash

dotfiles_normalize_host() {
  local host=$1

  host="${host##*/}"
  host="${host%.toml}"
  printf '%s\n' "${host}"
}

dotfiles_host() {
  local host

  if [[ -z ${DOTFILES_HOST:-} ]]; then
    echo "missing DOTFILES_HOST" >&2
    echo "set DOTFILES_HOST in your private env file" >&2
    return 1
  fi

  host="$(dotfiles_normalize_host "${DOTFILES_HOST}")"
  if [[ -z "${host}" ]]; then
    echo "invalid DOTFILES_HOST: ${DOTFILES_HOST}" >&2
    return 1
  fi

  printf '%s\n' "${host}"
}

dotfiles_host_file() {
  local host
  host="$(dotfiles_host)"

  if [[ -r "${ROOT_DIR}/hosts/${host}.toml" ]]; then
    printf '%s\n' "${ROOT_DIR}/hosts/${host}.toml"
  else
    echo "unknown host: ${host}" >&2
    echo "set DOTFILES_HOST or create hosts/${host}.toml" >&2
    return 1
  fi
}

dotfiles_array_from_file() {
  local file=$1
  local key=$2

  awk -v key="${key}" '
    function emit_values(text, value) {
      while (match(text, /"([^"\\]|\\.)*"/)) {
        value = substr(text, RSTART + 1, RLENGTH - 2)
        gsub(/\\"/, "\"", value)
        gsub(/\\\\/, "\\", value)
        print value
        text = substr(text, RSTART + RLENGTH)
      }
    }

    !capturing && $0 ~ "^[[:space:]]*" key "[[:space:]]*=" {
      capturing = 1
      line = $0
      sub(/^[^=]*=/, "", line)
      emit_values(line)
      if (line ~ /\]/) {
        capturing = 0
      }
      next
    }

    capturing {
      emit_values($0)
      if ($0 ~ /\]/) {
        capturing = 0
      }
    }
  ' "${file}"
}

dotfiles_host_array() {
  local key=$1
  local file
  file="$(dotfiles_host_file)"
  dotfiles_array_from_file "${file}" "${key}" | awk '!seen[$0]++'
}

dotfiles_split_override() {
  printf '%s\n' "$1" | tr ',[:space:]' '\n' | awk 'NF && !seen[$0]++'
}

dotfiles_package_sets() {
  if [[ -n ${DOTFILES_PACKAGES:-} ]]; then
    dotfiles_split_override "${DOTFILES_PACKAGES}"
  else
    dotfiles_host_array packages
  fi
}

dotfiles_devtools() {
  if [[ -n ${DOTFILES_DEVTOOLS:-} ]]; then
    dotfiles_split_override "${DOTFILES_DEVTOOLS}"
  else
    dotfiles_host_array devtools
  fi
}
