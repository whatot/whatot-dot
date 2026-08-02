# Global Codex Guidance

- Keep global rules small and durable.
- Put repository-specific rules in each repo's `AGENTS.md`.
- Put reusable task behavior in `~/.codex/skills`.
- Use local Codex skills when a task matches their description.
- For broad, risky, or ambiguous tasks, clarify goal, scope, non-goals, and the
  smallest useful verification before editing.
- Prefer small, evidence-backed guidance updates over broad rewrites.
- For GitLab commit/push/MR closeout, use push options `merge_request.create`
  and `merge_request.target=<base>`, not `glab` or a browser; never use an empty
  commit, and report success only with the MR URL.
