SELECT
  userId AS user_id,
  movieId AS movie_id,
  tag,
  TO_TIMESTAMP_LTZ(timestamp) AS tag_timestamp
FROM {{source('moviesDB','RAW_TAGS')}}
