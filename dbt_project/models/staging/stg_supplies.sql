{{ config(materialized='view') }}
select
  id as supply_id,
  name as supply_name,
  cast(cost as numeric) as cost,
  perishable,
  sku
from {{ source('jaffle_raw', 'jaffle_data_supplies') }}
