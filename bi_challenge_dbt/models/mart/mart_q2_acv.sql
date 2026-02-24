{{ config(materialized='table') }}

select
    avg(amount) as acv
from {{ ref('int_hubspot_deals') }}
where is_closed_won = true
  and amount is not null