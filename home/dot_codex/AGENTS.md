# Global Codex Guidance

- Keep global rules small and durable.
- Put repository-specific rules in each repo's `AGENTS.md`.
- Put reusable task behavior in `~/.codex/skills`.
- Use local Codex skills when a task matches their description.
- For broad, risky, or ambiguous tasks, clarify goal, scope, non-goals, and the
  smallest useful verification before editing.
- Prefer small, evidence-backed guidance updates over broad rewrites.
- For GitLab closeout, create the MR with push options `merge_request.create`
  and `merge_request.target=<base>`—never `glab`, a browser, or an empty
  commit—and report success with its URL; then use the GitLab API to keep only
  the newest `merge_request_event` pipeline for the MR/SHA.
