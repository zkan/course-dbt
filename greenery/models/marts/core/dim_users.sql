{{
  config(
    materialized = 'table'
  )
}}

with

users as (

    select
        user_guid,
        first_name,
        last_name,
        email,
        phone_number,
        created_at_utc,
        updated_at_utc,
        address_guid

    from {{ ref('stg_greenery__users') }}

)

select * from users