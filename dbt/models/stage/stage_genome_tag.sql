SELECT
  tagId AS tag_id,
  tag
FROM {{ source('moviesDB','RAW_GENOME_TAGS')}}