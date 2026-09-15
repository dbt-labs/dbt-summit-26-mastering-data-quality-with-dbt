### Exercise 4: Unit Tests
`models/staging/jaffle_world/stg_jaffle_world__customers.sql` has a column 
`is_valid_email` which uses regex to identify whether a customer’s email is 
valid or not. The data type returned is a `boolean`.

Starter YML is located at the bottom of this file. Use this to add a unit
test to `models/staging/jaffle_world/docs/_stg_jaffle_world__customers.yml`:

1. Copy/Paste the code to the last line of the file.
2. Finish filling out the `input` configuration (hint: take a look at 
   models/staging/jaffle_world/stg_jaffle_world__customers.sql to see what
   source that model is using in the SQL)
3. Using the description, fill out the `given` and `expect` row and column values.
4. Run `dbt build -s stg_jaffle_world__customers`. What are the results of the unit test?

```yml
unit_tests:
  - name: test_is_valid_email_address
    model: stg_jaffle_world__customers
    description: >
      Check that is_valid_email logic captures of our known edge cases:
      - emails that have a .com without domain, like nodomain@.comnodomain@.com
      - emails that have a truncated domain address, like truncated@domain.c
      - emails that have a missing dot in the domain, like missingdot@domaincom
      - emails with no @, like noat.com
      Additionally, we should check we're not marking emails which are valid 
      that contain special characters, such as:
      - c+berger@jaffle-shop.com
      - d.horner@jaffle.com
    given:
      - input: source('jaffle_world', 'customers') 
        rows:
          - {email: 'nodomain@.com'}
          - {email: 'nodomain@.comnodomain@.com'}
          - {email: 'truncated@domain.c' }
          - {email: 'missingdot@domaincom'}
          - {email: 'noat.com'}
          - {email: ''}
    expect:
      rows:
        - {email: , is_valid_email: }
        - {email: , is_valid_email: }
        - {email: , is_valid_email: }
        - {email: , is_valid_email: }
        - {email: , is_valid_email: }
        - {email: , is_valid_email: }
```

models:
  - name: stg_jaffle_world__customers
    description: >
      This model serves as a staging layer for customer data 
      from the 'jaffle_world' source. It standardizes and 
      renames fields for consistency and ease of use in 
      downstream models.
    columns:
      - name: customer_id
        description: A unique identifier for each customer.
        data_tests:
          - unique 
          - not_null
          
      - name: address_id
        description: >
          The identifier for the address associated with the customer.

      - name: first_name
        description: The first name of the customer.

      - name: last_name
        description: The last name of the customer.

      - name: email
        description: The email address of the customer.

      - name: phone
        description: The phone number of the customer.

      - name: created_at
        description: The timestamp when the customer record was created.

      - name: updated_at
        description: The timestamp when the customer record was last updated.