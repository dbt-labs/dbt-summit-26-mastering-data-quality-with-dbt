{% test type_decimal(model, column_name) %}

with validation as (

    select
        {{ column_name }} as column_name

    from {{ model }}

)

select *
from validation
where typeof(column_name) <> 'DECIMAL'

{% endtest %}