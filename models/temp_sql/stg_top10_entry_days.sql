-- models/staging/stg_top10_product_active_days.sql

{{ config(materialized='view') }}

SELECT
    goodsname,
    brandname,
    category,
    ispb,
    MIN(createdat) AS first_entry,
    MAX(createdat) AS last_entry
FROM {{ ref('stg_top10_rank_product_table') }}
GROUP BY 1,2,3,4
