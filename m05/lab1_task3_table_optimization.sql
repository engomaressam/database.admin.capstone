-- MODULE 05 - LAB 1 - TASK 3: TABLE OPTIMIZATION
-- Database and Query Optimization
-- ============================================================================

USE sales;

-- STEP 1: Analyze Current Table Status
-- ====================================

SELECT 'BEFORE OPTIMIZATION - Table Analysis' as Analysis_Phase;

-- Show current table status for all tables
SHOW TABLE STATUS FROM sales;

-- Detailed analysis of FactSales table
SELECT 'FactSales Table Analysis' as Info;
SHOW TABLE STATUS LIKE 'FactSales';

-- Check table fragmentation and optimization needs
SELECT 
    TABLE_NAME,
    ENGINE,
    TABLE_ROWS,
    DATA_LENGTH,
    INDEX_LENGTH,
    DATA_FREE,
    AUTO_INCREMENT,
    CREATE_TIME,
    UPDATE_TIME,
    CHECK_TIME,
    TABLE_COLLATION
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'sales'
ORDER BY TABLE_NAME;

-- STEP 2: Check for Fragmentation
-- ===============================

SELECT 'Table Fragmentation Analysis' as Info;

-- Calculate fragmentation percentage
SELECT 
    TABLE_NAME,
    ROUND(DATA_FREE / (DATA_LENGTH + INDEX_LENGTH + DATA_FREE) * 100, 2) as Fragmentation_Percent,
    ROUND(DATA_FREE / 1024 / 1024, 2) as Free_Space_MB,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) as Used_Space_MB
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'sales' 
AND DATA_FREE > 0;

-- STEP 3: Optimize Tables
-- ======================

SELECT 'OPTIMIZATION PHASE - Running OPTIMIZE TABLE' as Phase;

-- Optimize FactSales table (main fact table)
OPTIMIZE TABLE FactSales;

-- Optimize all dimension tables
OPTIMIZE TABLE DimDate;
OPTIMIZE TABLE DimCountry;
OPTIMIZE TABLE DimCategory;

-- STEP 4: Analyze Tables for Query Optimization
-- =============================================

SELECT 'ANALYZE TABLES - Updating Statistics' as Phase;

-- Analyze tables to update statistics for query optimizer
ANALYZE TABLE FactSales;
ANALYZE TABLE DimDate;
ANALYZE TABLE DimCountry;
ANALYZE TABLE DimCategory;

-- STEP 5: Check Table Status After Optimization
-- =============================================

SELECT 'AFTER OPTIMIZATION - Table Analysis' as Analysis_Phase;

-- Show table status after optimization
SHOW TABLE STATUS FROM sales;

-- Compare before and after (if DATA_FREE was > 0 before)
SELECT 'Post-Optimization Analysis' as Info;
SELECT 
    TABLE_NAME,
    TABLE_ROWS,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) as Total_Size_MB,
    ROUND(DATA_LENGTH / 1024 / 1024, 2) as Data_Size_MB,
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) as Index_Size_MB,
    ROUND(DATA_FREE / 1024 / 1024, 2) as Free_Space_MB,
    ENGINE
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'sales'
ORDER BY Total_Size_MB DESC;

-- STEP 6: Performance Testing After Optimization
-- ==============================================

SELECT 'Performance Testing After Optimization' as Test_Phase;

-- Test query performance on optimized tables
-- Query 1: Simple aggregation
SELECT 
    'Query 1 - Simple Aggregation' as Query_Type,
    COUNT(*) as Total_Records,
    SUM(amount) as Total_Amount,
    AVG(amount) as Average_Amount
FROM FactSales;

-- Query 2: Join with dimension tables
SELECT 'Query 2 - Join Performance Test' as Query_Type;
SELECT 
    c.country,
    cat.category,
    COUNT(*) as Sales_Count,
    SUM(f.amount) as Total_Sales
FROM FactSales f
JOIN DimCountry c ON f.countryid = c.countryid
JOIN DimCategory cat ON f.categoryid = cat.categoryid
WHERE f.countryid IN (1, 2, 3, 4, 5)
GROUP BY c.country, cat.category
ORDER BY Total_Sales DESC
LIMIT 10;

-- Query 3: Date-based analysis
SELECT 'Query 3 - Date Analysis Performance' as Query_Type;
SELECT 
    d.Year,
    d.Quarter,
    COUNT(*) as Sales_Count,
    SUM(f.amount) as Quarterly_Sales
FROM FactSales f
JOIN DimDate d ON f.dateid = d.dateid
GROUP BY d.Year, d.Quarter
ORDER BY d.Year, d.Quarter;

-- STEP 7: Index Usage Analysis
-- ============================

SELECT 'Index Usage Analysis' as Info;

-- Show all indexes and their usage
SELECT 
    TABLE_NAME,
    INDEX_NAME,
    COLUMN_NAME,
    CARDINALITY,
    INDEX_TYPE,
    COMMENT
FROM INFORMATION_SCHEMA.STATISTICS 
WHERE TABLE_SCHEMA = 'sales'
ORDER BY TABLE_NAME, INDEX_NAME, SEQ_IN_INDEX;

-- STEP 8: Optimization Summary
-- ============================

SELECT 'TABLE OPTIMIZATION SUMMARY' as Summary;

-- Final status summary
SELECT 
    'Tables Optimized' as Metric,
    COUNT(*) as Value
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'sales'
UNION ALL
SELECT 
    'Total Records in FactSales',
    COUNT(*)
FROM FactSales
UNION ALL
SELECT 
    'Indexes on FactSales',
    COUNT(DISTINCT INDEX_NAME)
FROM INFORMATION_SCHEMA.STATISTICS 
WHERE TABLE_SCHEMA = 'sales' 
AND TABLE_NAME = 'FactSales'
UNION ALL
SELECT 
    'Foreign Key Constraints',
    COUNT(*)
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
WHERE TABLE_SCHEMA = 'sales' 
AND REFERENCED_TABLE_NAME IS NOT NULL;

-- Show final table sizes
SELECT 'Final Table Sizes' as Info;
SELECT 
    TABLE_NAME,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) as Size_MB,
    TABLE_ROWS as Estimated_Rows
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'sales'
ORDER BY Size_MB DESC;