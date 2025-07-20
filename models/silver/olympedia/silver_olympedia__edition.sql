with bronze as (
    select * from {{ ref('bronze_olympedia__game') }}
),
medal_tally as (
    select * from {{ ref('bronze_olympedia__game_medal_tally') }}
)

select 
    bronze.EditionId,
    bronze.Edition,
    bronze.City,
    bronze.CountryNoc,
    bronze.CountryFlagUrl,
    bronze.Year,
    bronze.StartDate,
    bronze.EndDate,
    bronze.IsHeld,
    array_agg(
        struct(
            medal_tally.CountryNoc,
            medal_tally.BronzeMedals, 
            medal_tally.SilverMedals, 
            medal_tally.GoldMedals, 
            medal_tally.TotalMedals
        ) 
    order by medal_tally.TotalMedals desc) AS MedalTable
from bronze
left join medal_tally
    on bronze.EditionId = medal_tally.EditionId
group by all