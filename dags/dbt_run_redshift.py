from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

default_args = {'start_date': datetime(2024, 1, 1)}

with DAG('dbt_run_redshift',
         schedule_interval=None,
         catchup=False,
         default_args=default_args) as dag:

    dbt_run = BashOperator(
        task_id='dbt_run',
        bash_command='cd /opt/airflow/dbt/dbt_project && dbt run --profiles-dir /opt/airflow/dbt'
    )
