### [ANSWER KEY] Exercise 3: Model Contracts

1. The contract on `models/marts/docs/_dim_customers.yml` needs to be enabled and marked as enforced

2. The initial build should be successful with the contract

3. At least one of the columns needs to be fully commented out or removed from the yml file.

4. The build should now fail.

5. Make sure previously commented code is uncommented before moving on to the next step.

6. Make sure the preview now returns "valid"/"invalid" instead of true/false

7. Your build should fail due to a data type mismatch

8. Make sure you replace line 15-18 in `models/staging/jaffle_world/stg_jaffle_world__customers.sql` with:

    '''
        regexp_like(
            email, 
            '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'
        ) as is_valid_email,
    '''

