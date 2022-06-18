{{
  config(
    materialized = 'table'
  )
}}

with

products as (

    select
      product_guid,
      name,
      price_usd,
      inventory

    from {{ ref('stg_greenery__products') }}

)

select * from products