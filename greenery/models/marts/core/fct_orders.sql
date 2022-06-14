{{
  config(
    materialized = 'table'
  )
}}

select
    order_guid,
    user_guid,
    promo_guid,
    address_guid,
    created_at_utc,
    order_cost_usd,
    shipping_cost_usd,
    order_total_usd,
    tracking_guid,
    shipping_service,
    estimated_delivery_at_utc,
    delivered_at_utc,
    order_status

from {{ ref('stg_greenery__orders') }}