{{ config(materialized='table') }}

SELECT *
FROM {{ ref('stg_top1_product_persistence') }}