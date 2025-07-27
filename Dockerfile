FROM apache/airflow:2.8.1

USER airflow

# dbt-core 및 redshift adapter 설치
RUN pip install dbt-core dbt-postgres dbt-redshift

USER airflow