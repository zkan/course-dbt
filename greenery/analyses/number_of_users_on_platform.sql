select count(distinct user_id) from {{ ref('stg_greenery__users') }}
