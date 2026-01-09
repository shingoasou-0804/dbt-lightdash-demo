{{ config(materialized='table', cluster_by=['ordered_at', 'customer_id']) }}
with
i as (select * from {{ ref('stg_items') }}),
o as (select * from {{ ref('stg_orders') }}),
p as (select * from {{ ref('stg_products') }}),
c as (select * from {{ ref('dim_supply_cost_per_sku') }})
select
  i.item_id,
  i.order_id,
  o.customer_id,
  o.ordered_at,
  o.store_id,
  i.sku,
  p.product_name,
  p.product_type,
  p.price,
  1 as quantity,
  p.price * 1 as amount,
  c.cogs_unit_cost,
  c.cogs_unit_cost * 1 as cogs_amount,
from i
join o on o.order_id = i.order_id
left join p on p.sku = i.sku
left join c on c.sku = i.sku
