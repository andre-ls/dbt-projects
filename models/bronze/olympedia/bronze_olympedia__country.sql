{{ config(materialized='table') }}

with 
source as (
    select * from {{ source('olympedia', 'country') }}
),
renamed as (
    select
        noc as Noc,
        name AS Name
    from source
)

select * from renamed
where Name != 'ROC' --Remove Duplicate
