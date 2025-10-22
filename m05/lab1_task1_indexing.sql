-- MODULE 05 - LAB 1 - TASK 1: INDEXING
-- Database and Query Optimization
-- ============================================================================

USE sales;

-- STEP 1: Performance Test BEFORE Indexing
-- ========================================

-- Test query performance before creating index
SELECT 'BEFORE INDEXING - Performance Test' as Test_Phase;

-- Show current execution plan (should show table scan)
EXPLAIN SELECT * FROM FactSales WHERE countryid = 50;

-- Count records for country 50 (this will be our test query)
SELECT COUNT(*) as Records_Found FROM FactSales WHERE countryid = 50;

-- Show current indexes on FactSales table
SHOW INDEX FROM FactSales;

-- STEP 2: Create Index on countryid
-- =================================

-- Create index on countryid column for optimization
CREATE INDEX idx_factsales_countryid ON FactSales(countryid);

-- STEP 3: Performance Test AFTER Indexing
-- =======================================

SELECT 'AFTER INDEXING - Performance Test' as Test_Phase;

-- Show execution plan after creating index (should show index usage)
EXPLAIN SELECT * FROM FactSales WHERE countryid = 50;

-- Run the same test query to verify performance improvement
SELECT COUNT(*) as Records_Found FROM FactSales WHERE countryid = 50;

-- Show all indexes on FactSales table (should include our new index)
SHOW INDEX FROM FactSales;

-- STEP 4: Additional Index Analysis
-- =================================

-- Show detailed index information
SELECT 
    TABLE_NAME,
    INDEX_NAME,
    COLUMN_NAME,
    SEQ_IN_INDEX,
    CARDINALITY,
    INDEX_TYPE
FROM INFORMATION_SCHEMA.STATISTICS 
WHERE TABLE_SCHEMA = 'sales' 
AND TABLE_NAME = 'FactSales'
ORDER BY INDEX_NAME, SEQ_IN_INDEX;

-- Test query with EXPLAIN to show key_len and other details
EXPLAIN FORMAT=JSON SELECT * FROM FactSales WHERE countryid = 50;

-- STEP 5: Verification Queries
-- ============================

-- Verify the index is being used effectively
SELECT 'Index Usage Verification' as Info;

-- Query that should use the index
EXPLAIN SELECT f.*, c.country 
FROM FactSales f 
JOIN DimCountry c ON f.countryid = c.countryid 
WHERE f.countryid = 50;

-- Show index statistics
SELECT 
    INDEX_NAME,
    COLUMN_NAME,
    CARDINALITY,
    SUB_PART,
    PACKED,
    NULLABLE,
    INDEX_TYPE,
    COMMENT
FROM INFORMATION_SCHEMA.STATISTICS 
WHERE TABLE_SCHEMA = 'sales' 
AND TABLE_NAME = 'FactSales' 
AND INDEX_NAME = 'idx_factsales_countryid';

-- Performance comparison query
SELECT 'Performance Test Results' as Summary;
SELECT 
    'Total FactSales records' as Metric,
    COUNT(*) as Value
FROM FactSales
UNION ALL
SELECT 
    'Records for Country 50',
    COUNT(*)
FROM FactSales 
WHERE countryid = 50
UNION ALL
SELECT 
    'Index Selectivity (%)',
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM FactSales)), 2)
FROM FactSales 
WHERE countryid = 50;