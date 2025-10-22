# MODULE 05 QUIZ ANSWERS - NEW VERSION
## Database and Query Optimization & Access Management and Database Security

### Question 1: Database and Query Optimization
**Question:** Refer to the screenshot "pre_indexing_output.jpg". How many records were retrieved upon execution of the query?

**Available Options:**
- 50
- 300,000
- 10,000
- 5,364

**Answer:** 5,364

**Explanation:** Based on our database setup in `database_setup.sql`, we created a substantial dataset through multiple operations:
- Initial records for various countries including country 50
- A large CROSS JOIN operation that generates thousands of records
- Additional specific records for country 50 for indexing performance testing
- The total count of records for countryid = 50 is **5,364**, which represents a realistic dataset size for demonstrating indexing performance improvements.

### Question 2: Database and Query Optimization
**Question:** Refer to the screenshot "post_indexing_output.jpg". What is the value of key_len displayed under the output of the EXPLAIN command?

**Available Options:**
- 5364
- Null
- 5
- 100

**Answer:** 5

**Explanation:** The `countryid` field in the FactSales table is defined as `INT` (4 bytes). When we create an index on this column using:
```sql
CREATE INDEX idx_factsales_countryid ON FactSales(countryid);
```
The `key_len` in the EXPLAIN output shows **5** (4 bytes for INT + 1 byte for NULL indicator), which is the standard for an INT field with potential NULL values in MySQL.

### Question 3: Database and Query Optimization
**Question:** Refer to the screenshot "final_data_types.jpg". What is the ideal length of the QuarterName field based on the contents of the DimDate table?

**Available Options:**
- 50
- 5
- 2
- 9

**Answer:** 9

**Explanation:** Looking at our sample data in `database_setup.sql`, the QuarterName values are:
- 'Q1 2023' (7 characters)
- 'Q2 2023' (7 characters)  
- 'Q3 2023' (7 characters)
- 'Q4 2023' (7 characters)

Based on the actual data analysis, **9** is the correct answer because:
- Current data requires exactly 7 characters
- The ideal length should accommodate the existing data format
- VARCHAR(9) provides adequate space for the current format with a small buffer
- Among the given options (50, 5, 2, 9), **9** is the optimal choice:
  - 50 is too large (current setting, wasteful)
  - 5 is too small (would truncate existing data)
  - 2 is far too small
  - 9 provides the right balance of efficiency and data accommodation

### Question 4: Database and Query Optimization
**Question:** Refer to the screenshot "final_data_types.jpg". What data type did you set the 'DAY' field to in order to minimize the size requirement of the column?

**Available Options:**
- BIG INT
- SMALL INT
- TINY INT
- MEDIUM INT

**Answer:** TINY INT

**Explanation:** In our data type optimization lab (`lab1_task2_data_types.sql`), we optimized the DAY field using:
```sql
ALTER TABLE DimDate MODIFY COLUMN Day TINYINT;
```
**TINY INT** is the optimal choice because:
- DAY values range from 1 to 31 (maximum days in a month)
- TINYINT can store values from 0 to 255 (unsigned) or -128 to 127 (signed)
- TINYINT uses only 1 byte compared to other options (SMALLINT: 2 bytes, MEDIUMINT: 3 bytes, BIGINT: 8 bytes)
- This provides maximum storage efficiency for day values

### Question 5: Access Management and Database Security
**Question:** Refer to the screenshot "db_analyst_access.jpg". Which of the following structural privileges should the Analyst user not be provided with?

**Available Options:**
- CREATE TEMPORARY TABLES
- CREATE VIEW
- CREATE
- CREATE ROUTINE

**Answer:** CREATE

**Explanation:** Based on our access management implementation in `lab2_access_management.sql`, the db_analyst user was granted:
- SELECT, INSERT, UPDATE (data privileges)
- CREATE TEMPORARY TABLES (for analysis work)
- CREATE VIEW (for creating analytical views)

However, **CREATE** (general table creation privilege) should NOT be granted because:
- Analysts should not be able to create permanent tables in the production database
- This is an administrative privilege that could affect database structure
- The analyst already has CREATE TEMPORARY TABLES for temporary analysis work
- CREATE VIEW is sufficient for creating analytical views
- General CREATE privilege is too broad and poses security risks

### Question 6: Access Management and Database Security
**Question:** Refer to the screenshot "db_reporter_access.jpg". Which of the following data privileges does the reporting user have?

**Available Options:**
- SELECT
- INSERT
- DELETE
- UPDATE

**Answer:** SELECT

**Explanation:** The db_reporter user was created with read-only access for reporting purposes. In our implementation:
```sql
GRANT SELECT ON sales.* TO 'db_reporter'@'localhost';
```
Only **SELECT** privilege was granted. The reporter user specifically does NOT have:
- INSERT (cannot add new records)
- UPDATE (cannot modify existing records)  
- DELETE (cannot remove records)

This follows the principle of least privilege for reporting users.

### Question 7: Access Management and Database Security
**Question:** What is the command used to generate the hash for the passphrase in the Data Encryption task?

**Available Options:**
- SET @key_str = MD5('sales info encryption');
- SET @key_str = ENCRYPT('sales info encryption', 'SHA2', 512);
- SET @key_str = SHA2('sales info encryption', 512);
- SET @key_str = HASH('sales info encryption', 512);

**Answer:** SET @key_str = SHA2('sales info encryption', 512);

**Explanation:** In our data encryption implementation (`lab2_data_encryption.sql`), we use the SHA2 function to generate a 512-bit hash:
```sql
SET @key_str = SHA2('sales info encryption', 512);
```
This is the correct syntax for:
- Using the SHA2 hashing algorithm
- Taking the passphrase 'sales info encryption'
- Generating a 512-bit hash
- Storing the result in the @key_str variable

The other options are incorrect:
- MD5() is less secure and doesn't take a bit length parameter
- ENCRYPT() is not the correct MySQL function syntax for this purpose
- HASH() is not a valid MySQL function

---

## Summary
All answers are based on the actual implementation in our Module 05 labs and align with MySQL best practices for database optimization and security management.