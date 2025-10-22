-- MODULE 05: DATABASE SETUP SCRIPT
-- Database and Query Optimization & Access Management and Database Security
-- ============================================================================

-- Create the sales database
CREATE DATABASE IF NOT EXISTS sales;
USE sales;

-- Drop tables if they exist (for clean setup)
DROP TABLE IF EXISTS FactSales;
DROP TABLE IF EXISTS DimDate;
DROP TABLE IF EXISTS DimCountry;
DROP TABLE IF EXISTS DimCategory;

-- Create DimDate table (Date Dimension)
CREATE TABLE DimDate (
    dateid INT PRIMARY KEY,
    date DATE NOT NULL,
    Year INT,
    Quarter INT,
    QuarterName VARCHAR(50),
    Month INT,
    Monthname VARCHAR(50),
    Day INT,
    Weekday INT,
    WeekdayName VARCHAR(50)
);

-- Create DimCountry table (Country Dimension)
CREATE TABLE DimCountry (
    countryid INT PRIMARY KEY,
    country VARCHAR(100) NOT NULL
);

-- Create DimCategory table (Category Dimension)
CREATE TABLE DimCategory (
    categoryid INT PRIMARY KEY,
    category VARCHAR(100) NOT NULL
);

-- Create FactSales table (Fact Table)
CREATE TABLE FactSales (
    dateid INT,
    productid INT,
    countryid INT,
    categoryid INT,
    amount DECIMAL(10,2),
    PRIMARY KEY (dateid, productid, countryid, categoryid),
    FOREIGN KEY (dateid) REFERENCES DimDate(dateid),
    FOREIGN KEY (countryid) REFERENCES DimCountry(countryid),
    FOREIGN KEY (categoryid) REFERENCES DimCategory(categoryid)
);

-- Insert sample data into DimDate
INSERT INTO DimDate VALUES
(20230101, '2023-01-01', 2023, 1, 'Q1 2023', 1, 'January', 1, 1, 'Sunday'),
(20230102, '2023-01-02', 2023, 1, 'Q1 2023', 1, 'January', 2, 2, 'Monday'),
(20230103, '2023-01-03', 2023, 1, 'Q1 2023', 1, 'January', 3, 3, 'Tuesday'),
(20230104, '2023-01-04', 2023, 1, 'Q1 2023', 1, 'January', 4, 4, 'Wednesday'),
(20230105, '2023-01-05', 2023, 1, 'Q1 2023', 1, 'January', 5, 5, 'Thursday'),
(20230106, '2023-01-06', 2023, 1, 'Q1 2023', 1, 'January', 6, 6, 'Friday'),
(20230107, '2023-01-07', 2023, 1, 'Q1 2023', 1, 'January', 7, 7, 'Saturday'),
(20230401, '2023-04-01', 2023, 2, 'Q2 2023', 4, 'April', 1, 6, 'Saturday'),
(20230701, '2023-07-01', 2023, 3, 'Q3 2023', 7, 'July', 1, 6, 'Saturday'),
(20231001, '2023-10-01', 2023, 4, 'Q4 2023', 10, 'October', 1, 1, 'Sunday');

-- Insert sample data into DimCountry
INSERT INTO DimCountry VALUES
(1, 'United States'),
(2, 'Canada'),
(3, 'United Kingdom'),
(4, 'Germany'),
(5, 'France'),
(10, 'Australia'),
(15, 'Japan'),
(20, 'Brazil'),
(25, 'India'),
(30, 'China'),
(35, 'Mexico'),
(40, 'Italy'),
(45, 'Spain'),
(50, 'Netherlands'),
(55, 'Sweden'),
(60, 'Norway'),
(65, 'Denmark'),
(70, 'Finland'),
(75, 'Belgium'),
(80, 'Switzerland');

-- Insert sample data into DimCategory
INSERT INTO DimCategory VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Books'),
(4, 'Home & Garden'),
(5, 'Sports'),
(6, 'Toys'),
(7, 'Automotive'),
(8, 'Health & Beauty'),
(9, 'Food & Beverage'),
(10, 'Office Supplies');

