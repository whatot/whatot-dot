---
name: disk-cleaner
description: Use when investigating disk usage, caches, build outputs, dependency folders, downloads, or Chinese requests like 磁盘清理, 空间占用, 缓存太大.
---

# Disk Cleaner

Use this skill to diagnose disk usage and propose safe cleanup. The default mode
is read-only scanning. Deletion requires explicit user approval.

## Safety Rules

- Never delete first. Scan, summarize, ask, then delete only approved targets.
- Use absolute paths in any cleanup command.
- Do not delete secrets, source repositories, `.git`, user documents, photos, or
  app data that cannot be regenerated.
- Treat caches and build outputs as safer than project source.
- Prefer precise subdirectories over broad parent directories.
- If a path is outside the current repo or outside known cache/build locations,
  explain the risk before proposing deletion.

## Scan Strategy

Start with the user's requested path. If no path is given, inspect the current
working directory and a bounded view of the home directory.

Useful read-only checks:

```bash
rtk df -h /
rtk du -d1 -h "$HOME" 2>/dev/null | sort -rh | head -30
rtk du -d1 -h "$HOME/Library/Caches" 2>/dev/null | sort -rh | head -20
rtk du -sh "$HOME"/.[!.]* 2>/dev/null | sort -rh | head -20
```

For project trees, look for common large regenerated directories:

- Rust: `target`
- Node: `node_modules`, `.next`, `.turbo`
- Python: `.venv`, `.pytest_cache`, `.ruff_cache`, `__pycache__`
- Package caches: pnpm, npm, uv, pip, Gradle, Playwright
- Container data: Docker or OrbStack, only through their own tooling

## Report Shape

Return a concise table:

```text
Path | Size | Category | Safe to delete? | Recovery
```

Group results as:

- Safe regenerated data.
- Needs user judgment.
- Do not delete.

## Cleanup

Before deleting, ask for the exact numbered items to remove. Then run precise
commands only for approved absolute paths and verify free space afterward with
`rtk df -h /`.
