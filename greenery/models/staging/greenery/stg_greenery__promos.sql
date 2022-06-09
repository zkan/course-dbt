{{
  config(
    materialized = 'view'
  )
}}

select
    promo_id,
    discount,
    status

from {{ source('greenery', 'promos') }}
