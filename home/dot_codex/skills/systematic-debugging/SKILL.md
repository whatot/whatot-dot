---
name: systematic-debugging
description: "用于排查错误、回归、失败命令、重复失败修复或不稳定问题；匹配排查问题、查原因、为什么失败；先拿证据再改动。"
---

# Systematic Debugging

Use this skill when the user reports a bug, failing command, broken runtime
behavior, or when a previous fix attempt did not work.

## Core Rule

Do not guess-fix. Establish the failure shape first, then make the smallest
root-cause fix that the evidence supports.

Spend disproportionate effort on the feedback loop. A fast deterministic
pass/fail signal is usually the shortest path to the cause.

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
   - For flaky issues, raise the reproduction rate with loops, stress, fixed
     seeds, pinned time, or narrower triggers before changing production code.

3. Compare against working patterns.
   - Search the repo for nearby implementations before inventing a new shape.
   - Check recent changes when available.
   - Trace data or control flow across the boundary where the symptom appears.

4. Form falsifiable hypotheses.
   - For simple failures, one strong hypothesis is enough.
   - For hard bugs, list 3-5 ranked hypotheses before testing the first one.
   - State each hypothesis in falsifiable terms.
   - Test one variable at a time.
   - If the hypothesis fails, update the model instead of stacking patches.

5. Instrument only where it distinguishes hypotheses.
   - Prefer debugger, REPL, targeted traces, profiler output, query plans, or
     boundary logs over broad logging.
   - Tag temporary logs with a unique prefix such as `[DEBUG-1234]` so cleanup
     is easy.
   - For performance regressions, measure a baseline before fixing.

6. Fix narrowly.
   - Change only the files needed for the confirmed cause.
   - Add or update focused tests when the behavior is important or likely to
     regress.
   - Run the smallest useful verification first, then broader checks if risk
     warrants it.
   - Re-run the original reproduction after the fix, not only the minimized
     test.

7. Clean up.
   - Remove temporary instrumentation, throwaway harnesses, and debug output.
   - Keep regression tests only when they exercise the real bug pattern through
     an honest seam.
   - If no honest seam exists, report that as an architecture follow-up.

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
