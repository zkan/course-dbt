# Week 2

> What is our user repeat rate?

```sql
with

orders_cohort as (

    select
        user_guid,
        count(distinct order_guid) as user_orders

    from "dbt"."dbt_kan_o"."stg_greenery__orders"
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
```

The repeat rate is 0.7983870967741935.

> What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

* How fast delivery is
* Estimated delivery date is close to the actual delivery date
* Number of orders in a purchase
* Shipping service
* Shipping cost
* Average number of sessions per user
* Session length per user
* Promo code

If we have more data, I want to add the following features:

* User rating
* Product group

> Explain the marts models you added. Why did you organize the models in the way you did?

We've organized the mart models into 3 groups:

* Core
* Marketing
* Product

### Core

* `dim_addresses`
* `dim_products`
* `dim_promos`
* `dim_users`
* `fct_orders`
* `fct_events`

These models are common and could be reused by any business unit.

### Marketing

* `int_user_orders__joined`
  
  This is an intermediate model in which we join necessary models together.

* `fct_user_orders`

### Product

* `fct_page_views`

> What assumptions are you making about each model? (i.e. why are you adding each test?)

* Primary keys on every model should be unique and should NOT be NULL
* Email format should be valid
* Phone number format should be valid
* Zipcode should be valid
* Order status should be one of the accepted values (preparing, shipped, or delivered)
* Order quantity should NOT be greater than the product inventory
* Promo code GUID should be in the defined format (using lower case and underscore) before further analysis.
* Promo code status should be one of the accepted values (active or inactive)
* Product inventory should be only positive
* Order quantity should be only positive
* Shipping service should be one of the accepted values (fedex, dhl, ups, or usps) and can be NULL
* Event type should be one of the accepted values (add_to_cart, checkout, page_view, or package_shipped)
* Relationships between models should be associated correctly.

> Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?

We found promo code GUID was originally in an arbitrary format, so we need to clean the staging model of the promo code up before further analysis.

> Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.

We have an automated system that schedules the tests to run every morning to make sure the data are in the good condition and ready for reporting and analyses. If a test fails, the system will notify us; therefore, we can jump in and fix it before the data users know.