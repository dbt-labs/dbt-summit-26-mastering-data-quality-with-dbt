SELECT 

   TYPEOF(fo.order_total)
FROM {{ref('fct_orders')}} AS fo
