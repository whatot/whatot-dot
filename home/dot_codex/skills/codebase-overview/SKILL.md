---
name: codebase-overview
description: "Use when building an overall understanding of a repository: features, architecture, runtime flow, important modules, strengths, limits, and Chinese requests like 分析项目, 了解项目, 整体了解, 全貌分析."
---

# Codebase Overview

Use this skill when the user wants to understand a project rather than primarily
find defects. The goal is a useful map: what the project does, how it is built,
how it runs, where the important code lives, and what tradeoffs or gaps matter.

## Core Rule

Explain the project before judging it. Cover function, architecture, workflows,
and limitations. Mention risks only as one part of the picture, not as the main
shape of the answer.

## Workflow

1. Inventory the repo.
   - Start with `rg --files` for file discovery and targeted `rg -n` searches.
   - Avoid `find` unless `rg` is unavailable or a filesystem predicate is
     genuinely needed.
   - Check `README`, package manifests, build config, docs, tests, deployment
     files, and top-level source directories.

2. Identify the project shape.
   - Language, framework, package manager, generated code, and test entrypoints.
   - Runtime boundaries: binaries, services, CLIs, controllers, jobs, workers,
     UI apps, deployment charts, or infrastructure definitions.
   - External dependencies and integration points.

3. Trace the main flows.
   - Startup or bootstrap path.
   - Core request, reconcile, render, build, or command flow.
   - Data/config flow and ownership boundaries.
   - Extension points and feature flags.

4. Summarize with balance.
   - What it does.
   - How it is organized.
   - Important modules and why they matter.
   - Strengths and mature parts.
   - Limitations, complexity hotspots, and areas worth deeper review.
   - Include a compact ASCII diagram when the project has a meaningful runtime,
     module, or data flow. Keep it small enough to paste into Markdown.

5. Verify lightly.
   - Run only cheap, relevant commands such as `git status`, targeted tests, or
     build/list commands when they do not require broad downloads.
   - If validation cannot run locally, state the blocker without turning the
     overview into a failure report.

## Expected Output

- Overall judgment.
- Functional map.
- Compact ASCII architecture or flow diagram when useful.
- Architecture and runtime flow.
- Key directories or modules.
- Strengths.
- Limitations and deeper-review targets.
- Commands checked.
