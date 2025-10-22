# This program requires the python module psycopg2 to be installed.
# Install it using the below command
# python3 -m pip install psycopg2

import psycopg2
import logging

# Set up logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

# Connection details for Module 02 Data Warehouse
dsn_hostname = 'localhost'  # Replace with your postgres hostname
dsn_user = 'postgres'       # PostgreSQL username
dsn_pwd = 'password123'     # Replace with your postgres password
dsn_port = "5432"           # PostgreSQL port
dsn_database = "staging"    # Module 02 data warehouse database

def create_connection():
    """Create and return a PostgreSQL connection to the data warehouse"""
    try:
        conn = psycopg2.connect(
            database=dsn_database, 
            user=dsn_user,
            password=dsn_pwd,
            host=dsn_hostname, 
            port=dsn_port
        )
        logger.info(f"Successfully connected to PostgreSQL database: {dsn_database}")
        return conn
    except Exception as e:
        logger.error(f"Error connecting to PostgreSQL: {e}")
        raise

def create_data_warehouse_tables():
    """Create the data warehouse tables if they don't exist (Module 02 schema)"""
    try:
        conn = create_connection()
        cursor = conn.cursor()
        
        # Create DimDate table
        create_dimdate_sql = """
        CREATE TABLE IF NOT EXISTS DimDate (
            dateid INTEGER PRIMARY KEY,
            date DATE NOT NULL,
            year INTEGER NOT NULL,
            quarter INTEGER NOT NULL,
            quartername VARCHAR(2) NOT NULL,
            month INTEGER NOT NULL,
            monthname VARCHAR(10) NOT NULL,
            day INTEGER NOT NULL,
            weekday INTEGER NOT NULL,
            weekdayname VARCHAR(10) NOT NULL
        )
        """
        
        # Create DimCategory table
        create_dimcategory_sql = """
        CREATE TABLE IF NOT EXISTS DimCategory (
            categoryid INTEGER PRIMARY KEY,
            category VARCHAR(50) NOT NULL
        )
        """
        
        # Create DimCountry table
        create_dimcountry_sql = """
        CREATE TABLE IF NOT EXISTS DimCountry (
            countryid INTEGER PRIMARY KEY,
            country VARCHAR(50) NOT NULL
        )
        """
        
        # Create FactSales table
        create_factsales_sql = """
        CREATE TABLE IF NOT EXISTS FactSales (
            rowid INTEGER PRIMARY KEY,
            product_id INTEGER NOT NULL,
            customer_id INTEGER NOT NULL,
            quantity INTEGER NOT NULL,
            price DECIMAL(10,2) NOT NULL,
            timestamp TIMESTAMP NOT NULL,
            date_key INTEGER,
            category_key INTEGER,
            country_key INTEGER,
            FOREIGN KEY (date_key) REFERENCES DimDate(dateid),
            FOREIGN KEY (category_key) REFERENCES DimCategory(categoryid),
            FOREIGN KEY (country_key) REFERENCES DimCountry(countryid)
        )
        """
        
        # Execute table creation
        cursor.execute(create_dimdate_sql)
        cursor.execute(create_dimcategory_sql)
        cursor.execute(create_dimcountry_sql)
        cursor.execute(create_factsales_sql)
        
        conn.commit()
        logger.info("Data warehouse tables created successfully")
        
        cursor.close()
        conn.close()
        
    except Exception as e:
        logger.error(f"Error creating data warehouse tables: {e}")
        raise

def test_connection():
    """Test the database connection and display table information"""
    try:
        conn = create_connection()
        cursor = conn.cursor()
        
        # Test query to show existing tables
        cursor.execute("""
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema = 'public'
            ORDER BY table_name
        """)
        
        tables = cursor.fetchall()
        logger.info("Existing tables in the data warehouse:")
        for table in tables:
            logger.info(f"  - {table[0]}")
        
        cursor.close()
        conn.close()
        
    except Exception as e:
        logger.error(f"Error testing connection: {e}")
        raise

# Main execution for testing
if __name__ == "__main__":
    try:
        # Test connection
        test_connection()
        
        # Create tables if needed
        create_data_warehouse_tables()
        
        logger.info("PostgreSQL data warehouse setup completed successfully")
        
    except Exception as e:
        logger.error(f"Setup failed: {e}")


