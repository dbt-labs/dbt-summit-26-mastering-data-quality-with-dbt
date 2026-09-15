{% test assert_decimal(model, column_name) %}

    select iff(typeof({{ column_name }}) = 'DECIMAL', 'true', 'false')
    from {{ model }}

{% endtest %}