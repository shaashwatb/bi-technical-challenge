{{ config(materialized='table') }}

with deals as (
    select
        deal_id,

        entered_pre_pitch_at,
        entered_pitching_at,
        entered_product_testing_at,
        entered_price_offering_at,
        entered_contract_negotiation_at,
        entered_closed_won_at,
        entered_closed_lost_at
    from {{ ref('int_hubspot_deals') }}
),

funnel as (
    select 'Pre-Pitch' as stage, 1 as step_order,
           count(distinct deal_id) filter (where entered_pre_pitch_at is not null) as deals_reached
    from deals

    union all
    select 'Pitching', 2,
           count(distinct deal_id) filter (where entered_pitching_at is not null)
    from deals

    union all
    select 'Product Testing', 3,
           count(distinct deal_id) filter (where entered_product_testing_at is not null)
    from deals

    union all
    select 'Price Offering', 4,
           count(distinct deal_id) filter (where entered_price_offering_at is not null)
    from deals

    union all
    select 'Contract Negotiation', 5,
           count(distinct deal_id) filter (where entered_contract_negotiation_at is not null)
    from deals

    union all
    select 'Closed Won', 6,
           count(distinct deal_id) filter (where entered_closed_won_at is not null)
    from deals
)

select
    stage,
    step_order,
    deals_reached,
    lag(deals_reached) over (order by step_order) as previous_stage_deals,
    1 - (deals_reached * 1.0 / nullif(lag(deals_reached) over (order by step_order), 0))
        as dropoff_rate
from funnel
order by step_order
