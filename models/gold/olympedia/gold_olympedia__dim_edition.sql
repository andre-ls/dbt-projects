{{ config(materialized='table') }}

with silver as (
    select * from {{ ref('silver_olympedia__edition') }}
),
country as (
    select * from {{ ref('silver_olympedia__country') }}
)

select 
    row_number() over (partition by EditionId) + EditionId AS SKEdition,
    EditionId,
    Edition,
    City,
    country.Name,
    CountryFlagUrl,
    Year,
    StartDate,
    EndDate,
    IsHeld
from silver
left join country
    on silver.CountryNoc = country.Noc