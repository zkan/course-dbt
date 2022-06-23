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
        {{ lower_and_underscore('promo_id') }} as promo_guid,
        discount as discount_usd,
        status as promo_status

    from source

)

select * from recasted