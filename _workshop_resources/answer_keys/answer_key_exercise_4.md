### [ANSWER KEY] Exercise 4: Unit Tests

The `unit_test` key should start on lines 36 or 37 of 
`models/staging/jaffle_world/docs/_stg_jaffle_world__customers.yml`.

Here is the completed unit test configuration, which results in a successful 
test status when running `dbt build -s stg_jaffle_world__customers`:
```
unit_tests:
  - name: test_is_valid_email_address
    model: stg_jaffle_world__customers
    description: >
      Check that is_valid_email logic captures of our known edge cases:
      - emails that have a .com without domain like nodomain@.com
      - emails that have a domain, but truncated like truncated@domain.c
      - emails that have a missing dot in the domain, like missingdot@domaincom
      - emails with no @, like noat.com
      Additionally, we should check that we're not marking emails
      with valid special characters as invalid, such as:
      - c+berger@jaffle-shop.com
      - d.horner@jaffle.com
    given:
      - input: source('jaffle_world', 'customers')
        rows:
          - {email: nodomain@.com}
          - {email: truncated@domain.c}
          - {email: noat.com}
          - {email: email@missingdotcom}
          - {email: c+berger@jaffle-shop.com}
          - {email: d.horner@jaffle.com}
    expect:
      rows:
        - {email: nodomain@.com, is_valid_email: false}
        - {email: truncated@domain.c, is_valid_email: false}
        - {email: noat.com, is_valid_email: false}
        - {email: email@missingdotcom, is_valid_email: false}
        - {email: c+berger@jaffle-shop.com, is_valid_email: true}
        - {email: d.horner@jaffle.com, is_valid_email: true}
```