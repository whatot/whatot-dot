---
name: task-guardrails
description: "用于启动范围较大、风险较高、边界模糊或需要先评审的工作；匹配先分析、边界、风险、方案；先明确目标、边界、验证和停机点。"
---

# Task Guardrails

Use this skill before work that is broad, risky, ambiguous, or easy to overdo.
It keeps the task anchored without turning every small request into a ceremony.

## Contract

Before editing, identify:

- Goal: what outcome the user actually asked for.
- Source of truth: live runtime, local repo, docs, logs, config, or user-provided
  facts.
- Scope: files, modules, systems, or behaviors that are in bounds.
- Non-goals: tempting cleanup or refactors to avoid.
- Acceptance: what will make the task done.
- Verification: the smallest useful checks to run.

For simple one-file changes, keep this mental and proceed. For larger changes,
share a short plan and then execute.

## Risk Sorting

When reviewing or choosing fixes, prioritize findings by:

- Impact: user-visible breakage, data loss, security, or operational risk.
- Confidence: direct evidence beats style concerns.
- Effort: prefer small fixes when impact is similar.
- Blast radius: shared behavior needs broader verification.

## Hard Boundaries

- Do not widen the task because nearby code looks messy.
- Do not rewrite global rules or shared configuration without a concrete reason.
- Do not stage unrelated dirty files.
- Do not present a guess as confirmed current state.
- If the source of truth is likely to drift and is cheap to verify, verify it.

## Expected Output

For broad work, report:

- Chosen scope.
- Important constraints.
- Verification result.
- Follow-up candidates that were intentionally left out.
