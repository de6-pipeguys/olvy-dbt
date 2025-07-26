-- models/staging/stg_top10_rank_product_table.sql

{{ config(materialized='view') }}

SELECT * 
FROM {{ source('preprocessed_data', 'rank_product_table') }}
WHERE rank <= 10 