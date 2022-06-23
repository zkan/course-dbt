{%
    set event_types = dbt_utils.get_query_results_as_dict(
        "select distinct quote_literal(event_type) as event_type, event_type as column_name from"
        ~ ref('stg_greenery__events')
    )
%}

select
    session_guid
    , user_guid
    , created_at_utc
    {% for event_type in event_types['event_type'] %}
    , sum(case when event_type = {{ event_type }} then 1 else 0 end) as {{ event_types['column_name'][loop.index0] }}
    {% endfor %}

from {{ ref('stg_greenery__events') }}
group by 1, 2, 3
