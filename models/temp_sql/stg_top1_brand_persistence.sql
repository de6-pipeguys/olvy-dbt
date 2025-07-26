{{ config(materialized='view') }}

SELECT
    brandname,
    category,
    ispb,
    COUNT(*) AS top1_days
FROM {{ ref('stg_top10_rank_product_table') }}
WHERE rank = 1
GROUP BY 1, 2, 3
ORDER BY top1_win_days DESC