# Technical Documentation - Module 02

## ETL Implementation Summary

### Database Connections
- **MySQL Source**: Configured connection to MySQL database containing sales data
- **PostgreSQL Target**: Configured connection to PostgreSQL data warehouse

### ETL Functions Implemented

#### 1. get_last_rowid()
- **Purpose**: Retrieves the maximum rowid from PostgreSQL sales_data table
- **Implementation**: Uses `SELECT MAX(rowid) FROM sales_data` query
- **Returns**: Integer representing the last synchronized record ID

#### 2. get_latest_records(last_rowid)
- **Purpose**: Fetches new records from MySQL that haven't been synchronized
- **Implementation**: Uses `SELECT * FROM sales_data WHERE rowid > %s` query
- **Parameters**: last_rowid - the last synchronized record ID
- **Returns**: List of tuples containing new records

#### 3. insert_records(records)
- **Purpose**: Inserts new records into PostgreSQL data warehouse
- **Implementation**: Uses parameterized INSERT statements for data integrity
- **Parameters**: records - list of tuples to insert
- **Features**: Batch processing for efficiency

### Data Synchronization Process
1. Connect to both MySQL and PostgreSQL databases
2. Get the last synchronized rowid from PostgreSQL
3. Fetch new records from MySQL where rowid > last_rowid
4. Insert new records into PostgreSQL
5. Close database connections

## Apache Airflow DAG Implementation

### DAG Configuration
- **DAG Name**: process_web_log
- **Owner**: diaa
- **Schedule**: Daily execution
- **Start Date**: 2024-01-01
- **Retry Policy**: 1 retry with 5-minute delay

### Task Pipeline

#### 1. extract_data
- **Type**: PythonOperator
- **Function**: Extracts IP addresses and timestamps from web log file
- **Input**: accesslog.txt
- **Output**: extracted_data.txt
- **Method**: Regular expressions to parse log entries

#### 2. transform_data
- **Type**: PythonOperator
- **Function**: Transforms timestamp format
- **Input**: extracted_data.txt
- **Output**: transformed_data.txt
- **Transformation**: Converts "dd/MMM/yyyy:HH:mm:ss +0000" to "yyyy-mm-dd HH:mm:ss"

#### 3. load_data
- **Type**: PythonOperator
- **Function**: Loads processed data to final destination
- **Input**: transformed_data.txt
- **Output**: weblog_processed.txt
- **Features**: Adds CSV header for structured data

#### 4. archive_log
- **Type**: BashOperator
- **Function**: Archives the original log file
- **Command**: `tar -czf accesslog_{{ ds }}.tar.gz accesslog.txt`
- **Purpose**: Data retention and cleanup

### Task Dependencies
```
extract_data_task >> transform_data_task >> load_data_task >> archive_log_task
```

## Technical Commands Used

### For Data Extraction
The extract_data function uses Python's `re` module with regular expressions:
- IP Address extraction: `r'^(\d+\.\d+\.\d+\.\d+)'`
- Timestamp extraction: `r'\[([^\]]+)\]'`

### For DAG Deployment
Standard Airflow deployment process:
1. Copy DAG file to Airflow dags directory
2. Verify DAG appears in Airflow UI
3. Unpause DAG for execution
4. Monitor DAG runs and task instances

## Files Generated

### ETL Screenshots
- get_last_rowid.jpg: Function testing screenshot
- get_latest_records.jpg: Record retrieval screenshot
- insert_records.jpg: Data insertion screenshot
- synchronization.jpg: Complete ETL process screenshot

### Airflow Screenshots
- dag_args.jpg: DAG arguments definition
- dag_definition.jpg: Task definitions
- extract_data.jpg: Extract function implementation
- transform_data.jpg: Transform function implementation
- load_data.jpg: Load function implementation
- pipeline.jpg: Task pipeline definition
- submit_dag.jpg: DAG submission process
- unpause_dag.jpg: DAG activation
- dag_runs.jpg: DAG execution history

## Best Practices Implemented

### ETL
- Parameterized queries to prevent SQL injection
- Proper connection management with try/except blocks
- Batch processing for efficiency
- Clear error handling and logging

### Airflow
- Modular task design for maintainability
- Proper task dependencies for data flow
- Error handling and retry mechanisms
- Meaningful task and DAG naming conventions
- Documentation strings for all functions