with 
source as (
    select * from {{ source('olympedia', 'game') }}
),

renamed as (
    select
        edition_id as EditionId,
        edition as Edition,
        city as City,
        country_flag_url as CountryFlagUrl,
        country_noc as CountryNoc,
        year as Year,
        start_date as StartDate,
        end_date as EndDate,
        competition_date as CompetitionDate,
        is_held  
    from source
)

select * from renamed
