### Exercise 3: Model Contracts

1. Open file `models/marts/docs/_fct_orders.yml` and enforce a contract. 
Note that the data types have already been added for you.

2. Run `dbt build -s fct_orders`. 
what's the result?

3. In `models/marts/docs/_fct_orders.yml` for column `order_total` change `data_type: decimal(16,2)` to `data_type: decimal`. 
Re-run `dbt build -s fct_orders`. 
What happens? 

4. In `models/marts/docs/_fct_orders.yml` for column `order_total` change `data_type: decimal` to `data_type: varchar`. 
Re-run `dbt build -s fct_orders`. 
What happens? 

5. In the yml change the data_type back to `decimal(16,2)` and re-run `dbt build -s fct_orders`.