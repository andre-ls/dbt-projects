with athlete as (
    select * from {{ ref('silver_olympedia__athlete') }}
),
country as (
    select * from {{ ref('silver_olympedia__country') }}
),
edition as (
    select * from {{ ref('silver_olympedia__edition') }}
),
result as (
    select * from {{ ref('silver_olympedia__result') }}
)

select 
    e.EditionId,
    e.Edition,
    e.City,
    c.Name as Country,
    e.Year,
    count(distinct r.EventId) as TotalEventsHeld,
    countif(r.Medal = 'Bronze') as TotalBronzeMedals,
    countif(r.Medal = 'Silver') as TotalSilverMedals,
    countif(r.Medal = 'Gold')   as TotalGoldMedals,
    count(distinct case when a.Gender = 'Male' then a.AthleteId end) AS TotalMaleAthletes,
    count(distinct case when a.Gender = 'Female' then a.AthleteId end) AS TotalFemaleAthletes,
    count(distinct a.AthleteId) as TotalAthletes
from result r
left join edition e 
    on r.EditionId = e.EditionId
left join country c 
    on e.CountryNoc = c.Noc
left join athlete a 
    on r.AthleteId = a.AthleteId
group by all