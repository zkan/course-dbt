{{
  config(
    materialized = 'table'
  )
}}

with

final as (

    select
        user_guid,
        first_name,
        last_name,
        email,
        phone_number,
        address,
        zipcode,
        state,
        country,
        order_guid,
        product_name,
        promo_guid,
        order_cost_usd,
        shipping_cost_usd,
        order_total_usd,
        shipping_service,
        order_created_at_utc,
        estimated_delivery_at_utc,
        delivered_at_utc,
        order_status

    from {{ ref('user_orders__joined') }}

)

select * from final