with 
source as (
    select * from {{ source('olympedia', 'game_medal_tally') }}
),
renamed as (
    select
        edition_id as EditionId,
        gold as GoldMedals,
        silver as SilverMedals,
        bronze as BronzeMedals,
        total as TotalMedals
    from source
)

select * from renamed
