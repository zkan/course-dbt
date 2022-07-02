# Week 4

> How do the data change for the two orders after run `dbt snapshot`?

After we ran the following queries:

```sql
UPDATE
    orders
SET
    tracking_id = 'a807fe66-d8b1-4d38-b409-558fed8bd75f',
    shipping_service = 'ups',
    estimated_delivery_at = '2021-02-19T10:15:26Z',
    status = 'shipped'
WHERE
    order_id = '914b8929-e04a-40f8-86ee-357f2be3a2a2';
```

```sql
UPDATE
    orders
SET
    tracking_id = '8404ed05-0128-4aeb-8ed5-6e44908875c4',
    shipping_service = 'ups',
    estimated_delivery_at = '2021-02-19T10:15:26Z',
    status = 'shipped'
WHERE
    order_id = '05202733-0e17-4726-97c2-0520c024ab85';
```

Here are the results from the `dbt snapshot`:

The log shows that there are 2 rows got inserted.

![dbt Snapshot Results 01](./img/dbt-snapshot-results-01.png)

![dbt Snapshot Results 02](./img/dbt-snapshot-results-02.png)

![dbt Snapshot Results 03](./img/dbt-snapshot-results-03.png)

> Product funnel

![Product Funnel](./img/product-funnel.png)

> How are our users moving through the product funnel?

There are 1871 users viewing a page, 986 users getting to the add-to-cart page,
and 361 getting to the check out page.

> Which steps in the funnel have largest drop off points?

The largest drop off point is between add to cart and checkout.

> Exposure to represent that the product funnel is being used in a BI tool

![Lineage Graph](./img/dbt-lineage-week-4.png)

> If your organization is thinking about using dbt, how would you pitch the
> value of dbt/analytics engineering to a decision maker at your organization?

Instead of having ad-hoc 1k+ queries and no one knows what they are, we can
gain values from the dbt to have a much better way of work with reuseable code
that allows us to scale our data analytics.

Having an analytics engineering in the organization encourages software
engineering practices in data. With less effort, we can dig in the data and get
more insights and business values.

> If your organization is using dbt, what are 1-2 things you might do
> differently / recommend to your organization based on learning from this
> course?

I'll recommend the organization to

* structure the dbt project with good practices, so we can follow the same
  practices and have a better collaboration between the teams;
* focus on the intermediate models and how we can reuse the models;
* try automating things by using an orchestration tool to schedule all of the
  tasks;
* monitor the dbt project performance by looking at the dbt metadata.

> If you are thinking about moving to analytics engineering, what skills have
> you picked that give you the most confidence in pursuing this next step?

I think the skills would be business domain analysis, writing SQL, and software
engineering.

> How would you go about setting up a production/scheduled dbt run of your
> project in an ideal state?

Here are the steps I think I would do:

1. Visualize my workflow and all of my manual steps to see and design how I can
automate.
1. I think I would choose Dagster as an orchestration tool since it seems
having a better integration with dbt than other orchestration tools.
1. I will schedule the following dbt commands:
    * `dbt source freshness`
    * `dbt build`
    * `dbt docs generate`
1. For the metadata, I'm interested in
[run_results.json](https://docs.getdbt.com/reference/artifacts/run-results-json)
since it allows me to understand how my models, tests, etc. are performing over
time.
