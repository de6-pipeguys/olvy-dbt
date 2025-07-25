{{ config(materialized='table') }}

SELECT 
    brandname,
    goodsname,
    rank,
    category,
    ispb,
    ROUND(
    CASE 
        WHEN avgreview IS NULL THEN 0
        ELSE avgreview
    END,
    1),
    CASE
        WHEN pctof5 IS NULL THEN 0
        ELSE pctof5
    END,
    CASE
        WHEN pctof4 IS NULL THEN 0
        ELSE pctof4
    END,
    CASE
        WHEN pctof3 IS NULL THEN 0
        ELSE pctof3
    END,
    CASE
        WHEN pctof2 IS NULL THEN 0
        ELSE pctof2
    END,
    CASE
        WHEN pctof1 IS NULL THEN 0
        ELSE pctof1
    END,
    numofreviews,
    createdat
FROM {{ ref('stg_top10_rank_product_table') }}