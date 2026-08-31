### [ANSWER KEY] Exercise 1: Data Tests

1. Lines 8-12 of `models/reports/docs/_customer_lifetime_values.yml` 
   should look like:
   ```
   - name: customer_id
     description: A unique identifier for each customer.
     data_tests:
       - unique
       - not_null 
   ```

2. The results of the run should have lines for the `unique` and `not_null` 
   tests. The not null test should have passed and been successful. The unique test should have failed (errored).

3. Lines 12-23 of `models/reports/customer_lifetime_values.sql` should look like:
   ```
    select
        customer_id,
        order_id,
        count(order_id) as total_orders,
        count(order_id) > 1 as is_repeat_customer,
        min(ordered_at) as earliest_order_at,
        max(ordered_at) as latest_order_at,
        round(sum(order_subtotal), 2) as total_gross_spend,
        round(sum(order_total), 2) as total_net_spend,
        round(sum(tax), 2) as total_tax_paid
    from orders
    group by 1, 2
   ```
   The inclusion of `order_id` in this CTE is making `customer_id` not unique.