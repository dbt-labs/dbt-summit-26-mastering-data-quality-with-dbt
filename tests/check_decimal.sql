SELECT *
FROM {{ ref('fct_orders') }}
WHERE
    -- Adjust this condition for your warehouse
    -- Example for Snowflake: TYPEOF returns 'FIXED' for DECIMAL/NUMBER
    TYPEOF(order_total) NOT LIKE 'DECIMAL%'