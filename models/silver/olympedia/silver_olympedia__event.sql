with bronze as (
    select * from {{ ref('bronze_olympedia__athlete_event_result') }}
),
result as (
    select * from {{ ref('bronze_olympedia__result') }}
)

select distinct
    {{ dbt_utils.generate_surrogate_key(['bronze.Sport','bronze.Event']) }} as EventId,
    bronze.Sport,
    bronze.Event,
    bronze.IsTeamSport
from bronze
left join result
    on bronze.ResultId = result.ResultId
