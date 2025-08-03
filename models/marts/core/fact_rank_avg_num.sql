{{ config(materialized='table') }}

WITH latest_date_per_category AS (
    SELECT
        category,
        MAX(createdat) AS latest_createdat
    FROM {{ ref('stg_rank_product_table') }}
    GROUP BY category
),

latest_records AS (
    SELECT s.*
    FROM {{ ref('stg_rank_product_table') }} s
    JOIN latest_date_per_category l
    ON s.category = l.category AND s.createdat = l.latest_createdat
)

SELECT
    category,
    ROUND(avgreview, 1) AS avgreview,
    numofreviews,
    goodsname,
    createdat,
    rank,

    CASE
        WHEN rank BETWEEN 1 AND 5 THEN 'Top 5'
        WHEN rank BETWEEN 6 AND 20 THEN 'Top 20'
        WHEN rank BETWEEN 21 AND 50 THEN 'Top 50'
        WHEN rank BETWEEN 51 AND 100 THEN 'Top 100'
        ELSE 'Others'
    END AS rank_range

FROM latest_records
WHERE avgreview IS NOT NULL
    AND numofreviews IS NOT NULL
    AND avgreview > 4 --AVG(avg가 4 이하는 없기때문)
    AND numofreviews != 0
    AND goodsname IS NOT NULL
    AND createdat IS NOT NULL
    AND rank IS NOT NULL
