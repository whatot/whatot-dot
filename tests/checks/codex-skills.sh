#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=tests/lib/check-common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)/lib/check-common.sh"

SKILLS_DIR="${ROOT_DIR}/home/dot_codex/skills"
ALLOWED_FRONTMATTER_KEYS="name description allowed-tools metadata compatibility"

skill_name_from_file() {
  sed -n 's/^name:[[:space:]]*//p' "$1" | head -n 1
}

skill_description_from_file() {
  sed -n 's/^description:[[:space:]]*//p' "$1" | head -n 1
}

frontmatter_end_line() {
  awk 'NR > 1 && $0 == "---" { print NR; exit }' "$1"
}

is_allowed_frontmatter_key() {
  local key=$1
  local allowed

  for allowed in ${ALLOWED_FRONTMATTER_KEYS}; do
    if [[ "${key}" == "${allowed}" ]]; then
      return 0
    fi
  done

  return 1
}

validate_frontmatter_keys() {
  local skill_file=$1
  local end_line=$2
  local line
  local key
  local value
  local failed=0

  while IFS= read -r line; do
    [[ -z "${line}" || "${line}" =~ ^[[:space:]]*# ]] && continue

    if [[ "${line}" =~ ^([A-Za-z0-9_-]+): ]]; then
      key="${BASH_REMATCH[1]}"
      value="${line#*:}"
      value="${value#"${value%%[![:space:]]*}"}"
      if ! is_allowed_frontmatter_key "${key}"; then
        printf 'ERROR: %s has unsupported frontmatter key: %s\n' "${skill_file}" "${key}" >&2
        failed=1
      fi

      if [[ "${value}" == *": "* && ! "${value}" =~ ^(\"|\047|\||\>|\[|\{) ]]; then
        printf 'ERROR: %s frontmatter key "%s" has an unquoted colon-space value\n' "${skill_file}" "${key}" >&2
        failed=1
      fi
    elif [[ "${line}" =~ ^[[:space:]] ]]; then
      continue
    else
      printf 'ERROR: %s has unsupported frontmatter line: %s\n' "${skill_file}" "${line}" >&2
      failed=1
    fi
  done < <(sed -n "2,$((end_line - 1))p" "${skill_file}")

  return "${failed}"
}

validate_local_links() {
  local skill_file=$1
  local skill_dir=$2
  local link
  local target
  local path
  local failed=0

  while IFS= read -r link; do
    target="$(printf '%s\n' "${link}" | sed 's/^[^()]*(//; s/)$//')"

    case "${target}" in
      "" | "#"* | http://* | https://* | mailto:*)
        continue
        ;;
    esac

    path="${target%%#*}"
    [[ -z "${path}" ]] && continue

    if [[ ! -e "${skill_dir}/${path}" ]]; then
      printf 'ERROR: %s links to missing local file: %s\n' "${skill_file}" "${target}" >&2
      failed=1
    fi
  done < <(grep -Eo '\[[^]]+\]\([^)]+\)' "${skill_file}" || true)

  return "${failed}"
}

validate_safety_boundaries() {
  local skill_file=$1
  local failed=0

  if grep -Eq '/Users/[^ )"]+' "${skill_file}"; then
    printf 'ERROR: %s contains a hardcoded /Users path\n' "${skill_file}" >&2
    failed=1
  fi

  if grep -Eq 'rm -rf|sudo[[:space:]]|git reset --hard|git checkout --|chmod -R|chown -R|ifconfig .*(down|up)|networksetup|killall' "${skill_file}"; then
    if ! grep -Eiq 'approval|approve|confirm|explicit|ask|user approval' "${skill_file}"; then
      printf 'ERROR: %s mentions dangerous commands without an explicit approval boundary\n' "${skill_file}" >&2
      failed=1
    fi
  fi

  return "${failed}"
}

validate_reference_files() {
  local skill_dir=$1
  local ref_file
  local line_count
  local failed=0

  if [[ ! -d "${skill_dir}/references" ]]; then
    return 0
  fi

  while IFS= read -r ref_file; do
    if ! grep -Eq '^# ' "${ref_file}"; then
      printf 'ERROR: %s missing H1 heading\n' "${ref_file}" >&2
      failed=1
    fi

    line_count="$(wc -l <"${ref_file}" | tr -d ' ')"
    if [[ "${line_count}" -gt 200 ]]; then
      printf 'ERROR: %s is too long (%s > 200 lines)\n' "${ref_file}" "${line_count}" >&2
      failed=1
    fi

    validate_safety_boundaries "${ref_file}" || failed=1
  done < <(rg --files -g '*.md' "${skill_dir}/references" | sort)

  return "${failed}"
}

validate_spec_workflow_references() {
  local skill_dir=$1
  local required
  local example
  local specs_dir
  local active
  local failed=0

  if [[ "$(basename "${skill_dir}")" != "spec-workflow" ]]; then
    return 0
  fi

  for required in specify plan tasks execute index; do
    if [[ ! -f "${skill_dir}/references/${required}.md" ]]; then
      printf 'ERROR: spec-workflow missing references/%s.md\n' "${required}" >&2
      failed=1
    fi
  done

  for example in index.json context.md spec.md checklists.md plan.md tasks.md; do
    if [[ ! -f "${skill_dir}/examples/${example}" ]]; then
      printf 'ERROR: spec-workflow missing examples/%s\n' "${example}" >&2
      failed=1
    fi
  done

  if [[ -f "${skill_dir}/examples/index.json" ]]; then
    if ! jq empty "${skill_dir}/examples/index.json" >/dev/null; then
      printf 'ERROR: spec-workflow examples/index.json is not valid JSON\n' >&2
      failed=1
    else
      specs_dir="$(sed -n 's/^- Specs Dir:[[:space:]]*//p' "${skill_dir}/examples/context.md" | head -n 1)"
      active="$(jq -r '.projects[0].active // ""' "${skill_dir}/examples/index.json")"
      if [[ -n "${specs_dir}" && -n "${active}" && "${specs_dir}" != "${active}" ]]; then
        printf 'ERROR: spec-workflow example context Specs Dir does not match index active\n' >&2
        failed=1
      fi
    fi
  fi

  return "${failed}"
}

validate_skill() {
  local skill_dir=$1
  local names_file=$2
  local skill_file="${skill_dir}/SKILL.md"
  local dir_name
  local name
  local description
  local end_line
  local line_count
  local failed=0

  dir_name="$(basename "${skill_dir}")"

  if [[ ! -f "${skill_file}" ]]; then
    printf 'ERROR: %s missing SKILL.md\n' "${skill_dir}" >&2
    return 1
  fi

  if [[ "$(sed -n '1p' "${skill_file}")" != "---" ]]; then
    printf 'ERROR: %s must start with YAML frontmatter\n' "${skill_file}" >&2
    failed=1
  fi

  end_line="$(frontmatter_end_line "${skill_file}")"
  if [[ -z "${end_line}" ]]; then
    printf 'ERROR: %s has unterminated YAML frontmatter\n' "${skill_file}" >&2
    failed=1
    end_line=1
  else
    validate_frontmatter_keys "${skill_file}" "${end_line}" || failed=1
  fi

  name="$(skill_name_from_file "${skill_file}")"
  description="$(skill_description_from_file "${skill_file}")"

  if [[ -z "${name}" ]]; then
    printf 'ERROR: %s missing name\n' "${skill_file}" >&2
    failed=1
  elif grep -Fxq "${name}" "${names_file}"; then
    printf 'ERROR: duplicate Codex skill name: %s\n' "${name}" >&2
    failed=1
  elif [[ "${name}" != "${dir_name}" ]]; then
    printf 'ERROR: %s name "%s" does not match directory "%s"\n' "${skill_file}" "${name}" "${dir_name}" >&2
    failed=1
  elif [[ ! "${name}" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; then
    printf 'ERROR: %s name must be kebab-case: %s\n' "${skill_file}" "${name}" >&2
    failed=1
  fi
  [[ -n "${name}" ]] && printf '%s\n' "${name}" >>"${names_file}"

  if [[ -z "${description}" ]]; then
    printf 'ERROR: %s missing description\n' "${skill_file}" >&2
    failed=1
  elif [[ ${#description} -lt 40 ]]; then
    printf 'ERROR: %s description is too short (%s < 40)\n' "${skill_file}" "${#description}" >&2
    failed=1
  elif [[ ${#description} -gt 300 ]]; then
    printf 'ERROR: %s description is too long (%s > 300)\n' "${skill_file}" "${#description}" >&2
    failed=1
  fi

  if ! tail -n "+$((end_line + 1))" "${skill_file}" | grep -Eq '^# '; then
    printf 'ERROR: %s missing body H1 heading\n' "${skill_file}" >&2
    failed=1
  fi

  line_count="$(wc -l <"${skill_file}" | tr -d ' ')"
  if [[ "${line_count}" -gt 250 ]]; then
    printf 'ERROR: %s is too long (%s > 250 lines); split references out\n' "${skill_file}" "${line_count}" >&2
    failed=1
  fi

  validate_local_links "${skill_file}" "${skill_dir}" || failed=1
  validate_safety_boundaries "${skill_file}" || failed=1
  validate_reference_files "${skill_dir}" || failed=1
  validate_spec_workflow_references "${skill_dir}" || failed=1

  return "${failed}"
}

validate_skills() {
  local skill_dir
  local skill_file
  local tmp_dir
  local names_file
  local count=0
  local failed=0

  if [[ ! -d "${SKILLS_DIR}" ]]; then
    printf 'ERROR: missing %s\n' "${SKILLS_DIR}" >&2
    return 1
  fi

  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "${tmp_dir:-}"' RETURN
  names_file="${tmp_dir}/names"
  : >"${names_file}"

  while IFS= read -r skill_file; do
    skill_dir="$(dirname "${skill_file}")"
    count=$((count + 1))
    validate_skill "${skill_dir}" "${names_file}" || failed=1
  done < <(rg --files -g SKILL.md "${SKILLS_DIR}" | sort)

  if [[ "${count}" -eq 0 ]]; then
    printf 'ERROR: no Codex skills found in %s\n' "${SKILLS_DIR}" >&2
    return 1
  fi

  if [[ "${failed}" -ne 0 ]]; then
    return 1
  fi

  printf 'ok codex skills (%s)\n' "${count}"
}

main() {
  run_step "validate codex skills" validate_skills
}

main "$@"
