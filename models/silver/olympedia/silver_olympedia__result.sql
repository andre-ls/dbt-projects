with bronze as (
    select * from {{ ref('bronze_olympedia__result') }}
),
event_result as (
    select * from {{ ref('bronze_olympedia__athlete_event_result') }}
),
silver_event as (
    select * from {{ ref('silver_olympedia__event') }}
)

select distinct
    bronze.ResultId,
    event_result.EditionId,
    event_result.AthleteId,
    silver_event.EventKey,
    event_result.Position,
    event_result.Medal,
    bronze.ResultDetail,
    bronze.ResultDescription,
from bronze
left join event_result
    on bronze.ResultId = event_result.ResultId
left join silver_event
    on bronze.Sport = silver_event.Sport
    and bronze.EventTitle = silver_event.Event