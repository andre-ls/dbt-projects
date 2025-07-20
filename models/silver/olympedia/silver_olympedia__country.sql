{{ config(materialized='table') }}

with bronze as (
    select * from {{ ref('bronze_olympedia__country') }}
)

select *
from bronze