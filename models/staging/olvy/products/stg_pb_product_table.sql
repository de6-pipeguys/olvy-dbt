-- models/staging/olvy/products/stg_pb_product_table.sql

{{ config(materialized='view') }}

SELECT *
FROM {{ source('preprocessed_data', 'pb_product_table') }}
