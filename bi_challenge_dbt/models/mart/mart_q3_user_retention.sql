{{ config(materialized='table') }}

with events as (
    select
        user_id,
        date(event_ts) as event_date
    from {{ ref('stg_backend_events') }}
    where user_id is not null
      and event_ts is not null
),

cohorts as (
    select
        user_id,
        min(event_date) as cohort_date
    from events
    group by user_id
),

activity as (
    select distinct
        e.user_id,
        c.cohort_date,
        e.event_date,
        datediff('day', c.cohort_date, e.event_date) as days_since_cohort
    from events e
    join cohorts c using (user_id)
),

retention as (
    select
        cohort_date,
        count(distinct user_id) as cohort_size,
        count(distinct case when days_since_cohort = 7  then user_id end) as retained_d7,
        count(distinct case when days_since_cohort = 30 then user_id end) as retained_d30
    from activity
    group by cohort_date
)

select
    cohort_date,
    cohort_size,
    retained_d7,
    retained_d30,
    retained_d7 * 1.0 / nullif(cohort_size, 0)  as retention_d7,
    retained_d30 * 1.0 / nullif(cohort_size, 0) as retention_d30
from retention
order by cohort_date