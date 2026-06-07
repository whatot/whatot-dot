---
name: prototype
description: "用于在正式实现前创建可丢弃原型，验证状态机、数据模型、交互或 UI 方向；匹配原型、prototype、试几个方案、让我玩一下。"
---

# Prototype

Use this skill when the user wants to learn from a small runnable experiment
before committing production code.

## Core Rule

A prototype answers one concrete question. Keep it close to the real code path,
clearly marked as throwaway, and delete or absorb it when the question is
answered.

## Pick The Shape

Choose the prototype shape from the question:

- Logic or state model: build a tiny runnable harness, CLI, test fixture, or
  local script that drives the important transitions.
- UI or interaction: build a small route, page, or component variant using the
  repo's existing frontend stack and routing conventions.
- Data model or API contract: use realistic fixtures and show how the state or
  payload changes after each operation.

If the question is ambiguous, infer from the surrounding repo area and state the
assumption before editing.

## Workflow

1. Write down the question the prototype is meant to answer.
2. Find the nearest existing module, route, or command that gives realistic
   context.
3. Create the smallest runnable artifact with one obvious command or URL.
4. Keep state visible after each action so the user can inspect behavior.
5. Avoid persistence, broad error handling, abstractions, and production polish
   unless the question specifically depends on them.
6. After the user or verification resolves the question, either remove the
   prototype or fold the learned decision into production code, docs, an issue,
   or an ADR.

## Boundaries

- Do not leave prototype code looking like production code.
- Do not let a prototype expand into the real implementation without an explicit
  checkpoint.
- Do not add durable dependencies for a throwaway question unless the user
  confirms the tradeoff.
- Do not skip the repo's existing design conventions for UI prototypes.

## Expected Output

Report:

- The question answered.
- How to run or view the prototype.
- What was learned.
- Whether the prototype was deleted, retained temporarily, or absorbed.
