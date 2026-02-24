{{ config(materialized='view') }}

with contacts as (
    select
        contact_id,
        company_id,
        first_name,
        last_name,
        email,
        job_title,
        lifecycle_stage,
        created_at as contact_created_at
    from {{ ref('stg_hubspot_contacts') }}
),

companies as (
    select
        company_id,
        company_name,
        domain,
        industry,
        country,
        created_at as company_created_at
    from {{ ref('stg_hubspot_companies') }}
)

select
    ct.contact_id,
    ct.company_id,
    ct.first_name,
    ct.last_name,
    ct.email,
    ct.job_title,
    ct.lifecycle_stage,
    ct.contact_created_at,
    c.company_name,
    c.domain,
    c.industry,
    c.country,
    c.company_created_at
from contacts ct
left join companies c
    on c.company_id = ct.company_id
    