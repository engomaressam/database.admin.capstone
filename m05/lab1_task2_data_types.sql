-- MODULE 05 - LAB 1 - TASK 2: DATA TYPES OPTIMIZATION
-- Database and Query Optimization
-- ============================================================================

USE sales;

-- STEP 1: Analyze Current Data Types
-- ==================================

SELECT 'BEFORE OPTIMIZATION - Current Data Types' as Analysis_Phase;

-- Show current table structure
DESCRIBE DimDate;

-- Analyze data ranges to determine optimal data types
SELECT 'Data Analysis for Optimization' as Info;

-- Analyze Year field (should be YEAR type or SMALLINT)
SELECT 
    'Year' as Field,
    MIN(Year) as Min_Value,
    MAX(Year) as Max_Value,
    COUNT(DISTINCT Year) as Distinct_Values
FROM DimDate
UNION ALL
-- Analyze Quarter field (should be TINYINT)
SELECT 
    'Quarter',
    MIN(Quarter),
    MAX(Quarter),
    COUNT(DISTINCT Quarter)
FROM DimDate
UNION ALL
-- Analyze Month field (should be TINYINT)
SELECT 
    'Month',
    MIN(Month),
    MAX(Month),
    COUNT(DISTINCT Month)
FROM DimDate
UNION ALL
-- Analyze Day field (should be TINYINT)
SELECT 
    'Day',
    MIN(Day),
    MAX(Day),
    COUNT(DISTINCT Day)
FROM DimDate
UNION ALL
-- Analyze Weekday field (should be TINYINT)
SELECT 
    'Weekday',
    MIN(Weekday),
    MAX(Weekday),
    COUNT(DISTINCT Weekday)
FROM DimDate;

-- Analyze string field lengths
SELECT 'String Field Length Analysis' as Info;
SELECT 
    'QuarterName' as Field,
    MAX(LENGTH(QuarterName)) as Max_Length,
    MIN(LENGTH(QuarterName)) as Min_Length,
    AVG(LENGTH(QuarterName)) as Avg_Length
FROM DimDate
UNION ALL
SELECT 
    'Monthname',
    MAX(LENGTH(Monthname)),
    MIN(LENGTH(Monthname)),
    AVG(LENGTH(Monthname))
FROM DimDate
UNION ALL
SELECT 
    'WeekdayName',
    MAX(LENGTH(WeekdayName)),
    MIN(LENGTH(WeekdayName)),
    AVG(LENGTH(WeekdayName))
FROM DimDate;

-- STEP 2: Optimize Data Types
-- ===========================

SELECT 'OPTIMIZATION PHASE - Modifying Data Types' as Phase;

-- Optimize Year field (SMALLINT is sufficient for years)
ALTER TABLE DimDate MODIFY COLUMN Year SMALLINT;

-- Optimize Quarter field (TINYINT: 1-4)
ALTER TABLE DimDate MODIFY COLUMN Quarter TINYINT;

-- Optimize Month field (TINYINT: 1-12)
ALTER TABLE DimDate MODIFY COLUMN Month TINYINT;

-- Optimize Day field (TINYINT: 1-31)
ALTER TABLE DimDate MODIFY COLUMN Day TINYINT;

-- Optimize Weekday field (TINYINT: 1-7)
ALTER TABLE DimDate MODIFY COLUMN Weekday TINYINT;

-- Optimize QuarterName field (VARCHAR(9) is sufficient for "Q4 2023")
ALTER TABLE DimDate MODIFY COLUMN QuarterName VARCHAR(9);

-- Optimize Monthname field (VARCHAR(9) is sufficient for "September")
ALTER TABLE DimDate MODIFY COLUMN Monthname VARCHAR(9);

-- Optimize WeekdayName field (VARCHAR(9) is sufficient for "Wednesday")
ALTER TABLE DimDate MODIFY COLUMN WeekdayName VARCHAR(9);

-- STEP 3: Verify Optimizations
-- ============================

SELECT 'AFTER OPTIMIZATION - Final Data Types' as Analysis_Phase;

-- Show optimized table structure
DESCRIBE DimDate;

-- Verify data integrity after optimization
SELECT 'Data Integrity Verification' as Info;
SELECT COUNT(*) as Total_Records FROM DimDate;

-- Show sample data to ensure no data loss
SELECT * FROM DimDate LIMIT 5;

-- STEP 4: Storage Analysis
-- =======================

-- Calculate storage savings (approximate)
SELECT 'Storage Optimization Analysis' as Info;

-- Show table status for storage information
SHOW TABLE STATUS LIKE 'DimDate';

-- Detailed column information
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE,
    COLUMN_DEFAULT,
    CHARACTER_MAXIMUM_LENGTH,
    NUMERIC_PRECISION,
    NUMERIC_SCALE
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'sales' 
AND TABLE_NAME = 'DimDate'
ORDER BY ORDINAL_POSITION;

-- STEP 5: Performance Impact Test
-- ==============================

-- Test query performance with optimized data types
SELECT 'Performance Test with Optimized Data Types' as Test;

-- Query using optimized integer fields
SELECT 
    Year,
    Quarter,
    Month,
    COUNT(*) as Records
FROM DimDate 
GROUP BY Year, Quarter, Month
ORDER BY Year, Quarter, Month;

-- Query using optimized string fields
SELECT 
    QuarterName,
    Monthname,
    WeekdayName,
    COUNT(*) as Records
FROM DimDate 
GROUP BY QuarterName, Monthname, WeekdayName
ORDER BY QuarterName;

-- Summary of optimizations
SELECT 'OPTIMIZATION SUMMARY' as Summary;
SELECT 
    'Original INT fields changed to TINYINT/SMALLINT' as Optimization,
    'Reduced storage by ~75% for integer fields' as Benefit
UNION ALL
SELECT 
    'VARCHAR fields optimized to exact required length',
    'Reduced storage overhead for string fields'
UNION ALL
SELECT 
    'Maintained data integrity and functionality',
    'No data loss during optimization';