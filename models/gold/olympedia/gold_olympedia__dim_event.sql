{{ config(materialized='table') }}

with silver as (
    select * from {{ ref('silver_olympedia__event') }}
)

select 
    row_number() over (partition by EventId) + EventId AS SKEvent,
    *
from silver