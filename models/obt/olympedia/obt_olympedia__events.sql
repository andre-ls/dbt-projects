with athlete as (
    select * from {{ ref('silver_olympedia__athlete') }}
),
country as (
    select * from {{ ref('silver_olympedia__country') }}
),
event as (
    select * from {{ ref('silver_olympedia__event') }}
),
result as (
    select * from {{ ref('silver_olympedia__result') }}
),
event_medals as (
    select distinct 
        r.EventId,
        r.ResultId, 
        e.Sport,
        e.Event, 
        coalesce(c.Name,a.Country) as Country, 
        r.Medal
    from result r
    left join event e 
        on r.EventId = e.eventId
    left join athlete a 
        on r.AthleteId = a.AthleteId
    left join country c 
        on a.Country = c.Noc
    where r.Medal is not null
)

select  
    EventId, 
    Sport,
    Event,
    Country,
    countif(Medal = 'Bronze') as BronzeMedals,
    countif(Medal = 'Silver') as SilverMedals,
    countif(Medal = 'Gold')   as GoldMedals
from event_medals
group by all