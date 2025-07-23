{{ config(materialized='view') }}

SELECT
    brandname,
    category,
    ispb,
    COUNT(*) AS top10_entry_count
FROM {{ ref('stg_top10_rank_product_table') }}
GROUP BY 1, 2, 3
ORDER BY top10_entry_count DESC