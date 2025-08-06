
SELECT 
    {{dbt_utils.generate_surrogate_key(['movies.movie_skey','users.user_skey'])}} as ratings_skey,
    ratings.movie_id,
    ratings.user_id,
    rating,
    rating_timestamp
FROM {{ref('stage_rating')}} ratings 
    LEFT JOIN {{ref('dim_movie')}} movies ON ratings.movie_id = movies.movie_id
    LEFT JOIN {{ref('dim_user')}} users ON ratings.user_id = users.user_id

{% if is_incremental() %}
    WHERE timestamp > (SELECT MAX (timestamp) FROM {{this}})
{% endif %}