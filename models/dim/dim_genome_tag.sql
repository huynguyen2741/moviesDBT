-- Create dim_tags table
SELECT 
    {{dbt_utils.generate_surrogate_key(['tag_id'])}} as tag_skey,
    tag_id,
    tag 
FROM {{ref('stage_genome_tag')}}