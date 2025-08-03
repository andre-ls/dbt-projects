with athlete as (
    select * from {{ ref('silver_olympedia__athlete') }}
),
country as (
    select * from {{ ref('silver_olympedia__country') }}
),
result as (
    select * from {{ ref('silver_olympedia__result') }}
)

select 
    a.AthleteId,
    a.Name, 
    a.Gender,
    coalesce(c.Name,a.Country) as Country,
    countif(r.Medal = 'Bronze') as Bronze,
    countif(r.Medal = 'Silver') as Silver,
    countif(r.Medal = 'Gold')   as Gold
from athlete a
left join country c 
    on a.Country = c.Noc
left join result r 
    on a.AthleteId = r.AthleteId
group by all