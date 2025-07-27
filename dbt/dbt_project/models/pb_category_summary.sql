WITH all_products AS (
    SELECT 
        category,
        DATE(createdAt) AS date,
        COUNT(*) AS total_products
    FROM {{ source('preprocessed_data', 'rank_product_table') }}
    GROUP BY category, DATE(createdAt)
),

pb_products AS (
    SELECT 
        category,
        DATE(createdAt) AS date,
        AVG(rank) AS avg_rank,
        AVG(avgReview) AS avg_review,
        SUM(numOfReviews) AS total_reviews,
        COUNT(*) AS pb_count
    FROM {{ source('preprocessed_data', 'rank_product_table') }}
    WHERE isPB = 1
    GROUP BY category, DATE(createdAt)
)

SELECT 
    pb.category,
    pb.date AS collected_date,
    pb.avg_rank,
    ROUND(100.0 * pb.pb_count / ap.total_products, 4) AS pb_ratio,
    ROUND(pb.avg_review, 2) AS avg_review,
    pb.total_reviews,
    pb.pb_count AS num_pb_products
FROM pb_products pb
LEFT JOIN all_products ap
  ON pb.category = ap.category AND pb.date = ap.date
ORDER BY pb.category, pb.date