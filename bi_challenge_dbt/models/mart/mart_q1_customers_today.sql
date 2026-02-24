{{ config(materialized='table') }}

with customers as (
    select distinct
        company_id
    from {{ ref('int_hubspot_deals') }}
    where is_closed_won = true
      and company_id is not null
)

select
    count(*) as customers_today
from customers