# Codex Skills

Codex skills are managed as dotfiles through chezmoi.

The source of truth lives under:

```text
home/dot_codex/skills/<skill>/SKILL.md
```

Chezmoi renders these files to:

```text
~/.codex/skills/<skill>/SKILL.md
```

Keep the first set small and personal. Do not mirror large external skill
collections. When borrowing from another repository, rewrite the skill into the
local workflow instead of symlinking or auto-updating the external source.

## Current Skills

- `systematic-debugging`: evidence-first debugging and stop rules.
- `task-guardrails`: scope, source-of-truth, and verification discipline.
- `disk-cleaner`: read-only disk scans and explicit cleanup approval.
- `optimize-network`: read-only network diagnosis with proxy/VPN protection.
- `codebase-audit`: evidence-backed codebase audit and repair planning.

## Validation

Run the repository check:

```bash
mise run check
```

The Codex skill validation lives in `tests/checks/codex-skills.sh`.

The validator checks:

- `SKILL.md` exists and has closed frontmatter.
- `name` and `description` are present.
- `name` is kebab-case and matches the directory.
- skill names are unique.
- frontmatter keys stay in the allowed set.
- the body has an H1 heading.
- skills stay short enough to avoid hidden prompt bloat.
- local Markdown links point to existing files.
- hardcoded `/Users/...` paths are rejected.
- dangerous commands require an explicit approval boundary.

The validator checks:

- `SKILL.md` exists for each managed skill directory.
- YAML frontmatter starts and ends with `---`.
- Frontmatter keys are limited to the supported Codex skill metadata.
- `name` is present, unique, kebab-case, and matches the directory name.
- `description` is present and kept within a useful length range.
- The body has an H1 heading.
- Very large skills are rejected so shared detail can move to references.
- Local Markdown links point to existing files.
- Hardcoded `/Users/...` paths are rejected.
- Dangerous commands such as `rm -rf`, `sudo`, and network mutation commands
  require an explicit approval boundary in the skill text.
