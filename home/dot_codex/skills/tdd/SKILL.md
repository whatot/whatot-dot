---
name: tdd
description: "用于按测试驱动开发实现功能或修复缺陷；匹配 TDD、测试先行、red-green-refactor、先写测试；强调一测一改和行为测试。"
---

# TDD

Use this skill when the user explicitly wants test-driven development or when a
high-risk behavior is best changed through a tight red-green-refactor loop.

## Core Rule

Work one behavior at a time: write one failing behavior test, make it pass with
the smallest useful change, then refactor only while green.

Tests should verify observable behavior through public interfaces. Avoid tests
that mainly lock private functions, internal call order, or temporary
implementation structure.

## Before Editing

Identify:

- Public interface or highest useful seam to test.
- First behavior that proves the path end to end.
- Existing test style, fixtures, helpers, and command entrypoints.
- Behaviors that are intentionally out of scope.

For non-trivial interface or scope choices, share the short plan before writing
tests.

## Loop

For each behavior:

1. RED: add one focused test that fails for the expected reason.
2. GREEN: implement only enough code to pass that test.
3. VERIFY: run the smallest relevant test command.
4. REFACTOR: improve names, locality, duplication, or module depth while tests
   stay green.
5. REPEAT: choose the next behavior using what the last slice revealed.

Prefer vertical slices that exercise the real path across layers. Do not write a
large batch of imagined tests before the first implementation slice exists.

## Test Quality

Good tests:

- Describe user, domain, or API behavior.
- Use public APIs, rendered UI, CLI output, HTTP behavior, or persisted effects
  that callers actually depend on.
- Fail when the behavior breaks and survive internal refactors.

Be cautious with mocks:

- Mock network, clock, filesystem, randomness, or expensive external services
  when isolation is necessary.
- Avoid mocking internal collaborators just to make a shallow unit test easy.

## Stop Rules

- If no honest test seam exists, report that as an architecture finding instead
  of forcing a misleading test.
- If the first test cannot be made deterministic, improve the feedback loop
  before continuing.
- If the implementation direction changes the intended interface, pause and
  confirm the new interface before adding more tests.

## Expected Output

Report:

- Behaviors covered.
- Test command and result.
- Implementation files changed.
- Refactors performed after green.
- Any important behavior intentionally left untested.
