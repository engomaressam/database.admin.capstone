# Import libraries required for connecting to mysql
import mysql.connector

# Import libraries required for connecting to PostgreSql
import psycopg2
from datetime import datetime
import logging

# Set up logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

# Connection parameters for MySQL (OLTP source system)
mysql_config = {
    'user': 'root',
    'password': 'password123',  # Replace with actual password
    'host': 'localhost',
    'database': 'sales'
}

# Connection parameters for PostgreSQL (Data Warehouse - Module 02)
postgres_config = {
    'host': 'localhost',
    'database': 'staging',  # Module 02 data warehouse database
    'user': 'postgres',
    'password': 'password123',  # Replace with actual password
    'port': '5432'
}

def get_database_connections():
    """Establish connections to both MySQL and PostgreSQL databases"""
    try:
        # Connect to MySQL (source)
        mysql_conn = mysql.connector.connect(**mysql_config)
        mysql_cursor = mysql_conn.cursor()
        logger.info("Connected to MySQL source database")
        
        # Connect to PostgreSQL (data warehouse)
        postgres_conn = psycopg2.connect(**postgres_config)
        postgres_cursor = postgres_conn.cursor()
        logger.info("Connected to PostgreSQL data warehouse")
        
        return mysql_conn, mysql_cursor, postgres_conn, postgres_cursor
    except Exception as e:
        logger.error(f"Database connection error: {e}")
        raise

def get_last_rowid():
    """Get the last processed rowid from the FactSales table"""
    try:
        mysql_conn, mysql_cursor, postgres_conn, postgres_cursor = get_database_connections()
        
        # Query the FactSales table to get the maximum rowid
        postgres_cursor.execute("SELECT COALESCE(MAX(rowid), 0) FROM FactSales")
        last_rowid = postgres_cursor.fetchone()[0]
        
        # Close connections
        mysql_cursor.close()
        mysql_conn.close()
        postgres_cursor.close()
        postgres_conn.close()
        
        logger.info(f"Last processed rowid: {last_rowid}")
        return last_rowid
    except Exception as e:
        logger.error(f"Error getting last rowid: {e}")
        return 0

def get_latest_records(last_rowid):
    """Get new records from MySQL source that haven't been processed"""
    try:
        mysql_conn, mysql_cursor, postgres_conn, postgres_cursor = get_database_connections()
        
        # Query for new records from MySQL
        query = """
        SELECT rowid, product_id, customer_id, quantity, price, timestamp
        FROM sales_data 
        WHERE rowid > %s
        ORDER BY rowid
        """
        mysql_cursor.execute(query, (last_rowid,))
        records = mysql_cursor.fetchall()
        
        # Close connections
        mysql_cursor.close()
        mysql_conn.close()
        postgres_cursor.close()
        postgres_conn.close()
        
        logger.info(f"Retrieved {len(records)} new records from source")
        return records
    except Exception as e:
        logger.error(f"Error getting latest records: {e}")
        return []

def lookup_dimension_keys(postgres_cursor, records):
    """Lookup dimension keys for the fact table"""
    processed_records = []
    
    for record in records:
        rowid, product_id, customer_id, quantity, price, timestamp = record
        
        # For this example, we'll use simplified dimension lookups
        # In a real scenario, you'd lookup actual dimension keys
        
        # Date dimension lookup (simplified - using current date)
        date_key = timestamp.strftime('%Y%m%d') if timestamp else datetime.now().strftime('%Y%m%d')
        
        # Category dimension (simplified - using product_id modulo for demo)
        category_key = (product_id % 5) + 1  # Assuming 5 categories
        
        # Country dimension (simplified - using customer_id modulo for demo)
        country_key = (customer_id % 10) + 1  # Assuming 10 countries
        
        processed_record = {
            'rowid': rowid,
            'product_id': product_id,
            'customer_id': customer_id,
            'quantity': quantity,
            'price': price,
            'timestamp': timestamp,
            'date_key': date_key,
            'category_key': category_key,
            'country_key': country_key
        }
        processed_records.append(processed_record)
    
    return processed_records

def insert_records(records):
    """Insert new records into the FactSales table with proper dimension references"""
    if not records:
        logger.info("No records to insert")
        return
    
    try:
        mysql_conn, mysql_cursor, postgres_conn, postgres_cursor = get_database_connections()
        
        # Process records to get dimension keys
        processed_records = lookup_dimension_keys(postgres_cursor, records)
        
        # Insert into FactSales table
        insert_query = """
        INSERT INTO FactSales (rowid, product_id, customer_id, quantity, price, timestamp, date_key, category_key, country_key)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        
        for record in processed_records:
            postgres_cursor.execute(insert_query, (
                record['rowid'],
                record['product_id'],
                record['customer_id'],
                record['quantity'],
                record['price'],
                record['timestamp'],
                record['date_key'],
                record['category_key'],
                record['country_key']
            ))
        
        postgres_conn.commit()
        logger.info(f"Successfully inserted {len(processed_records)} records into FactSales")
        
        # Close connections
        mysql_cursor.close()
        mysql_conn.close()
        postgres_cursor.close()
        postgres_conn.close()
        
    except Exception as e:
        logger.error(f"Error inserting records: {e}")
        if 'postgres_conn' in locals():
            postgres_conn.rollback()
        raise

def synchronize_data():
    """Main ETL synchronization function"""
    try:
        logger.info("Starting ETL synchronization process")
        
        # Step 1: Get the last processed rowid
        last_rowid = get_last_rowid()
        
        # Step 2: Get new records from source
        new_records = get_latest_records(last_rowid)
        
        if not new_records:
            logger.info("No new records to process")
            return
        
        # Step 3: Insert records into data warehouse
        insert_records(new_records)
        
        logger.info("ETL synchronization completed successfully")
        
    except Exception as e:
        logger.error(f"ETL synchronization failed: {e}")
        raise

# Main execution
if __name__ == "__main__":
    synchronize_data()