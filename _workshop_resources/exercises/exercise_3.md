### Exercise 3: Model Contracts

1. Open `models/marts/docs/_dim_customers.yml` and examine the data contract
   Note that contract Enforced is set to 'true' and each column is associated with a data type

2. excute the command 'dbt build --select dim_customers' to confirm the model currently builds successfully

3. In `models/marts/docs/_dim_customers.yml`, try commenting out one of the column definitions like in the code shown below and save:

    ```yml
      #  - name: is_valid_email
      #    description: Boolean value showing whether an email is valid or not 
      #    data_type: boolean
    ```
4. excute the command 'dbt build --select dim_customers' and note the failure calling out the missing column definition

5. Uncomment the column definition in `models/marts/docs/_dim_customers.yml`

6. Replace the code on lines 15-18 in `models/staging/jaffle_world/stg_jaffle_world__customers.sql` with the below code:

    ```sql
    ,iff(regexp_like(
        email, 
        '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'
    ) = true,'Valid', 'Invalid') as is_valid_email
    ```

7. Execute 'dbt build --select +dim_customers' to run dim_customers and all upstream models (including the one we just changed)
   Note the error showing that we are attempting to use a text field instead of the defined boolean field

8. Revert your code change in 'models/staging/jaffle_world/stg_jaffle_world__customers.sql' so that your code can build succesfully again
