-- models/marts/core/fact_rank_flag_count.sql

{{ config(materialized='table') }}

WITH
    base_data AS (
        SELECT
            CAST(createdat AS DATE) AS created_date,
            CASE
                WHEN flagname IS NULL OR TRIM(flagname) = '' THEN 'flag 없음'
                ELSE flagname
            END AS flagname
        FROM dev.dev.stg_rank_flag_table
    ),
    unique_flagnames AS (
        SELECT DISTINCT flagname FROM base_data
    ),
    unique_dates AS (
        SELECT DISTINCT created_date FROM base_data
    ),
    date_flag_matrix AS (
        SELECT d.created_date, f.flagname
        FROM unique_dates d
        CROSS JOIN unique_flagnames f
    ),
    flag_counts AS (
        SELECT created_date, flagname, COUNT(*) AS flag_count
        FROM base_data
        GROUP BY created_date, flagname
    )

SELECT
    dfm.created_date,
    dfm.flagname,
    COALESCE(fc.flag_count, 0) AS flag_count
FROM
    date_flag_matrix dfm
    LEFT JOIN flag_counts fc
    ON dfm.created_date = fc.created_date
    AND dfm.flagname = fc.flagname
ORDER BY dfm.created_date, dfm.flagname
