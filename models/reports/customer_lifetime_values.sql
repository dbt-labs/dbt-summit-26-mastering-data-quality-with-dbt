with

orders as (
    select * from {{ ref('fct_orders') }}
),

customers as (
    select * from {{ ref('dim_customers') }}
),

agg_customer_orders as (
    select
        customer_id,
        --order_id,
        count(order_id) as total_orders,
        count(order_id) > 1 as is_repeat_customer,
        min(ordered_at) as earliest_order_at,
        max(ordered_at) as latest_order_at,
        round(sum(order_subtotal), 2) as total_gross_spend,
        round(sum(order_total), 2) as total_net_spend,
        round(sum(tax), 2) as total_tax_paid
    from orders
    group by 1
),

final as (
    select
        customers.customer_id,
        customers.full_name as customer_name,
        customers.email as customer_email,

        case
            when agg_customer_orders.is_repeat_customer 
            then 'returning'
            else 'new'
        end as customer_type,

        coalesce(
            agg_customer_orders.total_orders,
            0
        ) as total_orders,

        coalesce(
            agg_customer_orders.total_gross_spend,
            0
        ) as total_gross_spend,

        coalesce(
            agg_customer_orders.total_net_spend,
            0
        ) as total_net_spend,

        coalesce(
            agg_customer_orders.total_tax_paid,
            0
        ) as total_tax_paid,
        
        agg_customer_orders.earliest_order_at,
        agg_customer_orders.latest_order_at
    from customers
    left join agg_customer_orders
        on customers.customer_id = agg_customer_orders.customer_id
)

select * from final