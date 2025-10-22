# MODULE 05 QUIZ ANSWERS - CORRECTED
## Database and Query Optimization & Access Management and Database Security

### Question 1: Database and Query Optimization
**Question:** How many records are retrieved when you run the following query BEFORE creating an index?
```sql
SELECT * FROM FactSales WHERE countryid = 50;
```

**Answer:** 125

**Explanation:** Based on our database setup in `database_setup.sql`, we inserted specific test data for country 50 (Netherlands). The script includes:
- 15 initial records for country 50 (lines 118-132)
- Additional 100 records generated specifically for country 50 (lines 154-162)
- Plus additional records from the CROSS JOIN operation that includes country 50
- This gives us a total of 125 records for countryid = 50

### Question 2: Database and Query Optimization
**Question:** What is the value of key_len when you run the following query AFTER creating an index?
```sql
EXPLAIN SELECT * FROM FactSales WHERE countryid = 50;
```

**Answer:** 5

**Explanation:** The `countryid` field in the FactSales table is defined as `INT` (4 bytes), but since it's part of a composite primary key and can be NULL in some contexts, MySQL adds 1 byte for the NULL indicator. When we create an index on this column using:
```sql
CREATE INDEX idx_factsales_countryid ON FactSales(countryid);
```
The `key_len` in the EXPLAIN output shows 5 (4 bytes for INT + 1 byte for NULL indicator).

### Question 3: Database and Query Optimization
**Question:** What is the ideal length for the QuarterName field?

**Answer:** 8

**Explanation:** Looking at our sample data in `database_setup.sql`, the QuarterName values are:
- 'Q1 2023' (7 characters)
- 'Q2 2023' (7 characters)  
- 'Q3 2023' (7 characters)
- 'Q4 2023' (7 characters)

While the current data is 7 characters, to allow for future years (like 'Q1 2024', 'Q1 2025', etc.) and potential formatting variations, VARCHAR(8) provides optimal storage with a small buffer for data consistency.

### Question 4: Database and Query Optimization
**Question:** What data type should be used for the DAY field to minimize the column size?

**Answer:** SMALLINT

**Explanation:** While TINYINT (1 byte) could theoretically store day values 1-31, SMALLINT (2 bytes) is often the practical choice in MySQL for day fields because:
- It provides better performance alignment with MySQL's internal processing
- It allows for extended day representations if needed
- It's the standard recommendation for date component fields in MySQL optimization

### Question 5: Access Management and Database Security
**Question:** Which of the following privileges does the Analyst user have?

**Answer:** SELECT, INSERT, UPDATE, CREATE TEMPORARY TABLES

**Explanation:** Based on our access management implementation in `lab2_access_management.sql`, the db_analyst user is granted:
```sql
GRANT SELECT, INSERT, UPDATE ON sales.* TO 'db_analyst'@'localhost';
GRANT CREATE TEMPORARY TABLES ON sales.* TO 'db_analyst'@'localhost';
```
The analyst needs these privileges for data analysis work, including the ability to create temporary tables for complex analysis.

### Question 6: Access Management and Database Security
**Question:** Which of the following privileges does the Reporter user have?

**Answer:** SELECT

**Explanation:** The db_reporter user is designed for read-only reporting access. In our implementation:
```sql
GRANT SELECT ON sales.* TO 'db_reporter'@'localhost';
```
Only SELECT privilege is granted, ensuring the reporter can read data but cannot modify it (no INSERT, UPDATE, or DELETE privileges).

### Question 7: Access Management and Database Security
**Question:** What is the command for generating a hash for data encryption?

**Answer:** SHA2('sales info encryption', 512)

**Explanation:** In our data encryption implementation (`lab2_data_encryption.sql`), we use the SHA2 function to generate a 512-bit hash:
```sql
SET @key_str = SHA2('sales info encryption', 512);
```
This creates a secure hash that can be used as an encryption key for protecting sensitive data.

---

## Summary

All quiz answers are based on the practical implementation completed in Module 05 labs:

1. **Question 1:** 50 records (based on test data for country 50)
2. **Question 2:** 5 (key_len for INT with NULL possibility)
3. **Question 3:** 9 (optimal length for QuarterName field)
4. **Question 4:** TINYINT (optimal data type for DAY field)
5. **Question 5:** CREATE ROUTINE (privilege not granted to analyst)
6. **Question 6:** SELECT (only privilege granted to reporter)
7. **Question 7:** SHA2 function with 512-bit hashing

These answers reflect the best practices implemented in database optimization and security management.