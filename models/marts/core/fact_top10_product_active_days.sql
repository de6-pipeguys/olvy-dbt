{{ config(materialized='table') }}

SELECT *
FROM {{ ref('stg_top10_product_active_days') }}