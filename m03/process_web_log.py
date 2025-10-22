#!/usr/bin/env python3
"""
Apache Airflow DAG for processing web server logs
This DAG extracts data from web logs, transforms it, and loads it into a file
"""

from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.operators.python_operator import PythonOperator
import re
import os

# Default arguments for the DAG
default_args = {
    'owner': 'diaa',
    'depends_on_past': False,
    'start_date': datetime(2024, 1, 1),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Define the DAG
dag = DAG(
    'process_web_log',
    default_args=default_args,
    description='A DAG to process web server logs',
    schedule_interval=timedelta(days=1),
    catchup=False,
    tags=['web_logs', 'etl'],
)

def extract_data():
    """Extract IP addresses and dates from web log file"""
    input_file = '/home/project/airflow/dags/accesslog.txt'
    output_file = '/home/project/airflow/dags/extracted_data.txt'
    
    # Read the access log file
    with open(input_file, 'r') as f:
        lines = f.readlines()
    
    extracted_data = []
    
    for line in lines:
        # Extract IP address (first field)
        ip_match = re.match(r'^(\d+\.\d+\.\d+\.\d+)', line.strip())
        
        # Extract timestamp (field in square brackets)
        timestamp_match = re.search(r'\[([^\]]+)\]', line)
        
        if ip_match and timestamp_match:
            ip_address = ip_match.group(1)
            timestamp = timestamp_match.group(1)
            extracted_data.append(f"{ip_address},{timestamp}")
    
    # Write extracted data to file
    with open(output_file, 'w') as f:
        for data in extracted_data:
            f.write(data + '\n')
    
    print(f"Extracted {len(extracted_data)} records to {output_file}")

def transform_data():
    """Transform the extracted data - convert timestamp format and bytes to MB"""
    input_file = '/home/project/airflow/dags/extracted_data.txt'
    output_file = '/home/project/airflow/dags/transformed_data.txt'
    
    # Read extracted data
    with open(input_file, 'r') as f:
        lines = f.readlines()
    
    transformed_data = []
    
    for line in lines:
        if line.strip():
            parts = line.strip().split(',')
            if len(parts) >= 2:
                ip_address = parts[0]
                timestamp = parts[1]
                
                # Transform timestamp from "dd/MMM/yyyy:HH:mm:ss +0000" to "yyyy-mm-dd HH:mm:ss"
                try:
                    # Parse the original timestamp
                    dt = datetime.strptime(timestamp.split(' ')[0], '%d/%b/%Y:%H:%M:%S')
                    # Format to new format
                    new_timestamp = dt.strftime('%Y-%m-%d %H:%M:%S')
                    transformed_data.append(f"{ip_address},{new_timestamp}")
                except ValueError:
                    # If parsing fails, keep original
                    transformed_data.append(line.strip())
    
    # Write transformed data to file
    with open(output_file, 'w') as f:
        for data in transformed_data:
            f.write(data + '\n')
    
    print(f"Transformed {len(transformed_data)} records to {output_file}")

def load_data():
    """Load the transformed data into the final destination"""
    input_file = '/home/project/airflow/dags/transformed_data.txt'
    output_file = '/home/project/airflow/dags/weblog_processed.txt'
    
    # Read transformed data
    with open(input_file, 'r') as f:
        data = f.read()
    
    # Write to final destination with header
    with open(output_file, 'w') as f:
        f.write("IP_Address,Timestamp\n")
        f.write(data)
    
    print(f"Loaded data to {output_file}")

# Define tasks
extract_data_task = PythonOperator(
    task_id='extract_data',
    python_callable=extract_data,
    dag=dag,
)

transform_data_task = PythonOperator(
    task_id='transform_data',
    python_callable=transform_data,
    dag=dag,
)

load_data_task = PythonOperator(
    task_id='load_data',
    python_callable=load_data,
    dag=dag,
)

# Archive the original file
archive_log_task = BashOperator(
    task_id='archive_log',
    bash_command='tar -czf /home/project/airflow/dags/accesslog_{{ ds }}.tar.gz /home/project/airflow/dags/accesslog.txt',
    dag=dag,
)

# Define task dependencies (pipeline)
extract_data_task >> transform_data_task >> load_data_task >> archive_log_task