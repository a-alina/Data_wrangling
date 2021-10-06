{% snapshot actors_snapshot %}

{{config(
    target_database='dellstore',
    target_schema='public',
    strategy='check',
    unique_key='first_name',
    check_cols=['movie_number', 'movie_prices'],
)}}

SELECT * FROM {{source('dellstore_dataset', 'actors')}}

{% endsnapshot %}