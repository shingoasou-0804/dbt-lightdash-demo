{{ config(materialized='table') }}
with o as (
  select
    customer_id,
    min(ordered_at) as first_order_at,
    max(ordered_at) as last_order_at,
    count(distinct order_id) as orders_count,
    sum(order_total) as total_revenue
  from {{ ref('fct_orders') }}
  group by customer_id
)
select
  c.customer_id,
  c.customer_name,
  o.first_order_at,
  o.last_order_at,
  o.orders_count,
  o.total_revenue
from {{ ref('stg_customers') }} c
left join o on o.customer_id = c.customer_id
