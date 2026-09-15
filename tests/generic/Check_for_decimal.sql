{% test Check_for_decimal(model_name,column_name)%}

SELECT *
FROM {{ model_name }}
WHERE
    -- Adjust this condition for your warehouse
    -- Example for Snowflake: TYPEOF returns 'FIXED' for DECIMAL/NUMBER
    TYPEOF({{column_name}}) NOT LIKE 'DECIMAL%'

{% endtest %}
