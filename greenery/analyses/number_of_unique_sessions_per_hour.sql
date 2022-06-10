with unique_sessions_in_each_hour as (

    select
        date_trunc('hour', created_at),
        count(distinct session_id) as distinct_session_count

    from {{ ref('stg_greenery__events') }}
    group by date_trunc('hour', created_at)

)

select avg(distinct_session_count) from unique_sessions_in_each_hour