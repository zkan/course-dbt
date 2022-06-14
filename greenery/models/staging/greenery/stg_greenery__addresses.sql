{{
  config(
    materialized = 'view'
  )
}}

with source as (

    select * from {{ source('greenery', 'addresses') }}

),

recasted as (

    select
        address_id as address_guid,
        address,
        zipcode,
        state,
        country

    from source

)

select * from recasted