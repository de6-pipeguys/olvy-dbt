-- models/staging/olvy/flags/stg_rank_flag_table.sql

{{ config(materialized='view') }}

SELECT *
FROM {{ source('preprocessed_data', 'rank_flag_table') }}
