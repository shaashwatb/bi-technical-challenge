{{ config(materialized='table') }}

with events as (
    select
        user_id,
        event_name
    from {{ ref('stg_backend_events') }}
    where user_id is not null
),

user_flags as (
    select
        user_id,
        max(case when event_name in ('SearchCreated', 'SearchUpdated') then 1 else 0 end) as did_create_search,
        max(case when event_name = 'SearchExecuted' then 1 else 0 end) as did_execute_search,
        max(case when event_name = 'SearchResultAppraised' then 1 else 0 end) as did_appraise_result,
        max(case when event_name = 'SearchResultFullTextAppraised' then 1 else 0 end) as did_view_full_text,
        max(case when event_name = 'SearchExported' then 1 else 0 end) as did_export
    from events
    group by user_id
),

totals as (
    select count(distinct user_id) as total_users
    from user_flags
)

select
    step,
    users_reached,
    users_reached * 1.0 / t.total_users as pct_of_users
from (
    select 'Search Created / Updated' as step, sum(did_create_search) as users_reached from user_flags
    union all
    select 'Search Executed', sum(did_execute_search) from user_flags
    union all
    select 'Result Appraised', sum(did_appraise_result) from user_flags
    union all
    select 'Full Text Viewed', sum(did_view_full_text) from user_flags
    union all
    select 'Exported Results', sum(did_export) from user_flags
) f
cross join totals t
order by users_reached desc
