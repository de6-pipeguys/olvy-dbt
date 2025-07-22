{{ config(materialized='table') }}

SELECT
    category,
    avgreview,
    numofreviews,
    goodsname,
    createdat,
    rank,
    
    CASE
        WHEN rank BETWEEN 1 AND 20 THEN 'Top 20'
        WHEN rank BETWEEN 21 AND 50 THEN 'Top 50'
        WHEN rank BETWEEN 51 AND 100 THEN 'Top 100'
        ELSE 'Others'
    END AS rank_range

FROM {{ ref('stg_rank_product_table') }}
