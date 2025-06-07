{{ config(materialized='table') }}

with 
source as (
    select * from {{ source('olympedia', 'game_medal_tally') }}
),
renamed as (
    select
        cast(edition_id as int) as EditionId,
        cast(gold as int) as GoldMedals,
        cast(silver as int) as SilverMedals,
        cast(bronze as int) as BronzeMedals,
        cast(total as int) as TotalMedals
    from source
)

select * from renamed
