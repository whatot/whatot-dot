---
name: feature-planning
description: Use when turning a feature, refactor, or larger change into tracked spec, checklist, plan, task, and execution artifacts; supports Chinese requests like 先规划, 拆任务, 做方案, 按计划执行, 继续执行, 追踪执行.
---

# Feature Planning

Use this skill as the single entrypoint for tracked planning and execution. It
owns the specs directory, phase order, gates, and resume behavior. Stage details
live in references and should be loaded only when needed.

## Core Contract

- Keep one user-facing skill entrypoint; do not require the user to pick a
  separate specify, plan, task, or execute skill.
- Put planning artifacts outside target repos under `$HOME/specs` by default.
- `spec.md` answers what and why.
- `checklists.md` records requirement quality, coverage, and execution
  readiness gates.
- `plan.md` answers how.
- `tasks.md` is the execution queue.
- Resolve material uncertainty before bulk execution. Ask at most three
  blocking questions at a time; document low-risk assumptions and continue.
- Prefer evidence from the target repo over generic methodology.
- Use `rg --files` for repo discovery; avoid `find` unless `rg` is unavailable
  or a filesystem-specific predicate is required.
- Do not add spec-kit constitution, hooks, extensions, command installation, or
  multi-file checklist directories unless the user explicitly asks.

## Specs Directory

Default path:

```text
$HOME/specs/<repo-name>/<date-slug>/
  context.md
  spec.md
  checklists.md
  plan.md
  tasks.md
```

Lookup index:

```text
$HOME/specs/index.json
```

Rules:

- Derive `<repo-name>` from the target repo directory basename.
- Use `<date-slug>` as `YYYYMMDD-HHMM-<short-feature-slug>`.
- If the user provides an existing specs path, resume there.
- Maintain `$HOME/specs/index.json` as the lightweight lookup index.
- Do not write planning artifacts into the target repo unless the user asks.
- Do not hardcode machine-local absolute paths in reusable instructions.
- In real `$HOME/specs` artifacts, record the resolved target repo path so index
  matching is reliable; tracked examples use `$HOME` placeholders to stay
  portable.
- Load [references/index.md](references/index.md) before creating, repairing, or
  updating `index.json`.
- Use files under `examples/` as the concrete artifact format examples instead
  of duplicating large templates in references.

## Specs Resolution

When the user does not provide a specs path:

1. Infer the target repo from the current working directory or an explicit repo
   path in the request.
2. Read `$HOME/specs/index.json` and prefer entries whose repo matches the
   target repo.
3. Prefer an active specs directory with unchecked tasks in `tasks.md`.
4. If exactly one active match exists, use it.
5. If multiple active matches exist, ask the user to choose from short labels
   built from `<date-slug>` and the goal.
6. If no active match exists, use the latest specs directory for that repo only
   when the request clearly says to resume; otherwise create a new one.
7. If the index is missing or stale, rebuild it from
   `$HOME/specs/<repo-name>/*/context.md` and continue.

The user should be able to say `继续执行`, `按计划执行`, or `继续 T003` from
inside a target repo without pasting the specs path.

Treat `context.md` as authoritative. Treat `index.json` as a convenience cache
and current-plan pointer.

## Stage Router

For a new tracked plan:

1. Load [references/specify.md](references/specify.md) and create or update
   `context.md` and `spec.md`.
2. Load [references/plan.md](references/plan.md) and create or update
   `checklists.md` and `plan.md`.
3. Load [references/tasks.md](references/tasks.md) and create or update
   `tasks.md`.
4. Stop before code edits unless the user also asked to execute. Report the
   specs directory, open questions, and task summary.

For broad execution or "continue":

1. Resolve the specs directory using the rules above.
2. Read `context.md`, `spec.md`, `checklists.md`, `plan.md`, and `tasks.md`.
3. Load [references/execute.md](references/execute.md).
4. Re-run the execution gate before editing code.
5. Execute unchecked tasks in dependency order, unless the user named a narrow
   checkpoint task.

For partial or missing artifacts:

- Load the reference for the earliest missing or stale stage.
- Update downstream artifacts after upstream changes.
- Do not skip gates just because a later artifact already exists.
- If `spec.md` changes, treat `checklists.md`, `plan.md`, and `tasks.md` as
  stale until refreshed.
- If `plan.md` changes, treat `tasks.md` as stale until refreshed.

## Required Gates

Specification gate:

- Goal, non-goals, requirements, acceptance criteria, assumptions, and open
  questions are explicit.
- Critical ambiguity is resolved or limited to at most three blocking questions.

Planning gate:

- `plan.md` names current state, approach, files/modules, alternatives, risks,
  compatibility notes, and verification.
- `checklists.md` records requirement quality, artifact freshness, coverage, and
  execution readiness.

Task gate:

- `tasks.md` has stable `T###` IDs, dependency ordering, file paths where useful,
  and verification work.
- Each requirement is covered by task IDs or intentionally deferred with
  rationale.

Execution gate:

- No open question can materially change implementation direction.
- Verification commands are known or the plan explains how to discover them.
- Risks, edge cases, and better local patterns have been considered.

## Resume Rules

- Treat `context.md` as the source of truth for repo, branch, base commit, goal,
  and specs directory.
- On resume, check whether the target repo branch or base commit changed; if it
  did, refresh the plan before executing.
- Use `index.json` to find active specs, but repair it from `context.md` when
  the two disagree.
- Update `tasks.md` only after verification succeeds.
- Append concise execution notes with completed task IDs, changed files, and
  verification commands.
- Keep target repo edits separate from planning artifact edits in the final
  summary.
