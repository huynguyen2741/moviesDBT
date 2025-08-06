 
 SELECT 
   {{dbt_utils.generate_surrogate_key(['user_skey','movie_skey'])}} as tag_skey,
   users.user_skey,
   movies.movie_skey,
   tags.tag,
   tags.user_id,
   tags.movie_id,
   tags.tag_timestamp
FROM {{ref('stage_tag')}} tags
   LEFT JOIN {{ref('dim_user')}} users ON tags.user_id = users.user_id
   LEFT JOIN {{ref('dim_movie')}} movies ON tags.movie_id = movies.movie_id

{% if is_incremental() %}
   WHERE timestamp > (SELECT MAX(timestamp) FROM {{this}})
{% endif %}
