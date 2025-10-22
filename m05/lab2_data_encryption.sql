-- MODULE 05 - LAB 2: DATA ENCRYPTION
-- Implementing Data Security through Encryption
-- ============================================================================

USE sales;

-- STEP 1: Prepare for Encryption
-- ==============================

SELECT 'DATA ENCRYPTION SETUP' as Phase;

-- Show current FactSales structure before encryption
DESCRIBE FactSales;

-- Show sample data before encryption
SELECT 'Sample Data Before Encryption' as Info;
SELECT * FROM FactSales WHERE countryid = 50 LIMIT 5;

-- STEP 2: Generate Hash for Passphrase
-- ====================================

-- Generate SHA2 hash for the passphrase (as per quiz question)
SET @key_str = SHA2('sales info encryption', 512);

-- Display the generated hash (for verification)
SELECT 'Generated Encryption Key Hash' as Info;
SELECT @key_str as Generated_Hash;

-- Show hash length for verification
SELECT LENGTH(@key_str) as Hash_Length;

-- STEP 3: Create Encrypted Version of FactSales
-- =============================================

-- Create a new table with encrypted amount field
CREATE TABLE FactSales_Encrypted (
    dateid INT,
    productid INT,
    countryid INT,
    categoryid INT,
    amount_encrypted VARBINARY(256),  -- Encrypted amount field
    amount_original DECIMAL(10,2),    -- Keep original for comparison
    PRIMARY KEY (dateid, productid, countryid, categoryid),
    FOREIGN KEY (dateid) REFERENCES DimDate(dateid),
    FOREIGN KEY (countryid) REFERENCES DimCountry(countryid),
    FOREIGN KEY (categoryid) REFERENCES DimCategory(categoryid)
);

-- STEP 4: Encrypt and Insert Data
-- ===============================

-- Insert data with encrypted amount field
INSERT INTO FactSales_Encrypted (dateid, productid, countryid, categoryid, amount_encrypted, amount_original)
SELECT 
    dateid,
    productid,
    countryid,
    categoryid,
    AES_ENCRYPT(CAST(amount AS CHAR), @key_str) as amount_encrypted,
    amount as amount_original
FROM FactSales;

-- Verify data insertion
SELECT 'Encrypted Data Insertion Results' as Info;
SELECT COUNT(*) as Total_Encrypted_Records FROM FactSales_Encrypted;

-- STEP 5: Demonstrate Encryption/Decryption
-- =========================================

-- Show encrypted data (should show binary data)
SELECT 'Encrypted Data Sample' as Info;
SELECT 
    dateid,
    productid,
    countryid,
    categoryid,
    amount_encrypted,
    amount_original
FROM FactSales_Encrypted 
WHERE countryid = 50 
LIMIT 5;

-- Demonstrate decryption
SELECT 'Decryption Demonstration' as Info;
SELECT 
    dateid,
    productid,
    countryid,
    categoryid,
    amount_original,
    CAST(AES_DECRYPT(amount_encrypted, @key_str) AS DECIMAL(10,2)) as amount_decrypted,
    CASE 
        WHEN amount_original = CAST(AES_DECRYPT(amount_encrypted, @key_str) AS DECIMAL(10,2)) 
        THEN 'MATCH' 
        ELSE 'NO MATCH' 
    END as Verification
FROM FactSales_Encrypted 
WHERE countryid = 50 
LIMIT 5;

-- STEP 6: Create Secure Views for Data Access
-- ===========================================

-- Create a view that automatically decrypts data for authorized users
CREATE VIEW FactSales_Decrypted AS
SELECT 
    dateid,
    productid,
    countryid,
    categoryid,
    CAST(AES_DECRYPT(amount_encrypted, SHA2('sales info encryption', 512)) AS DECIMAL(10,2)) as amount
FROM FactSales_Encrypted;

-- Test the secure view
SELECT 'Secure View Test' as Info;
SELECT * FROM FactSales_Decrypted WHERE countryid = 50 LIMIT 5;

