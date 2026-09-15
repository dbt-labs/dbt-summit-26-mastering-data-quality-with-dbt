{% test is_type_of_decimal(model, column_name) %}
SELECT 
    *
FROM {{model}} AS fo
WHERE TYPEOF({{column_name}}) != 'DECIMAL'
{% endtest %}
