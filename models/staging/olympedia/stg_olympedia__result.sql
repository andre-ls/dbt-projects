{{ config(materialized='table') }}

with 
source as (
    select * from {{ source('olympedia', 'result') }}
),
renamed as (
    select
        result_id as ResultId,
        event_title as EventTitle,
        sport as Sport,
        result_date as ResultDate,
        result_location as ResultLocation,
        result_participants as ResultParticipants,
        result_format as ResultFormat,
        result_detail as ResultDetail,
        result_description as ResultDescription
    from source
)

select * from renamed
