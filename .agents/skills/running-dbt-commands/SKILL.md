---
name: running-dbt-commands
description: Formats and executes dbt CLI commands and selects appropriate commands, selectors, and flags.
user-invocable: false
metadata:
  author: dbt-labs
---

# Run dbt commands

## Defaults

1. Use the available dbt command tool instead of a shell.
2. Prefer `dbt build` for development because it materializes selected resources and runs their tests.
3. Always provide `--select`; never run the entire project without explicit approval.
4. Use modern `--select` or `-s`, never deprecated model flags.
5. Use `--quiet` with `--warn-error-options '{"error": ["NoNodesForSelectionCriteria"]}'` for routine targeted builds.

```bash
dbt build --select my_model --quiet --warn-error-options '{"error": ["NoNodesForSelectionCriteria"]}'
```

## Selectors

- `model`: selected node only.
- `model+`: node and downstream descendants.
- `+model`: node and upstream ancestors.
- `+model+`: ancestors, node, and descendants.
- `model+2`: node and two downstream levels.
- Space between selectors is a union; comma is an intersection.

Use `dbt list --select <selector>` to preview complex selections.

## Common commands

```bash
dbt build --select my_model
dbt compile --select my_model
dbt show --select my_model --limit 10
dbt show --inline "select * from {{ ref('orders') }}" --limit 5
dbt build --select my_model --full-refresh
dbt build --select my_model --vars '{"key": "value"}'
```

Use the `--limit` flag with `dbt show`; do not put `LIMIT` in inline SQL because dbt appends one.

## Deferral

```bash
dbt build --select my_model --defer --state prod-artifacts
dbt build --select my_model --defer --state prod-artifacts --favor-state
```

Use `--favor-state` when a production-consistent query must avoid mixing local dev relations with deferred production relations.

## Validation choice

- SQL model or macro change: `dbt build --select +<model>+`.
- Jinja-only iteration: targeted `dbt compile` followed by a final build.
- YAML/config structure: `dbt parse`, then build if tests, contracts, refs, or sources changed.
- Description-only docs: no dbt command required.
