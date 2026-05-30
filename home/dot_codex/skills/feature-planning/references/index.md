# Index Rules

Use this reference whenever creating, resolving, repairing, or updating
`$HOME/specs/index.json`.

## Schema

Keep the index small and human-readable. Use `examples/index.json` from the
skill root as the concrete format example.

Valid statuses:

- `active`: unfinished work remains.
- `blocked`: execution stopped on a decision or repeated failure.
- `done`: all intended tasks are complete.
- `archived`: hidden from default resume selection but retained for history.

## Merge Rules

- Treat `context.md` as authoritative when it disagrees with the index.
- Match project entries by repo path first, then repo name as fallback.
- Match specs entries by `path`.
- Update only the matched project/specs entry; preserve unknown fields and other
  projects.
- Do not delete entries while repairing the index unless the user asks.
- Keep `active` set to the active specs path, or `null` when no active specs
  remain.

## Concurrent Updates

Multiple Codex threads may update the index. Use a conservative read-merge-write
flow:

1. Read the current index immediately before writing.
2. Merge only the current specs entry.
3. Preserve entries created by other threads.
4. If the write appears to race or fail, re-read, merge again, and retry once.
5. If the conflict remains unclear, update the local artifacts and report that
   index repair is needed.

## Repair

If `index.json` is missing, malformed, or stale:

- Scan `$HOME/specs/<repo-name>/*/context.md` for the target repo.
- Rebuild only the target repo entry when possible.
- Infer status from `tasks.md`: unchecked tasks mean `active`; all checked means
  `done`; explicit blockers mean `blocked`.
- Prefer the newest active specs path as `active`; if multiple active specs
  exist, ask the user to choose.

## Selection

Default resume selection:

1. Exact path from user input.
2. Active entry for the current repo.
3. Single non-archived blocked entry when the user says to resume.
4. Latest non-archived entry only when the user clearly asks to resume old work.

Never silently resume a `done` or `archived` entry.
