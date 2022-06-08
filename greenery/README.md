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
    date_trunc('hour', created_at),
    COUNT(order_id) AS order_count
  FROM
    dbt_kan_o.stg_orders
  GROUP BY
    date_trunc('hour', created_at)
  
)

SELECT AVG(order_count) FROM order_counts_in_each_hour
```

We receive 7.52 orders per hour.


> On average, how long does an order take from being placed to being delivered?


> How many users have only made one purchase? Two purchases? Three+ purchases?


> On average, how many unique sessions do we have per hour?