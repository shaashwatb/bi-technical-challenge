{{ config(materialized='view') }}

select
    cast(event_id         as varchar)             as event_id,
    cast(event_name       as varchar)             as event_name,
    cast(event_timestamp  as timestamp)           as event_ts,
    cast(user_id          as varchar)             as user_id,
    cast(organization_id  as varchar)             as organization_id,
    cast(event_properties as json)                as event_properties
from {{ ref('raw_backend_events') }}