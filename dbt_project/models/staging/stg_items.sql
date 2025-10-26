{{ config(materialized='view') }}
select
  id as item_id,
  order_id,
  sku,
from {{ source('jaffle_raw', 'jaffle_data_items') }}
