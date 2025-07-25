{{ config(materialized='table') }}

SELECT 
    brandname AS 브랜드명,
    goodsname AS 상품명,
    rank AS 순위,
    category AS 카테고리,
    ispb AS PB브랜드여부,
    ROUND(
    CASE 
        WHEN avgreview IS NULL THEN 0
        ELSE avgreview
    END,
    1) AS 평균리뷰점수,
    CASE
        WHEN pctof5 IS NULL THEN 0
        ELSE pctof5
    END AS '5점리뷰(%)',
    CASE
        WHEN pctof4 IS NULL THEN 0
        ELSE pctof4
    END AS '4점리뷰(%)',
    CASE
        WHEN pctof3 IS NULL THEN 0
        ELSE pctof3
    END AS '3점리뷰(%)',
    CASE
        WHEN pctof2 IS NULL THEN 0
        ELSE pctof2
    END AS '2점리뷰(%)',
    CASE
        WHEN pctof1 IS NULL THEN 0
        ELSE pctof1
    END AS '1점리뷰(%)',
    numofreviews AS 총리뷰수,
    createdat AS 날짜
FROM {{ ref('stg_top10_rank_product_table') }}