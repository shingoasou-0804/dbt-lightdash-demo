{{ config(materialized='table') }}
select
  oi.order_id,
  any_value(oi.customer_id) as customer_id,
  any_value(oi.ordered_at) as ordered_at,
  any_value(oi.store_id) as store_id,
  count(*) as item_count,
  sum(oi.amount) as items_amount,
  sum(oi.cogs_amount) as cogs_amount,
  any_value(o.subtotal) as subtotal,
  any_value(o.tax_paid) as tax_paid,
  any_value(o.order_total) as order_total
from {{ ref('fct_order_items') }} oi
join {{ ref('stg_orders') }} o using(order_id)
group by order_id
