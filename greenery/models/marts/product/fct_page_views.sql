{{
  config(
    materialized = 'table'
  )
}}

with

session_length as (

    select
        session_guid
        , min(created_at_utc) as first_event
        , max(created_at_utc) as last_event

    from {{ ref('stg_greenery__events') }}
    group by 1

),

final as (

    select
        agg.session_guid
        , agg.user_guid
        , u.first_name
        , u.last_name
        , u.email
        , agg.package_shipped
        , agg.page_view
        , agg.checkout
        , agg.add_to_cart
        , session_length.first_event as first_session_event
        , session_length.last_event as last_session_event
        , date_part('hour', session_length.last_event::timestamp - session_length.first_event::timestamp) as hours_diff

    from {{ ref('int_session_events__agg') }} agg
    left join {{ ref('stg_greenery__users') }} u
        on agg.user_guid = u.user_guid
    left join session_length
        on agg.session_guid = session_length.session_guid

)

select * from final
