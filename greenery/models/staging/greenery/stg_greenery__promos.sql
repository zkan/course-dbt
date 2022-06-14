{{
  config(
    materialized = 'view'
  )
}}

with source as (

  select * from {{ source('greenery', 'promos') }}

),

recasted as (

  select
    replace(replace(lower(promo_id), '-', '_'), ' ', '_') as promo_guid,
    discount,
    status as promo_status

  from source

)

select * from recasted