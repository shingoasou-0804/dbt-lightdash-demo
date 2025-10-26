{{ config(materialized='table') }}
select
  sku,
  min(cost) as cogs_unit_cost
from {{ ref('stg_supplies') }}
group by sku
