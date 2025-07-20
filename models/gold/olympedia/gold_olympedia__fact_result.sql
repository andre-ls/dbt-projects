with silver as (
    select * from {{ ref('silver_olympedia__result') }}
),
dim_athlete as (
    select SKAthlete, AthleteId from {{ ref('gold_olympedia__dim_athlete') }}
),
dim_edition as (
    select SKEdition, EditionId from {{ ref('gold_olympedia__dim_edition') }}
),
dim_event as (
    select SKEvent, EventId from {{ ref('gold_olympedia__dim_event') }}
)

select 
    ResultId,
    SKEdition,
    SKEvent,
    SKAthlete,
    Position,
    Medal
from silver s
inner join dim_athlete da
    on s.AthleteId = da.AthleteId
inner join dim_edition de
    on s.EditionId = de.EditionId
inner join dim_event dv
    on s.EventId = dv.EventId