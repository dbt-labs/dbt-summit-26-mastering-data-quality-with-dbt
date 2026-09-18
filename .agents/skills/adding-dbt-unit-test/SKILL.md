---
name: adding-dbt-unit-test
description: Creates unit test YAML definitions that mock upstream model inputs and validate expected outputs. Use when adding unit tests for a dbt model or practicing test-driven development in dbt.
user-invocable: false
metadata:
  author: dbt-labs
---

# Add unit tests for dbt models

Use dbt unit tests to validate SQL modeling logic against static inputs before materializing a model.

## When to use

Prioritize unit tests for complex `case` logic, regex, date math, window functions, non-trivial joins, regressions, edge cases, and critical public models. Avoid testing warehouse built-ins such as `min()` in isolation.

## Workflow

1. Read the target model and identify every `ref()` and `source()` dependency.
2. Define the unit test in a YAML file under `model-paths`.
3. Mock every dependency. Include only columns used by the scenario.
4. Use inline dictionary rows by default.
5. Define the smallest expected output that proves the behavior.
6. Run `dbt build --select <model>` so unit tests run before materialization.

```yaml
unit_tests:
  - name: test_order_status_mapping
    model: orders
    given:
      - input: ref('stg_orders')
        rows:
          - {order_id: 1, status_code: 10}
    expect:
      rows:
        - {order_id: 1, status: completed}
```

## Fixture formats

- `dict`: Default. Best for concise inline fixtures.
- `csv`: Use for an external fixture or convenient tabular data.
- `sql`: Required for ephemeral dependencies and useful for types unsupported by dict/csv. SQL fixtures must include every column.

Fixture files belong in `tests/fixtures/` or another configured `test-paths` directory.

## Special cases

- Incremental models: override `is_incremental` to test full-refresh and incremental branches separately. Expected rows describe records to insert or merge, not the final table state.
- Ephemeral dependencies: use `format: sql` for that mocked input.
- Versioned models: set the model version explicitly when the test should target one version.
- Introspective macros, vars, or environment values: define explicit overrides in the unit test.
- Alias tables used in joins inside model SQL.

## Constraints

Unit tests support SQL models in the current project. They do not support Python models, snapshots, seeds, sources as targets, materialized views, recursive SQL, or introspective queries.

## Common mistakes

- Missing a mocked `ref()` or `source()` dependency.
- Mocking every source column instead of the relevant subset.
- Using SQL fixtures where dict rows are sufficient.
- Testing basic warehouse functionality instead of project logic.
- Building the model without first exercising important edge cases.
