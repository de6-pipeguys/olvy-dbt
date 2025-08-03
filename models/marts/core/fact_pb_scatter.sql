{{ config(materialized='table') }}

SELECT
    numofreviews,
    ROUND(AVG(avgreview), 1) AS avg_avgreview,
    CAST(
        LISTAGG(goodsname, ', ') WITHIN GROUP (ORDER BY goodsname)
        AS VARCHAR(4000)
    ) AS goodsname_list,
    
    -- 쉼표 개수 + 1 = 상품 개수 (빈 문자열 체크 포함)
    CASE
        WHEN COUNT(goodsname) = 0 THEN 0
        ELSE LENGTH(CAST(LISTAGG(goodsname, ', ') WITHIN GROUP (ORDER BY goodsname) AS VARCHAR(4000))) 
            - LENGTH(REPLACE(CAST(LISTAGG(goodsname, ', ') WITHIN GROUP (ORDER BY goodsname) AS VARCHAR(4000)), ',', '')) + 1
    END AS goods_count

FROM {{ ref('fact_pb_avg_num') }}
GROUP BY numofreviews
