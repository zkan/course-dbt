{{
  config(
    materialized = 'view'
  )
}}

with source as (

  select * from {{ source('greenery', 'users') }}

),

recasted as (

  select
    user_id as user_guid,
    first_name,
    last_name,
    email,
    phone_number,
    created_at as created_at_utc,
    updated_at as updated_at_utc,
    address_id

  from source

)

select * from recasted