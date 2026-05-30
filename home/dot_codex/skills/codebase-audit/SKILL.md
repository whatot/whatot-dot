---
name: codebase-audit
description: "用于明确要求代码审计、隐藏 bug 搜索、架构风险或技术债审查的任务；匹配代码库审计、全面检查问题、有哪些风险；优先输出问题、证据、影响和修复建议。"
---

# Codebase Audit

Use this skill when the user asks for a codebase audit, architecture risk
review, hidden-bug search, or technical-debt review.

Do not use this skill for general project orientation such as "analyze this
project", "understand this repo", or "整体了解". Use a project overview skill
for those tasks.

## Core Rule

Find evidence-backed issues, not generic advice. Lead with concrete findings,
then give the repair path.

## Workflow

1. Detect the project shape.
   - Identify languages, frameworks, package managers, test entrypoints, and
     runtime boundaries.
   - Prefer repo files and live commands over README claims.
   - Use `rg --files` to inventory files. Avoid `find` unless `rg` is missing
     or a filesystem-specific predicate is required.

2. Pick audit dimensions that fit the repo.
   - Full stack: frontend-backend contracts, data flow, rendering, API schema,
     config, persistence, auth, and deployment.
   - Backend: request lifecycle, serialization, error handling, persistence,
     auth, background jobs, config, and observability.
   - Frontend: state flow, rendering completeness, API consumption, routing,
     build config, accessibility, and layout risks.
   - Dotfiles or infra: bootstrap path, idempotency, host selection, package
     ownership, secrets boundaries, rollback, and validation.

3. Search for high-signal failures.
   - Declaration without execution.
   - Type or field mismatch across boundaries.
   - Silent fallback that hides user-visible breakage.
   - Config defaults that disagree with runtime expectations.
   - Missing validation around destructive or external actions.
   - Duplicated systems that can drift.

4. Rank findings.
   - Critical: data loss, security exposure, complete feature breakage.
   - High: silent wrong behavior, broken deploy/runtime path, serious drift.
   - Medium: maintainability or test gaps with real future cost.

5. Report with file evidence.
   - Start with findings ordered by severity.
   - Include file paths and line references when available.
   - Separate confirmed issues from hypotheses.
   - Add a phased repair plan only after findings.

## Verification

Run the lightest command that validates the audit claim. If a claim cannot be
verified locally, say what evidence is missing and why.

## Expected Output

- Findings first.
- Open questions or assumptions.
- Repair phases.
- Tests or commands run.
