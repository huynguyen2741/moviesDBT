SELECT 
    movieId AS movie_id,
    title,
    genres
FROM {{source('moviesDB','RAW_MOVIES')}}