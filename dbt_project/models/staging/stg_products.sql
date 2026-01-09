{{ config(materialized='view') }}
select
  sku,
  name as product_name,
  type as product_type,
  cast(price as numeric) as price,
  description
from {{ source('jaffle_raw', 'jaffle_data_products') }} 
