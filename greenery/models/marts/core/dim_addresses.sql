{{
  config(
    materialized = 'table'
  )
}}

with

addresses as (

    select
        address_guid,
        address,
        zipcode,
        state,
        country

    from {{ ref('stg_greenery__addresses') }}

)

select * from addresses