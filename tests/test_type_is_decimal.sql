{% test type_is_decimal(model, column_name) %}

select
    {{ column_name }},
    typeof({{ column_name }}) as actual_type
from {{ model }}
where {{ column_name }} is not null
  and typeof({{ column_name }}) != 'DECIMAL'

{% endtest %}