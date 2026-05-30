# Plan Stage

Use this stage to create or refresh `checklists.md` and `plan.md` after
`spec.md` is clear enough to plan.

Prerequisite: `context.md` and `spec.md` exist and have no unresolved blocking
questions.

## Repo Scan

Inspect the target repo for:

- Existing architecture and local patterns
- Relevant files, modules, commands, and tests
- Similar implementations to reuse
- Compatibility constraints and migration risks
- Missing context that would change the approach

Use `rg --files` first for discovery.

## Checklists

`checklists.md` is a single lightweight gate document, not a directory. It
records:

- Requirement Quality: clarity, testability, ambiguity, and measurable outcomes
- Artifact Freshness: whether `spec.md`, `plan.md`, and `tasks.md` are current
- Coverage: requirement-to-plan and requirement-to-task mapping
- Execution Readiness: unresolved decisions, verification, and stop conditions
- Deferred Issues: anything intentionally postponed with rationale

Use `examples/checklists.md` from the skill root as the concrete format example.

## Plan

`plan.md` records:

- Current State
- Approach
- Files/Modules
- Alternatives
- Risks
- Verification

Use `examples/plan.md` from the skill root as the concrete format example.

Make the plan detailed enough for bulk execution before code edits begin. Name
concrete files/modules where likely, but do not pretend certainty when the repo
still needs inspection during execution.

## Planning Gate

Before handing off to task generation:

- No open question can materially change scope, architecture, data
  compatibility, user-visible behavior, or verification strategy.
- The chosen approach matches local repo patterns unless the plan explains why
  it should diverge.
- Alternatives and risks are captured briefly.
- Verification commands are known or the plan says how to discover them.
- If `plan.md` changes after tasks exist, mark `tasks.md` stale in
  `checklists.md` and refresh it before execution.
