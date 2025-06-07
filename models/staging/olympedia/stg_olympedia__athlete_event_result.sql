{{ config(materialized='table') }}

with 
source as (
    select * from {{ source('olympedia', 'athlete_event_result') }}
),
renamed as (
    select
        edition_id as EditionId,
        country_noc as CountryNoc,
        sport as Sport,
        event as Event,
        result_id as ResultId,
        athlete_id as AthleteId,
        position as Position,
        medal as Medal,
        is_team_sport as IsTeamSport
    from source
)

select * from renamed
