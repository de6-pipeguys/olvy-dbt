-- models/staging/stg_top1_product_persistence.sql

{{ config(materialized='view') }}

SELECT 
    goodsname,
    brandname,
    category,
    ispb,
    COUNT(*) AS top1_days,
    ROUND(AVG(avgreview),1) AS avg_review_during_top10,
    MAX(numofreviews) AS max_reviews_during_top10
FROM {{ ref('stg_top10_rank_product_table') }}
WHERE rank = 1
GROUP BY 1, 2, 3, 4
ORDER BY top1_days DESC