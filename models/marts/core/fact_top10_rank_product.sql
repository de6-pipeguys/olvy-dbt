{{ config(materialized='table') }}

SELECT *
FROM {{ ref('stg_top10_rank_product_table') }}