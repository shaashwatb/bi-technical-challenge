{{ config(materialized='view') }}

select
    cast(contact_id         as bigint)           as contact_id,
    cast(first_name         as varchar)          as first_name,
    cast(last_name          as varchar)          as last_name,
    cast(email              as varchar)          as email,
    cast(job_title          as varchar)          as job_title,
    cast(hubspot_company_id as bigint)           as company_id,
    cast(lifecycle_stage    as varchar)          as lifecycle_stage,
    cast(create_date        as timestamp)        as created_at
from {{ ref('raw_hubspot_contacts') }}