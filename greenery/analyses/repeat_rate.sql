with

orders_cohort as (

    select
        user_guid,
        count(distinct order_guid) as user_orders

    from {{ ref('stg_greenery__orders') }}
    group by 1

),

users_bucket as (

    select
        user_guid,
        (user_orders = 1)::int has_one_purchase,
        (user_orders >= 2)::int has_two_purchases,
        (user_orders >= 3)::int has_three_plus_purchases
    
    from orders_cohort

)

select
    sum(has_two_purchases)::float / count(distinct user_guid)::float as repeat_rate

from users_bucket