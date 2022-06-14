select count(distinct user_guid) from {{ ref('stg_greenery__users') }}
