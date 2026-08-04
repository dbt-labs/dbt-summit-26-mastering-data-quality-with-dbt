### Exercise 5 (Bonus): Linting

1. Create a new file called `.sqlfluff` at the root of the project 
   (alongside dbt_project.yml).

2. Copy and paste this SQLFluff configuration into the file, then save:
   ```
   [sqlfluff]
   dialect = snowflake
   templater = dbt
   runaway_limit = 10
   max_line_length = 80
   indent_unit = space
   exclude_rules = LT01, RF04, ST06

   [sqlfluff:indentation]
   tab_space_size = 4

   [sqlfluff:layout:type:comma]
   spacing_before = touch
   line_position = trailing
   ```

3. Set SQLFluff as your default linter:
   a. Open any model, then click on the Code Quality tab.
   b. Click the </> Config button.
   c. Select SQLFluff from the popup and hit save.
   d. Restart your IDE by refreshing your browser or clicking the 
      ellipses menu in the bottom right corner choosing "Restart Studio".
      This will allow your session to pick up your new configuration
      for linting.

4. Open the `models/staging/jaffle_world/stg_jaffle_world__customers.sql` 
   file and click the "Lint" button. What are the results?

5. Go back to your .sqlfluff file and change `line_position` to `leading`. 
   Save and try linting `stg_jaffle_world__customers.sql` again. 
   What are the results?

7. Click the drop-down arrow next to the "Lint" button, and click "Fix".

8. We've found this configuration in the SQLfluff docs which allows us to 
   require keywords to be capitalized. Add this to your .sqlfluff configuration
   and save:
   ```
   [sqlfluff:rules:capitalisation.keywords]
   capitalisation_policy = upper
   ```
   (Reference: https://docs.sqlfluff.com/en/stable/reference/rules.html#capitalisation-bundle)

9. Test linting and fixing again on the `stg_jaffle_world__customers` model.