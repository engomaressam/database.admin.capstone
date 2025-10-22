# Import libraries required for connecting to mysql
import mysql.connector

# Import libraries required for connecting to PostgreSql
import psycopg2

# Connection parameters for MySQL (staging data warehouse)
mysql_config = {
    'user': 'root',
    'password': 'password123',  # Replace with actual password
    'host': 'localhost',
    'database': 'sales'
}

# Connection parameters for PostgreSQL (production data warehouse)
postgres_config = {
    'host': 'localhost',
    'database': 'postgres',
    'user': 'postgres',
    'password': 'password123',  # Replace with actual password
    'port': '5432'
}

# Connect to MySQL
mysql_conn = mysql.connector.connect(**mysql_config)
mysql_cursor = mysql_conn.cursor()

# Connect to PostgreSQL
postgres_conn = psycopg2.connect(**postgres_config)
postgres_cursor = postgres_conn.cursor()

# Create sales_data table in PostgreSQL if it doesn't exist
create_table_sql = """
CREATE TABLE IF NOT EXISTS sales_data (
    rowid INTEGER PRIMARY KEY,
    product_id INTEGER NOT NULL,
    customer_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    price DECIMAL DEFAULT 0.0 NOT NULL,
    timestamp TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
)
"""
postgres_cursor.execute(create_table_sql)
postgres_conn.commit()

# Find out the last rowid from PostgreSQL data warehouse
# The function get_last_rowid must return the last rowid of the table sales_data on the PostgreSQL database.

def get_last_rowid():
    try:
        # Query to get the maximum rowid from sales_data table
        query = "SELECT MAX(rowid) FROM sales_data"
        postgres_cursor.execute(query)
        result = postgres_cursor.fetchone()
        
        # If table is empty, return 0
        if result[0] is None:
            return 0
        else:
            return result[0]
    except Exception as e:
        print(f"Error getting last rowid: {e}")
        return 0


last_row_id = get_last_rowid()
print("Last row id on production datawarehouse = ", last_row_id)

# List out all records in MySQL database with rowid greater than the one on the Data warehouse
# The function get_latest_records must return a list of all records that have a rowid greater than the last_row_id in the sales_data table in the sales database on the MySQL staging data warehouse.

def get_latest_records(rowid):
    try:
        # Query to get all records with rowid greater than the given rowid
        query = "SELECT rowid, product_id, customer_id, quantity FROM sales_data WHERE rowid > %s"
        mysql_cursor.execute(query, (rowid,))
        records = mysql_cursor.fetchall()
        return records
    except Exception as e:
        print(f"Error getting latest records: {e}")
        return []

new_records = get_latest_records(last_row_id)

print("New rows on staging datawarehouse = ", len(new_records))

# Insert the additional records from MySQL into PostgreSQL data warehouse.
# The function insert_records must insert all the records passed to it into the sales_data table in PostgreSQL database.

def insert_records(records):
    try:
        if records:
            # Insert query for PostgreSQL
            insert_query = """
            INSERT INTO sales_data (rowid, product_id, customer_id, quantity, price, timestamp) 
            VALUES (%s, %s, %s, %s, %s, CURRENT_TIMESTAMP)
            """
            
            # Prepare data for insertion (add default price of 0.0)
            insert_data = [(record[0], record[1], record[2], record[3], 0.0) for record in records]
            
            # Execute batch insert
            postgres_cursor.executemany(insert_query, insert_data)
            postgres_conn.commit()
            print(f"Successfully inserted {len(records)} records")
        else:
            print("No records to insert")
    except Exception as e:
        print(f"Error inserting records: {e}")
        postgres_conn.rollback()

insert_records(new_records)
print("New rows inserted into production datawarehouse = ", len(new_records))

# disconnect from mysql warehouse
mysql_cursor.close()
mysql_conn.close()

# disconnect from PostgreSQL data warehouse 
postgres_cursor.close()
postgres_conn.close()

# End of program