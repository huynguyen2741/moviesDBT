-- Create dim_user table
WITH user_table AS (
    SELECT user_id FROM {{ref('stage_tag')}}
    UNION
    SELECT user_id FROM {{ref('stage_rating')}}
)
SELECT 
    {{dbt_utils.generate_surrogate_key(['user_id'])}} as user_skey,
    user_id
FROM user_table