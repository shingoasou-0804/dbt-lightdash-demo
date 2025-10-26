{{ config(materialized='view') }}
select
  id as store_id,
  name as store_name,
  cast(opened_at as timestamp) as opened_at,
  cast(tax_rate as float64) as tax_rate
from {{ source('jaffle_raw', 'jaffle_data_stores') }}
