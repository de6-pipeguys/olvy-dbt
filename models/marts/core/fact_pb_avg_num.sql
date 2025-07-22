{{ config(materialized='table') }}

SELECT
    category,
    avgreview,
    numofreviews,
    goodsname,
    createdat

FROM {{ ref('stg_pb_product_table') }}
