with bronze as (
    select * from {{ ref('bronze_olympedia__athlete_event_result') }}
),
result as (
    select * from {{ ref('bronze_olympedia__result') }}
),
events as (
    select Sport, Event from bronze
    union distinct
    select Sport, EventTitle as Event from result
)

select distinct
    {{ dbt_utils.generate_surrogate_key(['events.Sport','events.Event']) }} as EventId,
    events.Sport,
    events.Event
from events
