{{
  config(
    materialized = 'view'
  )
}}

with

orders as (

    select
        order_guid,
        promo_guid,
        user_guid,
        address_guid,
        order_cost_usd,
        shipping_cost_usd,
        order_total_usd,
        shipping_service,
        created_at_utc as order_created_at_utc,
        estimated_delivery_at_utc,
        delivered_at_utc,
        order_status
    
    from {{ ref('stg_greenery__orders') }}

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

order_items as (

    select
        order_guid,
        product_guid
    
    from {{ ref('stg_greenery__order_items') }}

),

products as (

    select
        product_guid,
        name as product_name

    from {{ ref('stg_greenery__products') }}

),

final as (

    select
        o.user_guid,
        first_name,
        last_name,
        email,
        phone_number,
        address,
        zipcode,
        state,
        country,
        o.order_guid,
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

    from orders as o
    left join users as u
    on
        o.user_guid = u.user_guid
    left join addresses as a
    on
        o.address_guid = a.address_guid
    left join order_items as oi
    on
        o.order_guid = oi.order_guid
    left join products as p
    on
        oi.product_guid = p.product_guid

)

select * from final