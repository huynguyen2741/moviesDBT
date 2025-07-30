USE WAREHOUSE COMPUTE_WH;
USE DATABASE MOVIELENS_DB;
USE SCHEMA MOVIELENS_DB.RAW;

-- Create a stage to connect to S3 buckets (insert your own S3 URL and credentials)
CREATE OR REPLACE STAGE MOVIESTAGE 
    URL = ''
    CREDENTIALS = (
        AWS_KEY_ID = '',
        AWS_SECRET_KEY = ''
    )
-- Load data from s3 to RAW_MOVIES table
COPY INTO RAW_MOVIES
FROM '@MOVIESTAGE/movies.csv'
FILE FORMAT = (
    SKIP_HEADER = 1,
    TYPE = 'CSV',
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
);
-- Load data from s3 to RAW_RATINGS table
COPY INTO RAW_RATINGS
FROM '@MOVIESTAGE/ratings.csv'
FILE_FORMAT = (
    TYPE = 'CSV',
    SKIP_HEADER = 1,
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
);
-- Load data from s3 to RAW_TAGS table
COPY INTO  RAW_TAGS
FROM '@MOVIESTAGE/tags.csv'
FILE_FORMAT = (
    TYPE = 'CSV',
    SKIP_HEADER = 1,
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
);
-- Load data from s3 to RAW_GENOME_SCORES table
COPY INTO RAW_GENOME_SCORES
FROM '@MOVIESTAGE/genome-scores.csv'
FILE_FORMAT = (
    TYPE = 'CSV',
    SKIP_HEADER = 1,
    FIELD_OPTIONALLY_ENCLOSED_Y = '"'
);
-- Load data from s3 to RAW_GENOME_TAGS table
COPY INTO RAW_GENOME_TAGS
FROM '@MOVIESTAGE/genome-tags.csv'
FILE_FORMAT = (
    TYPE = 'CSV',
    SKIP_HEADER = 1,
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
);
-- Load data from s3 to RAW_LINKS table
COPY INTO RAW_LINKS
FROM '@MOVIESTAGE/links.csv'
FILE_FORMAT = (
    TYPE = 'CSV',
    SKIP_HEADER = 1,
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
)
