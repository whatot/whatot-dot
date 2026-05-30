# Tasks Stage

Use this stage to create or refresh `tasks.md` from `spec.md`,
`checklists.md`, and `plan.md`.

Prerequisite: `spec.md`, `checklists.md`, and `plan.md` exist, and
`checklists.md` does not mark upstream artifacts stale.

## Task Format

Use stable markdown checklist tasks:

```text
- [ ] T001 [P?] [Phase?] Action in path/to/file
```

Rules:

- `T###` IDs are stable and ordered for execution.
- `[P]` means the task can run in parallel because it touches different files
  and has no unfinished dependency.
- Phase/story labels are optional; use them when they clarify order or resume.
- Include concrete file paths when useful.
- Each task should have a clear completion signal.

Use `examples/tasks.md` from the skill root as the concrete format example.

## Organization

Prefer phase order:

1. Setup
2. Foundation
3. User or operator increments
4. Integration
5. Polish and validation

Within each increment, put verification before or alongside implementation when
that is natural for the repo. Avoid creating low-value test tasks when the repo
has no useful test surface for the change.

## Coverage

Before execution, ensure:

- Every requirement maps to task IDs or is intentionally deferred.
- Every task traces back to `spec.md` or `plan.md`.
- Non-functional requirements have verification or an explicit reason they
  cannot be verified locally.
- Refresh `checklists.md` after generating tasks so it records requirement to
  task coverage, deferred items, and `tasks.md` freshness.

## Regeneration

If `spec.md` or `plan.md` changes materially, refresh `tasks.md` before
execution. Preserve completed task status only when the task still means the
same thing after the refresh.
