WITH base AS (
    SELECT
        category,
        brandname,
        goodsname,
        pctof1,
        pctof2,
        pctof3,
        pctof4,
        pctof5
    FROM preprocessed_data.pb_product_table
),

ranked AS (
    SELECT *,
           RANK() OVER (ORDER BY pctof1 DESC) AS new_rank,
           ROW_NUMBER() OVER (PARTITION BY goodsname ORDER BY pctof1 DESC) AS rn
    FROM base
)

SELECT
    new_rank,
    category,
    brandname,
    goodsname,
    pctof1,
    pctof2,
    pctof3,
    pctof4,
    pctof5
FROM ranked
WHERE rn = 1 AND new_rank <= 100
