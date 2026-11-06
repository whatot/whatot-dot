# Global Codex Guidance

- Keep global rules small and durable.
- Put repository-specific rules in each repo's `AGENTS.md`.
- Put reusable task behavior in `~/.codex/skills`.
- Use local Codex skills when a task matches their description.
- For broad, risky, or ambiguous tasks, clarify goal, scope, non-goals, and the
  smallest useful verification before editing.
- Prefer small, evidence-backed guidance updates over broad rewrites.
- Keep goals, architecture, design, and implementation simple. Improve user,
  developer, and agent experience together while preserving supported behavior.
- Before adding, changing, or reviewing tests, or deciding whether a bug fix needs
  a regression test, read `~/.codex/skills/test-behavior/SKILL.md` and the project's
  testing guidance. Add tests only for a real, uncovered behavior.
- Before designing, implementing, changing, or reviewing product UI, read
  `~/.codex/skills/design-ui/SKILL.md` and the project's design system. Verify
  visual changes in the running interface.
- For GitLab closeout, create the MR with push options `merge_request.create`
  and `merge_request.target=<base>`—never `glab`, a browser, or an empty
  commit—and report success with its URL; then use the GitLab API to keep only
  the newest `merge_request_event` pipeline for the MR/SHA.
