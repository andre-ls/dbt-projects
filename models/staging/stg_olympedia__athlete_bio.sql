{{ config(materialized='table') }}

with 
source as (
    select * from {{ source('olympedia', 'athlete_bio') }}
),
renamed as (
    select 
        athlete_id as AthleteId,
        name as Name,
        sex as Gender,
        birth_date as BirthDate,
        height as Height,
        weight as Weight,
        country as Country
    from source
)

select * from renamed
