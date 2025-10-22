# Technical Documentation - Module 03

## ETL Implementation Summary

## Integration with Module 02 Data Warehouse

This module implements ETL processes that integrate with the SoftCart.com data warehouse established in Module 02, transforming operational data into a star schema design for analytical reporting.

## Database Connections

### MySQL (Source Database)
- **Host**: localhost
- **Database**: sales
- **Table**: sales_data
- **Purpose**: Operational source system for transactional sales data
- **Schema**: Simple transactional structure (rowid, product_id, customer_id, quantity, price, timestamp)

### PostgreSQL (Target Data Warehouse)  
- **Host**: localhost
- **Database**: sales_new
- **Schema**: SoftCart.com star schema with dimension and fact tables
- **Purpose**: Analytical data warehouse for business intelligence and reporting
- **Tables**:
  - `DimDate` - Date dimension with hierarchical time attributes
  - `DimCategory` - Product category dimension
  - `DimCountry` - Geographic dimension for customer locations  
  - `FactSales` - Central fact table containing sales metrics and foreign keys

### ETL Functions Implemented

#### 1. get_last_rowid()
- **Purpose**: Retrieves the last processed record ID from FactSales table in data warehouse
- **Implementation**: Uses `SELECT MAX(rowid) FROM sales_data` query
- **Returns**: Integer representing the last synchronized record ID
- **Features**: Enables incremental data loading from operational systems and prevents duplicate data processing

#### 2. get_latest_records(last_rowid)
- **Purpose**: Extracts new sales records from MySQL operational database since last processed ID
- **Implementation**: Uses `SELECT * FROM sales_data WHERE rowid > %s` query
- **Parameters**: last_rowid - the last synchronized record ID
- **Returns**: Structured data ready for dimensional transformation
- **Features**: Implements efficient incremental extraction strategy

#### 3. lookup_dimension_keys(record)
- **Purpose**: Transforms operational data to match star schema requirements
- **Implementation**: Maps product categories to DimCategory keys, converts timestamps to DimDate keys
- **Features**: Handles geographic data mapping to DimCountry keys

#### 4. insert_records(records)
- **Purpose**: Loads transformed records into FactSales table in data warehouse
- **Implementation**: Uses parameterized INSERT statements for data integrity
- **Parameters**: records - list of tuples to insert
- **Features**: Maintains referential integrity with dimension tables, batch processing for optimal performance, comprehensive error handling and transaction rollback

### Data Synchronization Process

1. **Connection Establishment**
   - Establish connections to MySQL operational database and PostgreSQL data warehouse
   - Verify connectivity and validate star schema table structure
   - Handle connection errors with comprehensive logging

2. **Incremental Data Identification**
   - Query FactSales table to find the last synchronized record ID
   - Use this ID to identify new sales transactions in MySQL source
   - Implement efficient change data capture strategy

3. **Data Transformation & Dimensional Mapping**
   - Extract new records from MySQL operational database
   - Transform transactional data to fit star schema design:
     - Map timestamps to DimDate dimension keys
     - Resolve product categories to DimCategory keys  
     - Map customer locations to DimCountry keys
   - Calculate derived metrics and business measures

4. **Data Loading & Validation**
   - Load transformed records into FactSales table
   - Maintain referential integrity with dimension tables
   - Validate data quality and business rules
   - Generate summary statistics and load reports

5. **Error Handling & Monitoring**
   - Comprehensive error handling throughout the ETL pipeline
   - Detailed logging for monitoring and debugging
   - Transaction rollback capabilities for data integrity
   - Data warehouse validation and quality checks

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