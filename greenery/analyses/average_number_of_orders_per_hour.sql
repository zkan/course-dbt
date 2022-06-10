with order_counts_in_each_hour as (

    select
        date_trunc('hour', created_at),
        count(order_id) AS order_count

    from {{ ref('stg_greenery__orders') }}
    group by date_trunc('hour', created_at)

)

select avg(order_count) from order_counts_in_each_hour