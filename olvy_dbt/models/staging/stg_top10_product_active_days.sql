-- models/staging/stg_top10_product_active_days.sql

{{ config(materialized='view') }}

SELECT
    goodsname,
    brandname,
    category,
    ispb,
    COUNT(DISTINCT createdat) AS active_days_in_top10,
    ROUND(AVG(avgreview),1) AS avg_review_during_top10,
    MAX(numofreviews) AS max_reviews_during_top10
FROM {{ ref('stg_top10_rank_product_table') }}
GROUP BY 1, 2, 3, 4
ORDER BY active_days_in_top10 DESC