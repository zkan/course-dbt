with date_diff_for_each_order as (

    select
        order_id,
        delivered_at - created_at as date_diff

    from {{ ref('stg_greenery__orders') }}
    where status = 'delivered'

)

select avg(date_diff) from date_diff_for_each_order