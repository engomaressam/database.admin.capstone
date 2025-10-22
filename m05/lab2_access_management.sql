-- MODULE 05 - LAB 2: ACCESS MANAGEMENT AND DATABASE SECURITY
-- User Creation and Privilege Management
-- ============================================================================

-- STEP 1: Create Database Admin User (db_admin)
-- =============================================

-- Create admin user with full privileges
CREATE USER 'db_admin'@'localhost' IDENTIFIED BY 'AdminPass123!';

-- Grant all privileges on sales database to admin user
GRANT ALL PRIVILEGES ON sales.* TO 'db_admin'@'localhost';

-- Grant additional structural privileges for database administration
GRANT CREATE, DROP, ALTER, INDEX, REFERENCES ON sales.* TO 'db_admin'@'localhost';

-- Grant global privileges for administrative tasks
GRANT RELOAD, PROCESS, SHOW DATABASES ON *.* TO 'db_admin'@'localhost';

-- STEP 2: Create Analytics User (db_analyst)
-- ==========================================

-- Create analyst user for data analysis
CREATE USER 'db_analyst'@'localhost' IDENTIFIED BY 'AnalystPass123!';

-- Grant data privileges for analysis
GRANT SELECT, INSERT, UPDATE ON sales.* TO 'db_analyst'@'localhost';

-- Grant structural privileges needed for analysis
GRANT CREATE TEMPORARY TABLES ON sales.* TO 'db_analyst'@'localhost';
GRANT CREATE VIEW ON sales.* TO 'db_analyst'@'localhost';

-- Note: Analyst should NOT have CREATE ROUTINE privilege (as per quiz question)
-- Grant CREATE ROUTINE ON sales.* TO 'db_analyst'@'localhost'; -- NOT GRANTED

-- STEP 3: Create Reporting User (db_reporter)
-- ===========================================

-- Create reporter user for read-only reporting
CREATE USER 'db_reporter'@'localhost' IDENTIFIED BY 'ReporterPass123!';

-- Grant only SELECT privilege for reporting (read-only access)
GRANT SELECT ON sales.* TO 'db_reporter'@'localhost';

-- Note: Reporter should NOT have INSERT, UPDATE, DELETE privileges
-- These are intentionally NOT granted for security

-- STEP 4: Create External User (db_external)
-- ==========================================

-- Create external user with limited access
CREATE USER 'db_external'@'localhost' IDENTIFIED BY 'ExternalPass123!';

-- Grant minimal privileges for external access
GRANT SELECT ON sales.DimCountry TO 'db_external'@'localhost';
GRANT SELECT ON sales.DimCategory TO 'db_external'@'localhost';

-- Note: External user has very limited access - only to dimension tables

-- STEP 5: Apply All Privilege Changes
-- ===================================

-- Flush privileges to ensure all changes take effect
FLUSH PRIVILEGES;

-- STEP 6: Verify User Creation and Privileges
-- ===========================================

SELECT 'USER VERIFICATION' as Info;

-- Show all created users
SELECT 
    User,
    Host,
    account_locked,
    password_expired
FROM mysql.user 
WHERE User IN ('db_admin', 'db_analyst', 'db_reporter', 'db_external');

-- STEP 7: Display Privilege Information
-- =====================================

-- Show privileges for db_admin
SELECT 'DB_ADMIN PRIVILEGES' as User_Type;
SHOW GRANTS FOR 'db_admin'@'localhost';

-- Show privileges for db_analyst
SELECT 'DB_ANALYST PRIVILEGES' as User_Type;
SHOW GRANTS FOR 'db_analyst'@'localhost';

-- Show privileges for db_reporter
SELECT 'DB_REPORTER PRIVILEGES' as User_Type;
SHOW GRANTS FOR 'db_reporter'@'localhost';

-- Show privileges for db_external
SELECT 'DB_EXTERNAL PRIVILEGES' as User_Type;
SHOW GRANTS FOR 'db_external'@'localhost';

-- STEP 8: Test User Access (Verification Queries)
-- ===============================================

-- Note: These queries would need to be run by connecting as each user
-- They are provided here for reference and testing

/*
-- Test db_admin access (should work - all privileges)
-- mysql -u db_admin -p
-- USE sales;
-- SELECT COUNT(*) FROM FactSales;
-- CREATE TABLE test_admin (id INT);
-- DROP TABLE test_admin;

-- Test db_analyst access (should work - data manipulation)
-- mysql -u db_analyst -p
-- USE sales;
-- SELECT COUNT(*) FROM FactSales;
-- INSERT INTO DimCountry VALUES (999, 'Test Country');
-- CREATE TEMPORARY TABLE temp_analysis (id INT, value DECIMAL(10,2));

-- Test db_reporter access (should work - read only)
-- mysql -u db_reporter -p
-- USE sales;
-- SELECT COUNT(*) FROM FactSales;
-- SELECT * FROM DimCountry LIMIT 5;
-- INSERT INTO DimCountry VALUES (998, 'Test'); -- This should FAIL

-- Test db_external access (should work - limited read)
-- mysql -u db_external -p
-- USE sales;
-- SELECT * FROM DimCountry LIMIT 5;
-- SELECT * FROM DimCategory LIMIT 5;
-- SELECT * FROM FactSales LIMIT 5; -- This should FAIL
*/

-- STEP 9: Security Summary
-- ========================

SELECT 'ACCESS MANAGEMENT SUMMARY' as Summary;

SELECT 
    'db_admin' as Username,
    'Full administrative access to sales database' as Access_Level,
    'ALL PRIVILEGES' as Key_Privileges
UNION ALL
SELECT 
    'db_analyst',
    'Data analysis with structural privileges',
    'SELECT, INSERT, UPDATE, CREATE TEMPORARY TABLES, CREATE VIEW'
UNION ALL
SELECT 
    'db_reporter',
    'Read-only access for reporting',
    'SELECT only'
UNION ALL
SELECT 
    'db_external',
    'Limited read access to dimension tables only',
    'SELECT on DimCountry, DimCategory only';

-- Show database and table information
SELECT 'DATABASE STRUCTURE' as Info;
SHOW TABLES FROM sales;

-- Show table sizes for reference
SELECT 
    TABLE_NAME,
    TABLE_ROWS,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) as Size_MB
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'sales'
ORDER BY Size_MB DESC;