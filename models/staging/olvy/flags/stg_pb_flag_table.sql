-- models/staging/pb/stg_pb_flag_table.sql

{{ config(materialized='view') }}

SELECT *
FROM {{ source('preprocessed_data', 'pb_flag_table') }}
