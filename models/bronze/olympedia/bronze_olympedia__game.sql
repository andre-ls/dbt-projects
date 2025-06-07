{{ config(materialized='table') }}

with 
source as (
    select * from {{ source('olympedia', 'game') }}
),

renamed as (
    select
        cast(edition_id as int) as EditionId,
        edition as Edition,
        city as City,
        country_flag_url as CountryFlagUrl,
        country_noc as CountryNoc,
        cast(year as int) as Year,
        cast(start_date as date) as StartDate,
        cast(end_date as date) as EndDate,
        competition_date as CompetitionDate,
        is_held AS IsHeld
    from source
)

select * from renamed
