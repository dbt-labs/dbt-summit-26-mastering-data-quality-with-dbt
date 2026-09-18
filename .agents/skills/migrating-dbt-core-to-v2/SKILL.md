---
name: migrating-dbt-core-to-v2
description: Triages dbt Core to dbt v2 Stable migration errors using dbt-autofix first, then classifies remaining issues into actionable categories.
compatibility: dbt v2 Stable
metadata:
  author: dbt-labs
---

# Migrate dbt Core projects to dbt v2 Stable

Migration is iterative. Success means safely fixing project-owned issues and clearly identifying engine blockers.

## Mandatory order

1. Ask whether to run `dbt debug` to validate credentials and connectivity.
2. Run or confirm `dbt-autofix`, then review every change it made.
3. Reproduce remaining issues with `dbt compile --no-partial-parse` or the user's specified repro command.
4. Classify issues before applying manual fixes.
5. Validate each fix by rerunning the repro command.

Do not inspect or edit project files before the initial debug decision and autofix review are complete.

## Autofix

Use the available `dbt-autofix` command with `--json`. It is appropriate for deprecations, package upgrades, and legacy Semantic Layer migration. Review the git diff and structured output to identify moved config keys, YAML changes, Jinja rewrites, and package updates. Autofix can introduce mistakes; understand the diff before proceeding.

After autofix, run:

```bash
dbt build --no-partial-parse
```

A build catches both remaining warnings and behavioral regressions.

## Classification

### A: Safe automatic fixes

High-confidence changes such as quote nesting and disabling static analysis for optional analysis files that the v2 parser cannot analyze.

### B: Guided project fixes

Changes requiring a reviewed diff: deprecated config APIs, YAML syntax, source mismatches, custom config keys that must move under `meta`, duplicate docs, seed formatting, deprecated CLI flags, and SQL rewrites.

### C: Needs user input

Cases with multiple valid ownership or design choices, such as whether a hardcoded relation should become a model, source, or external dependency.

### D: Blocked on v2 Stable

Engine crashes, parser or MiniJinja gaps, missing adapter methods, and known engine bugs. Document the blocker, provide the known issue when available, and explain workaround risks before requesting a decision.

## v2 Stable syntax reminders

- Use `--select` or `-s`; deprecated model flags are unsupported.
- Custom top-level YAML keys must move under `config.meta`.
- YAML anchors must be declared under a top-level `anchors:` key.
- `flags:` in `dbt_project.yml` is unsupported because behavior-change flags are permanently enabled.
- Use the latest Semantic Layer spec for new work.
- Ignore lingering `dbt1065` package compatibility warnings after autofix; do not manually churn package versions solely for those warnings.

## Reporting

Summarize autofix changes, list remaining issues by category, recommend the next fix, and track resolved, pending-input, and blocked counts. Never hide blockers or apply fragile workarounds without an explicit user decision.
