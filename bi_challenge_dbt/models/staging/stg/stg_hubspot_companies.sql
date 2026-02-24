{{ config(materialized='view') }}

select
    cast(company_id          as bigint)          as company_id,
    cast(company_name        as varchar)         as company_name,
    cast(domain              as varchar)         as domain,
    cast(industry            as varchar)         as industry,
    cast(country             as varchar)         as country,
    cast(number_of_employees as varchar)         as number_of_employees,
    cast(create_date         as timestamp)       as created_at
from {{ ref('raw_hubspot_companies') }}