---
name: building-dbt-semantic-layer
description: Use when creating or modifying dbt Semantic Layer components, including semantic models, metrics, dimensions, entities, measures, and time spines.
user-invocable: false
metadata:
  author: dbt-labs
---

# Build the dbt Semantic Layer

Use this skill for semantic models, entities, dimensions, metrics, and time spines.

## Choose the spec

Inspect project YAML first:

- A `semantic_model:` block nested under a model means the latest spec.
- A top-level `semantic_models:` key means the legacy spec.
- On dbt v2 Stable or dbt Core 1.12+, use the latest spec for new work.
- Preserve the existing spec unless the user asks to migrate it.

## Workflow

1. Read the model SQL and YAML.
2. Confirm the model grain and primary entity.
3. Identify foreign and unique entities used for joins.
4. Declare categorical and time dimensions.
5. Set an aggregation time dimension for time-based metrics.
6. Add metrics with clear labels and business definitions.
7. Run `dbt parse`, then `dbt sl validate`.

## Latest-spec example

```yaml
models:
  - name: fct_orders
    semantic_model:
      enabled: true
    agg_time_dimension: order_date
    columns:
      - name: order_id
        entity:
          type: primary
          name: order
      - name: customer_id
        entity:
          type: foreign
          name: customer
      - name: order_date
        granularity: day
        dimension:
          type: time
      - name: status
        dimension:
          type: categorical
    metrics:
      - name: total_revenue
        type: simple
        label: Total Revenue
        agg: sum
        expr: amount
```

## Metric guidance

- Simple: aggregate a column expression.
- Derived: combine existing metrics in an expression.
- Cumulative: calculate running or grain-to-date values; configure a time spine.
- Ratio: divide a numerator metric by a denominator metric.
- Conversion: measure one event leading to another for an entity in a time window.

Metric filters may reference declared entities and dimensions. Do not filter on undeclared raw columns.

## Guardrails

- Do not mix latest and legacy syntax.
- Every semantic model with time-based metrics needs a valid time dimension.
- Do not combine `window` and `grain_to_date` on one cumulative metric.
- Re-run `dbt parse` before semantic validation so the manifest is current.
- Preserve existing entities, dimensions, and metrics unless they are the explicit target of the change.
