with users_with_order_count as (

    select
        user_guid,
        count(order_guid) as order_count

    from {{ ref('stg_greenery__orders') }}
    group by user_guid

)

select 'who_made_one_purchase' as user_group, count(1) from users_with_order_count where order_count = 1
union all
select 'who_made_two_purchases'  as user_group, count(1) from users_with_order_count where order_count = 2
union all
select 'who_made_three+_purchases' as user_group, count(1) from users_with_order_count where order_count >= 3