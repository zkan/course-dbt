# Week 1

> How many users do we have?

```sql
select count(distinct user_guid) from "dbt"."dbt_kan_o"."stg_greenery__users"
```

We have 130 users.

> On average, how many orders do we receive per hour?

```sql
with order_counts_in_each_hour as (

    select
        date_trunc('hour', created_at_utc),
        count(order_guid) AS order_count

    from "dbt"."dbt_kan_o"."stg_greenery__orders"
    group by date_trunc('hour', created_at_utc)

)

select avg(order_count) from order_counts_in_each_hour
```

We receive 7.52 orders per hour.

> On average, how long does an order take from being placed to being delivered?

```sql
with date_diff_for_each_order as (

    select
        order_guid,
        delivered_at_utc - created_at_utc as date_diff

    from "dbt"."dbt_kan_o"."stg_greenery__orders"
    where order_status = 'delivered'

)

select avg(date_diff) from date_diff_for_each_order
```

It takes almost 4 days (3 days 21:24:11.803279) from being placed to being delivered.

> How many users have only made one purchase? Two purchases? Three+ purchases?

```sql
with users_with_order_count as (

    select
        user_guid,
        case
            when count(order_guid) = 1 then 'one_purchase'
            when count(order_guid) = 2 then 'two_purchases'
            when count(order_guid) >= 3 then 'three_plus_purchases'
        end as order_count

    from "dbt"."dbt_kan_o"."stg_greenery__orders"
    group by 1

)

select
    order_count,
    count(1)

from users_with_order_count
group by 1
```

We have:

* 25 users who made one purchase
* 28 users who made two purchases
* 71 users who made three+ purchases

> On average, how many unique sessions do we have per hour?

```sql
with unique_sessions_in_each_hour as (

    select
        date_trunc('hour', created_at_utc),
        count(distinct session_guid) as distinct_session_count

    from "dbt"."dbt_kan_o"."stg_greenery__events"
    group by date_trunc('hour', created_at_utc)

)

select avg(distinct_session_count) from unique_sessions_in_each_hour
```

We have aroud 16.33 unique sessions per hour.
