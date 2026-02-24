{{ config(materialized='view') }}

with deals as (
    select
        deal_id,
        company_id,
        deal_name,
        pipeline,
        deal_type,
        currency,
        is_closed,
        is_closed_won,
        amount,
        created_at as deal_created_at,
        close_date,

        entered_pre_pitch_at,
        entered_pitching_at,
        entered_product_testing_at,
        entered_price_offering_at,
        entered_contract_negotiation_at,
        entered_closed_won_at,
        entered_closed_lost_at
    from {{ ref('stg_hubspot_deals') }}
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
    d.deal_id,
    d.company_id,

    d.deal_name,
    d.pipeline,
    d.deal_type,
    d.currency,
    d.is_closed,
    d.is_closed_won,
    d.amount,
    d.deal_created_at,
    d.close_date,

    d.entered_pre_pitch_at,
    d.entered_pitching_at,
    d.entered_product_testing_at,
    d.entered_price_offering_at,
    d.entered_contract_negotiation_at,
    d.entered_closed_won_at,
    d.entered_closed_lost_at,

    c.company_name,
    c.domain,
    c.industry,
    c.country,
    c.company_created_at
from deals d
left join companies c
    on c.company_id = d.company_id
    