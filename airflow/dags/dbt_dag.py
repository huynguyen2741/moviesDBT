from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.empty import EmptyOperator
from airflow.utils.task_group import TaskGroup

PROJECT_DIR = '/mnt/c/project/DBT/moviesDBT/dbt'
PROFILE_DIR = '/mnt/c/Users/huyng/.dbt'

default_args = {
    'owner':'huy',
    'retries': 5,
    'retry_delay':timedelta(minutes=5)
}
with DAG (
    default_args = default_args,
    dag_id = 'dbt_dag1',
    start_date = datetime(2025,8,6),
    schedule = '@daily',
    catchup = False
) as dag :
    start = EmptyOperator (task_id='start')

    with TaskGroup(group_id='dbt_tasks') as dbt_group:
        dbt_debug = BashOperator (
            task_id = 'dbt_debug',
            bash_command = f'dbt debug --project-dir {PROJECT_DIR} --profiles-dir {PROFILE_DIR}'
        )

        dbt_run = BashOperator (
            task_id = 'dbt_run',
            bash_command = f'dbt run --project-dir {PROJECT_DIR} --profiles-dir {PROFILE_DIR}'
        )

        dbt_test = BashOperator (
            task_id = 'dbt_test',
            bash_command = f'dbt test --project-dir {PROJECT_DIR} --profiles-dir {PROFILE_DIR}'
        )

        dbt_debug >> dbt_run >> dbt_test

    end = EmptyOperator (task_id='end')

    start >> dbt_group >> end