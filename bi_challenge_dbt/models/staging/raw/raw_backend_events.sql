{{ config(materialized='view') }}

select *
from read_csv_auto('../data/backend_events.csv')