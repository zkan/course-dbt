select
    sum(case when event_type = 'checkout' then 1 else 0 end) as checkout_sessions
    , count(distinct session_guid) as unique_sessions
    , sum(case when event_type = 'checkout' then 1 else 0 end)::float / count(distinct session_guid)::float as overall_conversion_rate
  
from {{ ref('stg_greenery__events') }}