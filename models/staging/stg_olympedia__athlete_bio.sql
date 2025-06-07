{{ config(materialized='table') }}

with 
source as (
    select * from {{ source('olympedia', 'athlete_bio') }} WHERE height is not null
),
renamed as (
    select 
        cast(athlete_id as bigint) as AthleteId,
        name as Name,
        sex as Gender,
        cast(birth_date as date) as BirthDate,
        cast(height as numeric) as Height,
        cast(weight as numeric) as Weight,
        country as Country
    from source
)

select * from renamed
