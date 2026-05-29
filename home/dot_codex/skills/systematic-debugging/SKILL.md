---
name: systematic-debugging
description: Use when debugging errors, regressions, flaky commands, repeated failed fixes, or Chinese requests like 排查问题, 查原因, 为什么失败. Focuses on evidence before changes.
---

# Systematic Debugging

Use this skill when the user reports a bug, failing command, broken runtime
behavior, or when a previous fix attempt did not work.

## Core Rule

Do not guess-fix. Establish the failure shape first, then make the smallest
root-cause fix that the evidence supports.

## Workflow

1. Capture the exact failure.
   - Read the full error output, log line, stack trace, or visible symptom.
   - Preserve concrete paths, command names, timestamps, status codes, and input
     values.
   - If runtime behavior conflicts with config, trust the runtime until proven
     otherwise.

2. Reproduce or bound the issue.
   - Run the smallest relevant command or inspect the smallest relevant log.
   - If reproduction is expensive or risky, explain the boundary and use
     read-only evidence first.
   - Note whether the problem is deterministic, environment-specific, or flaky.

3. Compare against working patterns.
   - Search the repo for nearby implementations before inventing a new shape.
   - Check recent changes when available.
   - Trace data or control flow across the boundary where the symptom appears.

4. Form one specific hypothesis.
   - State the likely cause in falsifiable terms.
   - Test one variable at a time.
   - If the hypothesis fails, update the model instead of stacking patches.

5. Fix narrowly.
   - Change only the files needed for the confirmed cause.
   - Add or update focused tests when the behavior is important or likely to
     regress.
   - Run the smallest useful verification first, then broader checks if risk
     warrants it.

## Stop Rule

After three failed fix attempts, stop changing code and reassess the model.
Report what was tried, what evidence contradicted it, and what new diagnostic
step is needed.

## Expected Output

When handing off, include:

- Root cause, or the strongest remaining hypothesis if not fully confirmed.
- Files or runtime sources inspected.
- Fix applied.
- Verification run and result.
- Any residual risk.
