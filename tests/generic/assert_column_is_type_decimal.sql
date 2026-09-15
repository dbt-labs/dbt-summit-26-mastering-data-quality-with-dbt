{% test is_decimal(model, column_name) %}

select *
from {{ model }}
where typeof({{ column_name }}) != 'DECIMAL'

{% endtest %}