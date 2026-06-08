---
name: document-review
description: "用于评审工程文档、设计文档、plan、runbook、blueprint 或 PRD；匹配评审文档、审 plan、review design doc、doc review；关注一致性、边界、可执行性和风险。"
---

# Document Review

Use this skill when the user asks to review an engineering document, design
doc, plan, runbook, blueprint, PRD, or similar artifact.

Do not use this skill for codebase audits, paper reviews, or general project
overviews. Use the codebase, paper, or overview skill for those tasks.

## Core Rule

Review the document as a decision and execution surface. Findings should show
how the current text could mislead a reader, block implementation, hide risk, or
produce the wrong next action.

## Review Lenses

Read the target document first. Read referenced files only when they are needed
to verify a claim, resolve a contradiction, or understand the document's layer.

Check:

- Coherence: contradictions, terminology drift, stale references, or mismatched
  section intent.
- Scope: unclear goals, missing non-goals, scope creep, or mixed blueprint /
  runbook / execution content.
- Feasibility: sequencing gaps, missing dependencies, unowned decisions, or
  steps that cannot be executed as written.
- Evidence: claims without sources, assumptions presented as facts, or decisions
  that do not name their rationale.
- Risk: security, data, migration, rollback, operational, or user-impact risks
  that the document should surface.
- Verification: missing acceptance checks, test strategy, rollback criteria, or
  concrete done signals.
- Reader actionability: whether the next engineer can act without inventing the
  missing plan.

## Finding Discipline

Rank findings by reader impact:

- P1: the document would likely drive wrong or unsafe implementation.
- P2: a material gap or ambiguity could waste work or hide meaningful risk.
- P3: clarity, maintainability, or polish issue with limited execution risk.

For each finding, include:

- File and line reference when available.
- Confidence: direct evidence, supported inference, or low-confidence
  observation.
- Impact on the reader or execution path.
- A concrete repair direction.

Do not promote style preferences above execution risks. If a point is only an
editorial preference, label it as optional polish.

## Output

Lead with findings ordered by severity. If there are no actionable findings,
say so clearly and mention any residual uncertainty.

After findings, include a short section for:

- Open questions or assumptions.
- Suggested edits or next review focus.

Only rewrite the document when the user explicitly asks for edits.
