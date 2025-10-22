#!/usr/bin/env python3
"""
Apache Airflow DAG for ETL processing and data warehouse synchronization
This DAG processes web logs and synchronizes data with Module 02 data warehouse
"""

from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.operators.python_operator import PythonOperator
import re
import os
import mysql.connector
import psycopg2
import logging

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

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
    'process_web_log_and_etl',
    default_args=default_args,
    description='A DAG to process web logs and synchronize with Module 02 data warehouse',
    schedule_interval=timedelta(days=1),
    catchup=False,
    tags=['web_logs', 'etl', 'data_warehouse'],
)

# Database connection configurations
mysql_config = {
    'user': 'root',
    'password': 'password123',
    'host': 'localhost',
    'database': 'sales'
}

postgres_config = {
    'host': 'localhost',
    'database': 'staging',  # Module 02 data warehouse
    'user': 'postgres',
    'password': 'password123',
    'port': '5432'
}

def extract_web_log_data():
    """Extract IP addresses and dates from web log file"""
    input_file = '/home/project/airflow/dags/accesslog.txt'
    output_file = '/home/project/airflow/dags/extracted_data.txt'
    
    try:
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
        
        logger.info(f"Extracted {len(extracted_data)} records to {output_file}")
        
    except Exception as e:
        logger.error(f"Error extracting web log data: {e}")
        raise

def transform_web_log_data():
    """Transform the extracted data - convert timestamp format"""
    input_file = '/home/project/airflow/dags/extracted_data.txt'
    output_file = '/home/project/airflow/dags/transformed_data.txt'
    
    try:
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
        
        logger.info(f"Transformed {len(transformed_data)} records to {output_file}")
        
    except Exception as e:
        logger.error(f"Error transforming web log data: {e}")
        raise

def load_web_log_data():
    """Load the transformed web log data into the final destination"""
    input_file = '/home/project/airflow/dags/transformed_data.txt'
    output_file = '/home/project/airflow/dags/weblog_processed.txt'
    
    try:
        # Read transformed data
        with open(input_file, 'r') as f:
            data = f.read()
        
        # Write to final destination with header
        with open(output_file, 'w') as f:
            f.write("IP_Address,Timestamp\n")
            f.write(data)
        
        logger.info(f"Loaded web log data to {output_file}")
        
    except Exception as e:
        logger.error(f"Error loading web log data: {e}")
        raise

def synchronize_sales_data():
    """Synchronize sales data from MySQL to PostgreSQL data warehouse"""
    try:
        # Connect to MySQL (source)
        mysql_conn = mysql.connector.connect(**mysql_config)
        mysql_cursor = mysql_conn.cursor()
        
        # Connect to PostgreSQL (data warehouse)
        postgres_conn = psycopg2.connect(**postgres_config)
        postgres_cursor = postgres_conn.cursor()
        
        # Get last processed rowid from FactSales
        postgres_cursor.execute("SELECT COALESCE(MAX(rowid), 0) FROM FactSales")
        last_rowid = postgres_cursor.fetchone()[0]
        
        # Get new records from MySQL
        mysql_cursor.execute("""
            SELECT rowid, product_id, customer_id, quantity, price, timestamp
            FROM sales_data 
            WHERE rowid > %s
            ORDER BY rowid
        """, (last_rowid,))
        
        new_records = mysql_cursor.fetchall()
        
        if new_records:
            # Insert new records into FactSales
            for record in new_records:
                rowid, product_id, customer_id, quantity, price, timestamp = record
                
                # Simple dimension key lookups (for demo purposes)
                date_key = timestamp.strftime('%Y%m%d') if timestamp else datetime.now().strftime('%Y%m%d')
                category_key = (product_id % 5) + 1
                country_key = (customer_id % 10) + 1
                
                postgres_cursor.execute("""
                    INSERT INTO FactSales (rowid, product_id, customer_id, quantity, price, timestamp, date_key, category_key, country_key)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
                """, (rowid, product_id, customer_id, quantity, price, timestamp, date_key, category_key, country_key))
            
            postgres_conn.commit()
            logger.info(f"Synchronized {len(new_records)} records to data warehouse")
        else:
            logger.info("No new records to synchronize")
        
        # Close connections
        mysql_cursor.close()
        mysql_conn.close()
        postgres_cursor.close()
        postgres_conn.close()
        
    except Exception as e:
        logger.error(f"Error synchronizing sales data: {e}")
        raise

def validate_data_warehouse():
    """Validate data warehouse integrity and generate summary statistics"""
    try:
        postgres_conn = psycopg2.connect(**postgres_config)
        postgres_cursor = postgres_conn.cursor()
        
        # Get record counts from each table
        tables = ['DimDate', 'DimCategory', 'DimCountry', 'FactSales']
        
        for table in tables:
            postgres_cursor.execute(f"SELECT COUNT(*) FROM {table}")
            count = postgres_cursor.fetchone()[0]
            logger.info(f"{table}: {count} records")
        
        # Get latest sales data summary
        postgres_cursor.execute("""
            SELECT 
                COUNT(*) as total_sales,
                SUM(quantity) as total_quantity,
                SUM(price * quantity) as total_revenue,
                MAX(timestamp) as latest_sale
            FROM FactSales
        """)
        
        summary = postgres_cursor.fetchone()
        logger.info(f"Sales Summary - Total Sales: {summary[0]}, Total Quantity: {summary[1]}, Total Revenue: {summary[2]}, Latest Sale: {summary[3]}")
        
        postgres_cursor.close()
        postgres_conn.close()
        
    except Exception as e:
        logger.error(f"Error validating data warehouse: {e}")
        raise

# Define tasks
extract_web_log_task = PythonOperator(
    task_id='extract_web_log_data',
    python_callable=extract_web_log_data,
    dag=dag,
)

transform_web_log_task = PythonOperator(
    task_id='transform_web_log_data',
    python_callable=transform_web_log_data,
    dag=dag,
)

load_web_log_task = PythonOperator(
    task_id='load_web_log_data',
    python_callable=load_web_log_data,
    dag=dag,
)

synchronize_sales_task = PythonOperator(
    task_id='synchronize_sales_data',
    python_callable=synchronize_sales_data,
    dag=dag,
)

validate_warehouse_task = PythonOperator(
    task_id='validate_data_warehouse',
    python_callable=validate_data_warehouse,
    dag=dag,
)

# Archive the original log file
archive_log_task = BashOperator(
    task_id='archive_log',
    bash_command='tar -czf /home/project/airflow/dags/accesslog_{{ ds }}.tar.gz /home/project/airflow/dags/accesslog.txt',
    dag=dag,
)

# Define task dependencies (pipeline)
# Web log processing pipeline
extract_web_log_task >> transform_web_log_task >> load_web_log_task

# Data warehouse synchronization pipeline (can run in parallel)
synchronize_sales_task >> validate_warehouse_task

# Archive after all processing is complete
[load_web_log_task, validate_warehouse_task] >> archive_log_task