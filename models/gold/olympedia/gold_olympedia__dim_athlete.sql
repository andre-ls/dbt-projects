{{ config(materialized='table') }}

with silver as (
    select * from {{ ref('silver_olympedia__athlete') }}
),
country as (
    select * from {{ ref('silver_olympedia__country') }}
)

select 
    row_number() over (partition by AthleteId) + AthleteId AS SKAthlete,
    AthleteId,
    silver.Name,
    Gender,
    BirthDate,
    Height,
    Weight,
    coalesce(country.Name,silver.Country) as Country
from silver
left join country
    on trim(silver.Country) = trim(country.Noc)