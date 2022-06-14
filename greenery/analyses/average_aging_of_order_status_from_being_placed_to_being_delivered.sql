with date_diff_for_each_order as (

    select
        order_guid,
        delivered_at_utc - created_at_utc as date_diff

    from {{ ref('stg_greenery__orders') }}
    where order_status = 'delivered'

)

select avg(date_diff) from date_diff_for_each_order