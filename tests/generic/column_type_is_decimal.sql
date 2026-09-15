{% test column_type_is_decimal(model, column_name)%}
    SELECT *
    FROM {{ model }}
    WHERE TYPEOF({{ column_name }}) != 'DECIMAL'
{% endtest %}