-- test/generic/test_type

{% test test_type(model, column_name, data_type)  %}

select 
    {{ column_name }}
from 
    {{ model }}
where
    upper(typeof({{ column_name }})) != upper('{{ data_type }}')

{% endtest %}