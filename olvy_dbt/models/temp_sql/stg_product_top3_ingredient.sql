{{ config(materialized='view') }}

WITH cleaned AS (
SELECT
    goodsname,
    brandname,
    isPb,
    category,
    createdat,
    REGEXP_REPLACE(ingredients, '^([■]\\s*)?\\[[^\\]]+\\]\\s*', '') AS cleaned_ingredients
FROM {{ ref('rank_product_table') }}
WHERE ingredients IS NOT NULL
),
split AS (
SELECT
    goodsname,
    brandname,
    isPb,
    category,
    createdat,
    TRIM(SPLIT_PART(cleaned_ingredients, ',', 1)) AS ingredient,
    1 AS position
FROM cleaned

UNION ALL

SELECT
    goodsname,
    brandname,
    isPb,
    category,
    createdat,
    TRIM(SPLIT_PART(cleaned_ingredients, ',', 2)) AS ingredient,
    2 AS position
FROM cleaned

UNION ALL

SELECT
    goodsname,
    brandname,
    isPb,
    category,
    createdat,
    TRIM(SPLIT_PART(cleaned_ingredients, ',', 3)) AS ingredient,
    3 AS position
FROM cleaned
)

SELECT
    category,
    ingredient,
    COUNT(DISTINCT goodsname) AS product_count,
    COUNT(*) AS total_occurrences,
    MIN(position) AS best_position
FROM split
WHERE ingredient IS NOT NULL AND ingredient <> ''
GROUP BY category, ingredient
ORDER BY category, total_occurrences DESC
