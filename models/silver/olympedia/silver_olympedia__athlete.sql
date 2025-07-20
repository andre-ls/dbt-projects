{{ config(materialized='table') }}

with bronze as (
    select * from {{ ref('bronze_olympedia__athlete_bio') }}
),
country as (
    select * from {{ ref('silver_olympedia__country') }}
)

select 
    bronze.AthleteId,
    bronze.Name,
    bronze.Gender,
    bronze.BirthDate,
    bronze.Height,
    bronze.Weight,
    coalesce(country.Noc,bronze.Country) AS Country
from bronze
left join country
    on trim(bronze.Country) = trim(country.Name)
