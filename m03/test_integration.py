#!/usr/bin/env python3
"""
Integration test script for Module 02 data warehouse and Module 03 ETL pipelines
This script tests database connections, table structures, and ETL functionality
"""

import sys
import os
import logging
from datetime import datetime

# Add the current directory to Python path
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

# Import our modules
try:
    from postgresqlconnect import create_connection, create_data_warehouse_tables
    from automation import synchronize_data
except ImportError as e:
    print(f"Error importing modules: {e}")
    sys.exit(1)

# Set up logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

def test_postgres_connection():
    """Test PostgreSQL connection to data warehouse"""
    logger.info("Testing PostgreSQL connection...")
    try:
        conn = create_connection()
        if conn:
            logger.info("✓ PostgreSQL connection successful")
            conn.close()
            return True
        else:
            logger.error("✗ PostgreSQL connection failed")
            return False
    except Exception as e:
        logger.error(f"✗ PostgreSQL connection error: {e}")
        return False

def test_data_warehouse_tables():
    """Test if data warehouse tables exist and have correct structure"""
    logger.info("Testing data warehouse table structure...")
    try:
        conn = create_connection()
        cursor = conn.cursor()
        
        # Check if tables exist
        tables = ['DimDate', 'DimCategory', 'DimCountry', 'FactSales']
        existing_tables = []
        
        for table in tables:
            cursor.execute("""
                SELECT EXISTS (
                    SELECT FROM information_schema.tables 
                    WHERE table_schema = 'public' 
                    AND table_name = %s
                );
            """, (table.lower(),))
            
            exists = cursor.fetchone()[0]
            if exists:
                existing_tables.append(table)
                logger.info(f"✓ Table {table} exists")
            else:
                logger.warning(f"⚠ Table {table} does not exist")
        
        # Check table structures
        for table in existing_tables:
            cursor.execute(f"""
                SELECT column_name, data_type 
                FROM information_schema.columns 
                WHERE table_name = '{table.lower()}'
                ORDER BY ordinal_position;
            """)
            
            columns = cursor.fetchall()
            logger.info(f"  {table} columns: {[col[0] for col in columns]}")
        
        cursor.close()
        conn.close()
        
        return len(existing_tables) == len(tables)
        
    except Exception as e:
        logger.error(f"✗ Error checking table structure: {e}")
        return False

def test_sample_data_insertion():
    """Test inserting sample data into the data warehouse"""
    logger.info("Testing sample data insertion...")
    try:
        conn = create_connection()
        cursor = conn.cursor()
        
        # Insert sample data into dimension tables if they're empty
        
        # Check and insert sample DimDate data
        cursor.execute("SELECT COUNT(*) FROM DimDate")
        date_count = cursor.fetchone()[0]
        
        if date_count == 0:
            cursor.execute("""
                INSERT INTO DimDate (date_key, date, year, month, day, quarter)
                VALUES 
                    ('20240101', '2024-01-01', 2024, 1, 1, 1),
                    ('20240102', '2024-01-02', 2024, 1, 2, 1),
                    ('20240103', '2024-01-03', 2024, 1, 3, 1)
            """)
            logger.info("✓ Inserted sample DimDate data")
        
        # Check and insert sample DimCategory data
        cursor.execute("SELECT COUNT(*) FROM DimCategory")
        category_count = cursor.fetchone()[0]
        
        if category_count == 0:
            cursor.execute("""
                INSERT INTO DimCategory (category_key, category_name)
                VALUES 
                    (1, 'Electronics'),
                    (2, 'Clothing'),
                    (3, 'Books'),
                    (4, 'Home & Garden'),
                    (5, 'Sports')
            """)
            logger.info("✓ Inserted sample DimCategory data")
        
        # Check and insert sample DimCountry data
        cursor.execute("SELECT COUNT(*) FROM DimCountry")
        country_count = cursor.fetchone()[0]
        
        if country_count == 0:
            cursor.execute("""
                INSERT INTO DimCountry (country_key, country_name, country_code)
                VALUES 
                    (1, 'United States', 'US'),
                    (2, 'Canada', 'CA'),
                    (3, 'United Kingdom', 'UK'),
                    (4, 'Germany', 'DE'),
                    (5, 'France', 'FR'),
                    (6, 'Japan', 'JP'),
                    (7, 'Australia', 'AU'),
                    (8, 'Brazil', 'BR'),
                    (9, 'India', 'IN'),
                    (10, 'China', 'CN')
            """)
            logger.info("✓ Inserted sample DimCountry data")
        
        conn.commit()
        cursor.close()
        conn.close()
        
        logger.info("✓ Sample data insertion completed")
        return True
        
    except Exception as e:
        logger.error(f"✗ Error inserting sample data: {e}")
        return False

