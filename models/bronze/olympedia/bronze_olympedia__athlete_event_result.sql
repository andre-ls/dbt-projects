{{ config(materialized="table") }}

with
    source as (
        select * from {{ source("olympedia", "athlete_event_result") }}
    ),
    renamed as (
        select
            cast(edition_id as int) as EditionId,
            country_noc as CountryNoc,
            sport as Sport,
            event as Event,
            cast(result_id as bigint) as ResultId,
            cast(athlete_id as bigint) as AthleteId,
            position as Position,
            medal as Medal,
            cast(is_team_sport as boolean) as IsTeamSport
        from source
    )

select *
from renamed