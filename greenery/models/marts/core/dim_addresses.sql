{{
  config(
    materialized = 'table'
  )
}}

select
    address_guid,
    address,
    zipcode,
    state,
    country

from {{ ref('stg_greenery__addresses') }}