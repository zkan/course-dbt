{{
  config(
    materialized = 'view'
  )
}}

with source as (

  select * from {{ source('greenery', 'users') }}

),

renamed as (

  select
    user_id,
    first_name,
    last_name,
    email,
    phone_number,
    created_at,
    updated_at,
    address_id

  from source

)

select * from renamed