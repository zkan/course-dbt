# Greenery

> How many users do we have?

```sql
SELECT COUNT(1) FROM dbt_kan_o.stg_users
```

We have 130 users.

> On average, how many orders do we receive per hour?

```sql
WITH order_counts_in_each_hour AS (

  SELECT
    DATE_TRUNC('hour', created_at),
    COUNT(order_id) AS order_count
  FROM
    dbt_kan_o.stg_orders
  GROUP BY
    DATE_TRUNC('hour', created_at)

)

SELECT AVG(order_count) FROM order_counts_in_each_hour
```

We receive 7.52 orders per hour.

> On average, how long does an order take from being placed to being delivered?

```sql
WITH date_diff_for_each_order AS (

  SELECT
    order_id,
    delivered_at - created_at AS date_diff
  FROM
    dbt_kan_o.stg_orders
  WHERE
    status = 'delivered'

)

SELECT AVG(date_diff) FROM date_diff_for_each_order
```

It takes almost 4 days from being placed to being delivered.

> How many users have only made one purchase? Two purchases? Three+ purchases?

```sql
WITH users_with_order_count AS (

  SELECT
    user_id,
    COUNT(order_id) AS order_count
  FROM
    dbt_kan_o.stg_orders
  GROUP BY
    user_id

)

SELECT 'who_made_one_purchase' AS user_group, COUNT(1) FROM users_with_order_count WHERE order_count = 1

UNION

SELECT 'who_made_two_purchases'  AS user_group, COUNT(1) FROM users_with_order_count WHERE order_count = 2

UNION

SELECT 'who_made_three+_purchases'  AS user_group, COUNT(1) FROM users_with_order_count WHERE order_count >= 3
```

We have:

* 71 users who made one purchase
* 28 users who made two purchases
* 25 users who made three+ purchases

> On average, how many unique sessions do we have per hour?

```sql
WITH unique_sessions_in_each_hour AS (

  SELECT
    DATE_TRUNC('hour', created_at),
    COUNT(DISTINCT session_id) AS distinct_session_count
  FROM
    dbt_kan_o.stg_events
  GROUP BY
    DATE_TRUNC('hour', created_at)

)

SELECT AVG(distinct_session_count) FROM unique_sessions_in_each_hour
```

We have aroud 16.33 unique sessions per hour.
