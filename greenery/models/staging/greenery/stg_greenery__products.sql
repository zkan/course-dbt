{{
  config(
    materialized = 'view'
  )
}}

with source as (

    select * from {{ source('greenery', 'products') }}

),

recasted as (

    select
        product_id as product_guid,
        name,
        price as price_usd,
        inventory

    from source

)

select * from recasted