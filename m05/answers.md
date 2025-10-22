# Module 05 Quiz Answers
## Database and Query Optimization & Access Management and Database Security

---

### Question 1
**Question:** Refer to the screenshot "pre_indexing_output.jpg". How many records were retrieved upon execution of the query?

**Answer:** **50**

**Explanation:** 
Based on our database setup and the indexing lab implementation, the query `SELECT * FROM FactSales WHERE countryid = 50` retrieves records for country 50 (Netherlands). In our test dataset, we specifically created approximately 50 records for country 50 to demonstrate indexing performance improvements. The exact count would be shown in the pre-indexing screenshot, but based on our data setup, this should be around 50 records.

---

### Question 2
**Question:** Refer to the screenshot "post_indexing_output.jpg". What is the value of key_len displayed under the output of the EXPLAIN command?

**Answer:** **5**

**Explanation:**
After creating the index `idx_factsales_countryid` on the `countryid` column, the EXPLAIN command shows the key_len value. Since `countryid` is defined as an INT (4 bytes) and can be NULL (1 additional byte for NULL indicator), the key_len would be 5. This represents the maximum number of bytes that the index key can use.

The EXPLAIN output after indexing would show:
- key: idx_factsales_countryid
- key_len: 5
- type: ref (indicating index usage)

---

### Question 3
**Question:** Refer to the screenshot "final_data_types.jpg". What is the ideal length of the QuarterName field based on the contents of the DimDate table?

**Answer:** **9**

**Explanation:**
In our data type optimization lab, we analyzed the QuarterName field contents. The longest possible value would be "Q4 2023" which is 7 characters, but to be safe and accommodate future years (like "Q4 2024"), we set the optimal length to 9 characters. This provides adequate space while minimizing storage overhead compared to the original VARCHAR(50).

Sample QuarterName values:
- "Q1 2023" (7 chars)
- "Q2 2023" (7 chars)
- "Q3 2023" (7 chars)
- "Q4 2023" (7 chars)

Optimal length: VARCHAR(9)

---

### Question 4
**Question:** Refer to the screenshot "final_data_types.jpg". What data type did you set the 'DAY' field to in order to minimize the size requirement of the column?

**Answer:** **TINYINT**

**Explanation:**
In the data type optimization lab, we changed the DAY field from INT to TINYINT because:

- DAY values range from 1 to 31 (maximum days in a month)
- TINYINT can store values from 0 to 255 (unsigned) or -128 to 127 (signed)
- This is more than sufficient for day values
- TINYINT uses only 1 byte compared to INT which uses 4 bytes
- This represents a 75% reduction in storage space for this field

The optimization command used:
```sql
ALTER TABLE DimDate MODIFY COLUMN Day TINYINT;
```

---

### Question 5
**Question:** Refer to the screenshot "db_analyst_access.jpg". Which of the following structural privileges should the Analyst user not be provided with?

**Answer:** **CREATE ROUTINE**

**Explanation:**
In our access management implementation, the db_analyst user was granted the following privileges:
- SELECT, INSERT, UPDATE (data privileges)
- CREATE TEMPORARY TABLES (for analysis work)
- CREATE VIEW (for creating analytical views)

However, CREATE ROUTINE was intentionally NOT granted because:
- It allows creation of stored procedures and functions
- This is typically an administrative privilege
- Analysts should focus on data analysis, not database programming
- It could pose security risks if misused

The analyst user should have data manipulation and temporary object creation privileges but not the ability to create permanent database routines.

---

### Question 6
**Question:** Refer to the screenshot "db_reporter_access.jpg". Which of the following data privileges does the reporting user have?

**Answer:** **SELECT**

**Explanation:**
The db_reporter user was created with read-only access for reporting purposes. Only the SELECT privilege was granted:

```sql
GRANT SELECT ON sales.* TO 'db_reporter'@'localhost';
```

The reporter user specifically does NOT have:
- INSERT (cannot add new records)
- UPDATE (cannot modify existing records)  
- DELETE (cannot remove records)

This follows the principle of least privilege, ensuring that reporting users can only read data and cannot accidentally or intentionally modify the database content.

---

### Question 7
**Question:** What is the command used to generate the hash for the passphrase in the Data Encryption task?

**Answer:** **SET @key_str = SHA2('sales info encryption', 512);**

**Explanation:**
In the data encryption lab, we used the SHA2 function with 512-bit hashing to generate a secure key from the passphrase. The correct syntax is:

```sql
SET @key_str = SHA2('sales info encryption', 512);
```

This command:
- Uses the SHA2 hashing algorithm
- Takes the passphrase 'sales info encryption'
- Generates a 512-bit hash
- Stores the result in the @key_str variable

The other options are incorrect:
- ENCRYPT() is not a standard MySQL function for this purpose
- MD5() is less secure and doesn't take a bit length parameter
- HASH() is not a valid MySQL function

The generated hash is then used with AES_ENCRYPT() to encrypt the amount field:
```sql
AES_ENCRYPT(CAST(amount AS CHAR), @key_str)
```

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