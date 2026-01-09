{{ config(materialized='view') }}
select
  id as order_id,
  customer as customer_id,
  ordered_at,
  store_id,
  cast(subtotal as numeric) as subtotal,
  cast(tax_paid as numeric) as tax_paid,
  cast(order_total as numeric) as order_total
from {{ source('jaffle_raw', 'jaffle_data_orders') }}