-- STEP 7: Create Function for Secure Data Access
-- ==============================================

-- Create a function to decrypt amount with proper key
DELIMITER //
CREATE FUNCTION decrypt_amount(encrypted_value VARBINARY(256)) 
RETURNS DECIMAL(10,2)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE decrypted_value DECIMAL(10,2);
    SET decrypted_value = CAST(AES_DECRYPT(encrypted_value, SHA2('sales info encryption', 512)) AS DECIMAL(10,2));
    RETURN decrypted_value;
END //
DELIMITER ;

-- Test the decryption function
SELECT 'Decryption Function Test' as Info;
SELECT 
    dateid,
    productid,
    countryid,
    categoryid,
    decrypt_amount(amount_encrypted) as decrypted_amount,
    amount_original
FROM FactSales_Encrypted 
WHERE countryid = 50 
LIMIT 3;

-- STEP 8: Security Analysis
-- =========================

-- Show encryption effectiveness
SELECT 'Encryption Security Analysis' as Info;

-- Compare original vs encrypted data sizes
SELECT 
    'Original FactSales' as Table_Type,
    COUNT(*) as Record_Count,
    ROUND(AVG(LENGTH(CAST(amount AS CHAR))), 2) as Avg_Data_Length
FROM FactSales
UNION ALL
SELECT 
    'Encrypted FactSales',
    COUNT(*),
    ROUND(AVG(LENGTH(amount_encrypted)), 2)
FROM FactSales_Encrypted;

-- Show that encrypted data is not readable without key
SELECT 'Encrypted Data Without Decryption' as Security_Demo;
SELECT 
    dateid,
    productid,
    HEX(amount_encrypted) as Encrypted_Hex_Value,
    LENGTH(amount_encrypted) as Encrypted_Length
FROM FactSales_Encrypted 
LIMIT 3;

-- STEP 9: Performance Impact Analysis
-- ===================================

-- Test query performance on encrypted vs original data
SELECT 'Performance Analysis' as Info;

-- Query on original table
SELECT 
    'Original Table Query' as Query_Type,
    COUNT(*) as Record_Count,
    SUM(amount) as Total_Amount,
    AVG(amount) as Average_Amount
FROM FactSales
WHERE countryid = 50;

-- Query on encrypted table (using decryption)
SELECT 
    'Encrypted Table Query' as Query_Type,
    COUNT(*) as Record_Count,
    SUM(decrypt_amount(amount_encrypted)) as Total_Amount,
    AVG(decrypt_amount(amount_encrypted)) as Average_Amount
FROM FactSales_Encrypted
WHERE countryid = 50;

-- STEP 10: Cleanup and Security Summary
-- ====================================

-- Clear the encryption key from memory (security best practice)
SET @key_str = NULL;

-- Summary of encryption implementation
SELECT 'DATA ENCRYPTION SUMMARY' as Summary;

SELECT 
    'Encryption Method' as Component,
    'AES_ENCRYPT with SHA2-512 key' as Implementation
UNION ALL
SELECT 
    'Key Generation',
    'SHA2(passphrase, 512)'
UNION ALL
SELECT 
    'Encrypted Field',
    'amount field in FactSales'
UNION ALL
SELECT 
    'Storage Type',
    'VARBINARY(256)'
UNION ALL
SELECT 
    'Access Method',
    'Secure view and decryption function'
UNION ALL
SELECT 
    'Security Level',
    'High - requires exact passphrase for decryption';

-- Show final table structures
SELECT 'Final Table Structures' as Info;
DESCRIBE FactSales_Encrypted;

-- Show created objects
SELECT 'Created Security Objects' as Info;
SHOW TABLES LIKE '%FactSales%';

SELECT 'Created Views' as Info;
SHOW FULL TABLES WHERE Table_type = 'VIEW';

SELECT 'Created Functions' as Info;
SHOW FUNCTION STATUS WHERE Db = 'sales';