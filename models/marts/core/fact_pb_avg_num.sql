{{ config(materialized='table') }}

WITH latest_date_per_category AS (
    SELECT
        category,
        MAX(createdat) AS latest_createdat
    FROM {{ ref('stg_pb_product_table') }}
    GROUP BY category
),

latest_records AS (
    SELECT s.*
    FROM {{ ref('stg_pb_product_table') }} s
    JOIN latest_date_per_category l
    ON s.category = l.category AND s.createdat = l.latest_createdat
)

SELECT
    category,
    avgreview,
    numofreviews,
    goodsname,
    createdat
FROM latest_records
WHERE avgreview IS NOT NULL
AND numofreviews IS NOT NULL
AND goodsname IS NOT NULL
AND createdat IS NOT NULL
