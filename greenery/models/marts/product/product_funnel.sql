with

event_counts as (
    
    select
        sum(page_view) + sum(add_to_cart) + sum(checkout) as nb_events
        , sum(page_view) as nb_page_view_events
        , sum(add_to_cart) as nb_add_to_cart_events
        , sum(checkout) as nb_checkout_events
    
    from {{ ref('int_session_events__agg') }}

)

select
    nb_events
    , nb_page_view_events
    , nb_add_to_cart_events
    , nb_checkout_events
    , nb_page_view_events::numeric / nb_events::numeric as page_view_rate
    , nb_add_to_cart_events::numeric / nb_events::numeric as add_to_cart_rate
    , nb_checkout_events::numeric / nb_events::numeric as checkout_rate

from event_counts