{{ config(materialized='view') }}
select
  id as customer_id,
  name as customer_name
from {{ source('jaffle_raw', 'jaffle_data_customers') }}
