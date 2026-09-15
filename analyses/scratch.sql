SELECT 
    *
FROM {{ref('fct_orders')}} AS fo
WHERE TYPEOF(fo.order_total) != 'DECIMAL'