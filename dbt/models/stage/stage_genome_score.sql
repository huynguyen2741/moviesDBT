SELECT 
    movieid AS movie_id,
    tagid AS tag_id,
    relevance
FROM {{ source('moviesDB','RAW_GENOME_SCORES')}}

