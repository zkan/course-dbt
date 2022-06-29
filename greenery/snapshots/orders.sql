{% snapshot orders_snapshot_check %}

  {{
    config(
      target_schema = 'snapshots',
      unique_key = 'order_id',
      strategy = 'check',
      check_cols = ['status'],
    )
  }}

  select * from {{ source('greenery', 'orders') }}

{% endsnapshot %}
