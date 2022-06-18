{{
  config(
    materialized = 'table'
  )
}}

with

promos as (

    select
        promo_guid,
        discount_usd,
        promo_status

    from {{ ref('stg_greenery__promos') }}

)

select * from promos