{{ config(materialized='view') }}

select *
from read_csv_auto('../data/hubspot_contacts.csv')