-- Insert sample data into FactSales (large dataset for performance testing)
-- This creates a substantial dataset for meaningful performance comparisons

-- Insert base records
INSERT INTO FactSales VALUES
(20230101, 1001, 1, 1, 299.99),
(20230101, 1002, 2, 2, 89.50),
(20230101, 1003, 3, 3, 24.99),
(20230102, 1004, 4, 4, 156.75),
(20230102, 1005, 5, 5, 78.25),
(20230103, 1006, 6, 6, 45.00),
(20230103, 1007, 7, 7, 234.50),
(20230104, 1008, 8, 8, 67.80),
(20230104, 1009, 9, 9, 123.45),
(20230105, 1010, 10, 10, 89.99);

-- Generate more test data for country 50 (Netherlands) for indexing tests
INSERT INTO FactSales VALUES
(20230101, 2001, 50, 1, 199.99),
(20230101, 2002, 50, 2, 149.50),
(20230101, 2003, 50, 3, 74.99),
(20230102, 2004, 50, 4, 256.75),
(20230102, 2005, 50, 5, 178.25),
(20230103, 2006, 50, 6, 95.00),
(20230103, 2007, 50, 7, 334.50),
(20230104, 2008, 50, 8, 167.80),
(20230104, 2009, 50, 9, 223.45),
(20230105, 2010, 50, 10, 189.99),
(20230106, 2011, 50, 1, 299.99),
(20230106, 2012, 50, 2, 119.50),
(20230106, 2013, 50, 3, 54.99),
(20230107, 2014, 50, 4, 356.75),
(20230107, 2015, 50, 5, 278.25);

-- Add more records for various countries to create a substantial dataset
INSERT INTO FactSales 
SELECT 
    d.dateid,
    1000 + (RAND() * 9000),
    c.countryid,
    cat.categoryid,
    ROUND(RAND() * 500 + 10, 2)
FROM DimDate d
CROSS JOIN DimCountry c
CROSS JOIN DimCategory cat
WHERE d.dateid IN (20230101, 20230102, 20230103, 20230104, 20230105)
AND c.countryid <= 20
AND cat.categoryid <= 5
LIMIT 1000;

-- Create additional records specifically for country 50 to test indexing performance
INSERT INTO FactSales 
SELECT 
    d.dateid,
    3000 + ROW_NUMBER() OVER (ORDER BY d.dateid, cat.categoryid),
    50,
    cat.categoryid,
    ROUND(RAND() * 1000 + 50, 2)
FROM DimDate d
CROSS JOIN DimCategory cat
WHERE d.dateid IN (20230101, 20230102, 20230103, 20230104, 20230105, 20230106, 20230107)
LIMIT 100;

-- Verify data insertion
SELECT 'DimDate Records:' as Table_Info, COUNT(*) as Record_Count FROM DimDate
UNION ALL
SELECT 'DimCountry Records:', COUNT(*) FROM DimCountry
UNION ALL
SELECT 'DimCategory Records:', COUNT(*) FROM DimCategory
UNION ALL
SELECT 'FactSales Records:', COUNT(*) FROM FactSales
UNION ALL
SELECT 'FactSales Records for Country 50:', COUNT(*) FROM FactSales WHERE countryid = 50;

-- Display sample data for verification
SELECT 'Sample FactSales Data:' as Info;
SELECT * FROM FactSales LIMIT 10;

SELECT 'Sample DimDate Data:' as Info;
SELECT * FROM DimDate LIMIT 5;

-- Show initial table structures before optimization
SELECT 'Initial Table Structures:' as Info;
DESCRIBE FactSales;
DESCRIBE DimDate;

-- Show current indexes (should be only primary keys initially)
SELECT 'Current Indexes on FactSales:' as Info;
SHOW INDEX FROM FactSales;

-- Performance baseline query (to be used for testing)
SELECT 'Performance Test Query - Count records for Country 50:' as Info;
SELECT COUNT(*) as Records_Found FROM FactSales WHERE countryid = 50;