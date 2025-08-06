with athlete as (
    select * from {{ ref('silver_olympedia__athlete') }}
),
country as (
    select * from {{ ref('silver_olympedia__country') }}
),
result as (
    select * from {{ ref('silver_olympedia__result') }}
),
country_medals as (
    select distinct 
        r.EventId, 
        r.ResultId, 
        coalesce(c.Name,a.Country) as Country, 
        r.Medal
    from result r 
    left join athlete a 
        on r.AthleteId = a.AthleteId
    left join country c 
        on a.Country = c.Noc
    where r.Medal is not null
)

select 
    Country,
    countif(Medal = 'Bronze') as BronzeMedals,
    countif(Medal = 'Silver') as SilverMedals,
    countif(Medal = 'Gold')   as GoldMedals
from country_medals
where Country is not null
group by Country