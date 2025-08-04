{% snapshot snapshot_movie_tagging %}
    {{
        config (
            strategy = 'timestamp',
            target_schema = 'snapshots',
            unique_key = ['user_id','movie_id','tag'],
            updated_at = 'tag_timestamp',
            invalidate_hard_deletes = True
        )
    }}

    SELECT 
        user_id,
        movie_id,
        tag,
        CAST(tag_timestamp AS TIMESTAMP_NTZ) as tag_timestamp 
    FROM {{ref('stage_tag')}}

{% endsnapshot %}