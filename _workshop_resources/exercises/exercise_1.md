### Exercise 1: Data Tests

1. Open `models/reports/docs/_customer_lifetime_values.yml`. 
   Add a data test which tests the customer_id to ensure it’s 
   unique and contains no NULL values.

2. Test the model by running `dbt build -s customer_lifetime_values`. 
   What is the result?

3. Take a look at `models/reports/customer_lifetime_values.sql` to try and identify the issue
   *TIP*: Something in the agg_customer_orders CTE is causing duplicate customer_id records
