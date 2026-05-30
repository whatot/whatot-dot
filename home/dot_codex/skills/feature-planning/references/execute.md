# Execute Stage

Use this stage for broad execution, "continue", or a named task checkpoint.

## Preflight

Read `context.md`, `spec.md`, `checklists.md`, `plan.md`, and `tasks.md`.

Before editing code:

- Confirm all required artifacts exist. If one is missing, return to the
  earliest missing stage.
- Confirm the target repo, branch, and base commit still match `context.md`; if
  not, refresh the plan.
- Confirm `checklists.md` does not mark any artifact stale.
- Confirm no open question can materially change implementation direction.
- Confirm `tasks.md` is dependency ordered and has clear completion signals.
- Confirm verification commands are known or discoverable from the repo.

## Analyze Pass

Before broad execution, do a read-only consistency pass:

- Requirements without task coverage
- Tasks without a source in `spec.md` or `plan.md`
- Stale artifacts in `checklists.md`
- Missing or unclear verification
- Blocking questions that remain open

If any item can materially change implementation, stop before editing code and
update artifacts or ask the user.

## Execution

- Default to executing unchecked tasks in dependency order for broad execution.
- Execute only a named task when the user asks for a narrow checkpoint.
- Work phase by phase when phases exist: setup, foundation, increments,
  integration, then polish.
- Implement the smallest coherent change for each task.
- Run relevant verification before marking a task complete.
- Update `tasks.md` only after verification succeeds.
- Append concise execution notes with task IDs, changed files, and commands.
- Update `$HOME/specs/index.json` status after execution: keep active while
  unchecked tasks remain, mark done when all tasks are complete, and mark
  blocked when execution stops on a blocker. Also update `current_task`,
  `last_error`, and `updated` using `references/index.md`.

## Stop Conditions

Stop and report instead of guessing when:

- A missing decision would change scope, architecture, compatibility, or
  user-visible behavior.
- Verification repeatedly fails and the fix path is unclear.
- The repo has changed enough that the plan is stale.
- A risk appears that materially changes `spec.md` or `plan.md`.

## Final Report

Report:

- Completed task IDs
- Changed files
- Verification commands and results
- Remaining unchecked tasks or blockers
- Any planning artifacts updated during execution
