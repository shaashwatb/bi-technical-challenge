select
    cast(deal_id  as bigint)                               as deal_id,
    nullif(trim(cast(deal_name as varchar)), '')          as deal_name,
    nullif(trim(cast(pipeline as varchar)), '')           as pipeline,
    cast(is_closed as boolean)                            as is_closed,
    cast(is_closed_won as boolean)                        as is_closed_won,
    cast(amount as double)                            as amount,
    cast(close_date as timestamp)                     as close_date,
    cast(create_date as timestamp)                    as created_at,
    cast(hubspot_company_id as bigint)                    as company_id,
    nullif(lower(trim(cast(deal_type as varchar))), '')   as deal_type,
    nullif(trim(cast(currency as varchar)), '')           as currency,

    cast(date_entered_pre_pitch as timestamp)         as entered_pre_pitch_at,
    cast(date_entered_pitching as timestamp)          as entered_pitching_at,
    cast(date_entered_product_testing as timestamp)   as entered_product_testing_at,
    cast(date_entered_price_offering as timestamp)    as entered_price_offering_at,
    cast(date_entered_contract_negotiation as timestamp) as entered_contract_negotiation_at,
    cast(date_entered_closed_won as timestamp)        as entered_closed_won_at,
    cast(date_entered_closed_lost as timestamp)       as entered_closed_lost_at
from {{ ref('raw_hubspot_deals')}}