Lab: Backup and Restore Database

Estimated time: 60 mins
Scenario
A key responsibility of a database administrator is to create proper data backups to ensure recovery in case of unexpected data loss. The e-commerce company you work for has tasked you with setting up backup and restore systems for their database.

Learning objectives
In this lab, you will:

Create a backup of the dataset tables

Simulate a data loss scenario

Restore the data from the backup

Software used in this lab
In this lab, you will use MySQL, a Relational Database Management System (RDBMS) designed for efficient data storage, manipulation, and retrieval.


To complete this lab, you will use the MySQL relational database service available in the IBM Skills Network Labs (SN Labs) Cloud IDE.

About the dataset
The dataset used here is not a real-life dataset but has been synthetically created for this lab.

Prepare the lab environment
Before you proceed with the assignment, complete the steps below.

Start the MySQL server.

Use the link below to download the database_create_load.sql file using the MySQL terminal.

https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/Wh_cJzqc1wGq_AGgf0rHvQ/database-create-load.sql

          

            
            
            
            
          

        
Use the MySQL CLI or terminal to create a new database sales.

Use the .sql file to create the tables and populate them with the data.

Assignment tasks
Task 1: Create the backup
On the MySQL terminal, write a command to create a backup of the FactSales table.

Make sure of the following.

The port number to be used is 3306.

The command execution should require manual password entry.

The backup should be written to the file sales_backup.sql.

Save the command used for this task in a separate text document. Also save the command and its output as an image and name it FactSales_backup.jpg. (Images can be saved with either the .jpg or .png extension.)

Task 2: Drop the FactSales table
On the MySQL terminal, write a command to drop the FactSales table.

The port number to be used is 3306.

The command execution should require manual password entry.

Save the command used for this task in a separate text document.

Display the tables in sales database using a command on the terminal. Save this command in the text document as well.

Take a screenshot of the output and name it FactSales_dropped.jpg. (Images can be saved with either the .jpg or .png extension.)

Execute the show tables command to verify the deletion.

Task 3a: Restore the FactSales table using the CLI
On the MySQL terminal, write a command that restores the FactSales table.

The port number to be used is 3306.

The command execution should require manual password entry.

Save the command used for this task in a separate text document.

Display the tables in sales database using a command on the terminal. Save this command in the text document as well.

Take a screenshot of the output and name it FactSales_restored.jpg. (Images can be saved with either the .jpg or .png extension.)

Verify the table restoration by querying the table to display the first 5 values.

Task 3b (optional): Restore the FactSales table using the phpMyAdmin interface
Optionally, you may restore the table by using the backup file with the phpMyAdmin interface. Rename the table to sales_restored and run a query to display the first 5 entries.

Conclusion
Congratulations on completing this lab!

You successfully implemented a database backup and restore system to safeguard data against unexpected loss. You created a backup of the FactSales table, simulated a data loss scenario by dropping the table, and restored it using the saved backup