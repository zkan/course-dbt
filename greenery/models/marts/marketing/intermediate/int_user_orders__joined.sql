{{
  config(
    materialized = 'view'
  )
}}

with

product_orders as (

    select
        order_guid,
        user_guid,
        product_name,
        promo_guid,
        order_cost_usd,
        shipping_cost_usd,
        order_total_usd,
        quantity,
        inventory,
        shipping_service,
        order_created_at_utc,
        estimated_delivery_at_utc,
        delivered_at_utc,
        order_status
    
    from {{ ref('int_product_orders__joined') }}

),

users as (

    select
        user_guid,
        first_name,
        last_name,
        email,
        phone_number,
        address_guid
    
    from {{ ref('stg_greenery__users') }}

),

addresses as (

    select
        address_guid,
        address,
        zipcode,
        state,
        country

    from {{ ref('stg_greenery__addresses') }}

),

final as (

    select
        u.user_guid,
        first_name,
        last_name,
        email,
        phone_number,
        address,
        zipcode,
        state,
        country,
        po.order_guid,
        product_name,
        promo_guid,
        order_cost_usd,
        shipping_cost_usd,
        order_total_usd,
        quantity,
        inventory,
        shipping_service,
        order_created_at_utc,
        estimated_delivery_at_utc,
        delivered_at_utc,
        order_status

    from product_orders as po
    left join users as u
    on
        po.user_guid = u.user_guid
    left join addresses as a
    on
        u.address_guid = a.address_guid

)

select * from final