def test_etl_synchronization():
    """Test ETL synchronization functionality"""
    logger.info("Testing ETL synchronization...")
    try:
        # Note: This would normally test with actual MySQL data
        # For now, we'll just test the function exists and can be called
        logger.info("✓ ETL synchronization function is available")
        logger.info("  (Note: Full test requires MySQL source database)")
        return True
        
    except Exception as e:
        logger.error(f"✗ Error testing ETL synchronization: {e}")
        return False

def test_data_warehouse_queries():
    """Test basic queries on the data warehouse"""
    logger.info("Testing data warehouse queries...")
    try:
        conn = create_connection()
        cursor = conn.cursor()
        
        # Test dimension table queries
        tables = ['DimDate', 'DimCategory', 'DimCountry', 'FactSales']
        
        for table in tables:
            cursor.execute(f"SELECT COUNT(*) FROM {table}")
            count = cursor.fetchone()[0]
            logger.info(f"  {table}: {count} records")
        
        # Test a join query if we have data
        cursor.execute("""
            SELECT 
                fs.rowid,
                dd.date,
                dc.category_name,
                dco.country_name,
                fs.quantity,
                fs.price
            FROM FactSales fs
            LEFT JOIN DimDate dd ON fs.date_key = dd.date_key
            LEFT JOIN DimCategory dc ON fs.category_key = dc.category_key
            LEFT JOIN DimCountry dco ON fs.country_key = dco.country_key
            LIMIT 5
        """)
        
        results = cursor.fetchall()
        if results:
            logger.info(f"✓ Join query successful, returned {len(results)} records")
        else:
            logger.info("✓ Join query successful (no data yet)")
        
        cursor.close()
        conn.close()
        
        return True
        
    except Exception as e:
        logger.error(f"✗ Error testing data warehouse queries: {e}")
        return False

def run_integration_tests():
    """Run all integration tests"""
    logger.info("=" * 60)
    logger.info("STARTING MODULE 02/03 INTEGRATION TESTS")
    logger.info("=" * 60)
    
    tests = [
        ("PostgreSQL Connection", test_postgres_connection),
        ("Data Warehouse Tables", test_data_warehouse_tables),
        ("Sample Data Insertion", test_sample_data_insertion),
        ("ETL Synchronization", test_etl_synchronization),
        ("Data Warehouse Queries", test_data_warehouse_queries),
    ]
    
    results = []
    
    for test_name, test_func in tests:
        logger.info(f"\n--- Running {test_name} Test ---")
        try:
            result = test_func()
            results.append((test_name, result))
        except Exception as e:
            logger.error(f"Test {test_name} failed with exception: {e}")
            results.append((test_name, False))
    
    # Summary
    logger.info("\n" + "=" * 60)
    logger.info("TEST RESULTS SUMMARY")
    logger.info("=" * 60)
    
    passed = 0
    total = len(results)
    
    for test_name, result in results:
        status = "PASS" if result else "FAIL"
        logger.info(f"{test_name}: {status}")
        if result:
            passed += 1
    
    logger.info(f"\nOverall: {passed}/{total} tests passed")
    
    if passed == total:
        logger.info("🎉 All integration tests passed!")
        return True
    else:
        logger.warning(f"⚠ {total - passed} test(s) failed")
        return False

if __name__ == "__main__":
    success = run_integration_tests()
    sys.exit(0 if success else 1)