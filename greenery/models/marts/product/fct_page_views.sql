{{
  config(
    materialized = 'table'
  )
}}

select
    event_guid,
    session_guid,
    user_guid,
    page_url,
    created_at_utc,
    event_type,
    order_guid,
    product_guid

from {{ ref('stg_greenery__events') }}