Lab: Access Management and Database Security

Estimated time: 60 mins
Scenario
As a database administrator, you have been asked to manage user access based on their usage levels. Additionally, since certain fields of information, such as sales amounts, are considered sensitive, you are required to encrypt this field with a passkey so that only users with the passkey can view its values.

Learning objectives
In this lab, you will:

Create multiple user accounts with different levels of permissions

One with full permissions for all tables

One with limited permissions for all tables

One with only viewing permissions for all the tables

One with only viewing permissions for specific columns of a single table

Apply encryption to the amount field in the relevant table

Query the table with the encryption passkey

Query the table without the encryption passkey

Software used in this lab
In this lab, you will use MySQL, a Relational Database Management System (RDBMS) designed for efficient data storage, manipulation, and retrieval.


To complete this lab, you will use the MySQL relational database service available in the IBM Skills Network Labs (SN Labs) Cloud IDE.

About the dataset
The dataset used here is not a real-life dataset but has been synthetically created for this lab.

Prepare the lab environment
Before you proceed with the assignment, complete the steps below.

Start the MySQL server.

Use the link below to download the database_create_load.sql file using the MySQL terminal.

https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/e5knO3aPawlYYRCObCOKKg/database-create-load.sql

          

            
            
            
            
          

        
Use the MySQL CLI or terminal to create a new database sales.

Use the .sql file to create the tables and populate them with the data.

Assignment task 1 : Access management
A few basic settings for all users created here are as follows:

All users will be created for localhost.

All users are to be created without passwords.

Task 1a : Creating the Admin user
On the phpMyAdmin interface, create a user db_admin with all privileges for the sales database. Take a screenshot of the interface displaying the detailed user privileges being granted. A sample of the expected interface is shared below.

The screenshot should be named db_admin_access.jpg. (Images can be saved with either the .jpg or .png extension.)
Task 1b: Creating the Analytics user
The analyst requires structural privileges such as creating routines, views, temporary tables, and indexes. However, the analyst should not have permission to update or insert data into the original table, alter the table's structure in any way, or drop the table from the interface.

Keeping this in mind, create a user named db_analyst with:

Viewing privileges for data
Structural privileges for creating and displaying views, temporary tables, and routines
No administrative privileges
Save a screenshot of the interface with the relevant settings and name it db_analyst_access.jpg. (Images can be saved with either a .jpg or .png extension.)

Task 1c: Creating the reporting user
A data reporter needs access privileges only to view the information contained in the tables and does not require any administrative or structural privileges.

Based on this requirement, create a user named db_reporter with only data viewing privileges and no structural or administrative privileges.

Save a screenshot of the interface with the relevant settings and name it db_reporter_access.jpg. (Images can be saved with either a .jpg or .png extension.)

Task 1d: Creating an external user
An external user should not have access to key information, accesses, or tables. This user requires only data viewing privileges, limited to the FactSales table. Additionally, the external user must not have access to the amount column in the table.

For this user, take two screenshots.

The first screenshot should capture the relevant permissions at the database level and be named db_external_database_level.jpg. A sample of the expected interface is shown below.
interface_example_3.png

Second, take a screenshot of the permissions at the table level and name it db_external_table_level.jpg. A sample of the expected interface is shown below.
interface_example_2.png

Assignment task 2 : Data encryption
In this task, you need to set up an encryption passphrase and encrypt the amount field in the FactSales table. Complete the following steps to achieve this.

Note: You may execute the relevant commands using either the phpMyAdmin interface or the CLI.

Hash the following encryption passphrase. Save the command separately to answer the questions in the assessments.
sales info encryption

          

            
            
            
            
          

        
Modify the data type of the amount field of the table FactSales to a variable length binary with a max size of 255 bits. Save the command separately to answer the questions in the assessments.

Encrypt the data in the amount field of the table FactSales using the hashed passphrase created in Step 1. Save the command separately to answer the questions in the assessments.

Query the first 5 records of the FactSales table without using the passphrase. Save a screenshot of the output as encrypted_data_query.jpg. (Images can be saved with either the .jpg or .png extension.)

Query the first 5 records of the FactSales table using the passphrase. Save the screenshot of the output as decrypted_data_query.jpg. (Images can be saved with either a .jpg or .png extension.) Also, save the command separately to answer the questions in the assessments.

Conclusion
Congratulations on completing this lab!

You have successfully set up access for different users and encrypted critical information fields.