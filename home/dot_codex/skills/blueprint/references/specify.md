# Specify Stage

Use this stage to create or refresh `context.md` and `spec.md`.

## Inputs

- User goal or feature/refactor description.
- Target repo path and current branch/commit when available.
- Existing specs directory when resuming.

## Context

`context.md` records:

- Repo
- Branch
- Base Commit
- Created
- Updated
- Goal
- Specs Dir
- Related Files
- Useful Commands

For real artifacts, write the resolved target repo path in `Repo`. The tracked
example uses a `$HOME` placeholder only to avoid machine-local paths in this
dotfiles repo.

Use `examples/context.md` from the skill root as the concrete format example.

Also create or update `$HOME/specs/index.json` using
`references/index.md`. Use the index for lookup, not as the source of truth. If
it disagrees with `context.md`, trust `context.md` and repair the index.

## Spec

`spec.md` records:

- Goal
- Non-Goals
- User/Operator Scenarios
- Requirements
- Acceptance Criteria
- Assumptions
- Open Questions
- Clarifications

Use `examples/spec.md` from the skill root as the concrete format example.

## Clarification Scan

Before planning, scan for material uncertainty across:

- Functional scope and out-of-scope behavior
- Data, state, identity, and lifecycle rules
- UX, operator flow, errors, empty states, and accessibility when relevant
- Performance, reliability, security, privacy, observability, and compatibility
- External integrations, formats, protocols, and failure modes
- Edge cases, conflict handling, and recovery behavior
- Constraints, tradeoffs, terminology, and completion signals

Ask only questions that materially affect architecture, task decomposition,
validation, or user-visible behavior. Ask at most three blocking questions at a
time. For low-risk gaps, document assumptions and proceed.

When the user answers a blocking question, write it back to `spec.md` under
`## Clarifications` as `Q: ... A: ...`, then update the affected requirements,
acceptance criteria, assumptions, or open questions. Do not leave the answer only
in chat history.

## Quality Rules

- Keep implementation details out of `spec.md` unless the user asks for a
  technical spec.
- Make requirements testable and acceptance criteria verifiable.
- Replace vague adjectives such as fast, robust, or intuitive with measurable or
  inspectable outcomes when they matter.
- If `spec.md` changes after planning, mark downstream artifacts stale in
  `checklists.md` and refresh them before execution.
- If the request is tiny, provide a short inline plan instead of creating
  artifacts unless the user asked for tracking.
