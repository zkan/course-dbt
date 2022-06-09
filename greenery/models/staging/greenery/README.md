# Greenery

> How many users do we have?

```sql
select count(distinct user_id) from dbt_kan_o.stg_greenery__users
```

We have 130 users.

> On average, how many orders do we receive per hour?

```sql
with order_counts_in_each_hour as (

    select
        date_trunc('hour', created_at),
        count(order_id) AS order_count

    from dbt_kan_o.stg_greenery__orders
    group by date_trunc('hour', created_at)

)

select avg(order_count) from order_counts_in_each_hour
```

We receive 7.52 orders per hour.

> On average, how long does an order take from being placed to being delivered?

```sql
with date_diff_for_each_order as (

    select
        order_id,
        delivered_at - created_at as date_diff

    from dbt_kan_o.stg_greenery__orders
    where status = 'delivered'

)

select avg(date_diff) from date_diff_for_each_order
```

It takes almost 4 days (3 days 21:24:11.803279) from being placed to being delivered.

> How many users have only made one purchase? Two purchases? Three+ purchases?

```sql
with users_with_order_count as (

    select
        user_id,
        count(order_id) as order_count

    from dbt_kan_o.stg_greenery__orders
    group by user_id

)

select 'who_made_one_purchase' as user_group, count(1) from users_with_order_count where order_count = 1
union all
select 'who_made_two_purchases'  as user_group, count(1) from users_with_order_count where order_count = 2
union all
select 'who_made_three+_purchases' as user_group, count(1) from users_with_order_count where order_count >= 3
```

We have:

* 25 users who made one purchase
* 28 users who made two purchases
* 71 users who made three+ purchases

> On average, how many unique sessions do we have per hour?

```sql
with unique_sessions_in_each_hour as (

    select
        date_trunc('hour', created_at),
        count(distinct session_id) as distinct_session_count

    from dbt_kan_o.stg_greenery__events
    group by date_trunc('hour', created_at)

)

select avg(distinct_session_count) from unique_sessions_in_each_hour
```

We have aroud 16.33 unique sessions per hour.
