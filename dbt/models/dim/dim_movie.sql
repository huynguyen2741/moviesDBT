-- create dim_movies table 
SELECT
    {{dbt_utils.generate_surrogate_key(['movies.movie_id'])}} as movie_skey,
    movies.movie_id,
    genres,
    title,
    imdb_id,
    tmdb_id
FROM {{ref('stage_movie')}} movies
    LEFT JOIN {{ref('stage_link')}} links ON movies.movie_id = links.movie_id