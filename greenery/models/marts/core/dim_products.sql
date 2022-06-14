{{
  config(
    materialized = 'table'
  )
}}

select
    product_guid,
    name,
    price_usd,
    inventory

from {{ ref('stg_greenery__products') }}