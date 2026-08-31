### [ANSWER KEY] Exercise 3: Model Contracts

1. Lines 2-9 of `models/marts/docs/_fct_orders.yml` should look like:
   ```
  - name: fct_orders
    description: >
      This model filters and selects completed orders from the internal orders
      table, providing a comprehensive view of finalized transactions. It is useful
      for analyzing sales performance and customer purchasing behavior.
    config:
      contract: 
        enforced: true
   ```

2. Model should build successfully and the generic test created from the last exercise should pass.

3. Lines 41-44 should look like this:
```
      - name: order_total
        description: The total amount for the order including taxes.
        data_type: decimal
 ```       
*Result:*
`fct_orders` should build with a warning `Detected columns with numeric type and unspecified precision/scale, this can lead to unintended rounding: ['order_total']`. 
Data test from Exercise 2 should fail. (Now the data type in Snowflake is 'INTEGER')

4. Lines 41-44 should look like this:
```
      - name: order_total
        description: The total amount for the order including taxes.
        data_type: varchar
```

*Result:*
`fct_orders` should fail during build, and the data test is skipped. The logs for the model `fct_orders` will show this table which caused the error:

                        | column_name | definition_type | contract_type |    mismatch_reason |
                        | ----------- | --------------- | ------------- | ------------------ |
                        | ORDER_TOTAL | NUMBER          | VARCHAR       | data type mismatch |

5. Lines 41-44 should look like this:
```
      - name: order_total
        description: The total amount for the order including taxes.
        data_type: decimal(16,2)
```
The build should now be successful with both model and test passing.