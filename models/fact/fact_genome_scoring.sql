
SELECT
    {{dbt_utils.generate_surrogate_key(['movies.movie_skey','tags.tag_skey'])}} as scoring_skey,
    movies.movie_skey,
    tags.tag_skey,
    scores.movie_id,
    scores.tag_id,
    relevance
FROM {{ref('stage_genome_score')}} scores 
    LEFT JOIN {{ref('dim_movie')}} movies ON scores.movie_id = movies.movie_id
    LEFT JOIN {{ref('dim_genome_tag')}} tags ON scores.tag_id = tags.tag_id

{% if is_incremental() %}
    WHERE timestamp > (SELECT MAX (timestamp) FROM {{this}})
{% endif %}