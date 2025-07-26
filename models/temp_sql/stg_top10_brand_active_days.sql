{{ config(materialized='view') }}

SELECT
    brandname,
    category,
    ispb,
    COUNT(DISTINCT createdat) AS top10_active_days
FROM {{ ref('stg_top10_rank_product_table') }}
GROUP BY 1, 2, 3
ORDER BY top10_active_days DESC