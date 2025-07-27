-- models/staging/olvy/products/stg_rank_product_table.sql

{{ config(materialized='view') }}

SELECT *
FROM {{ source('preprocessed_data', 'rank_product_table') }}
