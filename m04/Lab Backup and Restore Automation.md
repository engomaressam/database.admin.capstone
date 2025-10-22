Lab: Backup and Restore Automation

Estimated time: 60 mins
Scenario
As a critical component of data security, the backup and restore processes are expected to be executed automatically. Your employer has asked you to schedule the backup creation process to run every three minutes and retain backups for ten days before deleting them.

Learning objectives
In this lab, you will:

Configure the interface for automated connections

Create a Bash script for the backup operation

Schedule the backup operation script to run every three minutes

Simulate a data loss scenario and create a Bash script to restore the data from the latest backup

Software used in this lab
In this lab, you will use MySQL, a relational database management system (RDBMS), designed for efficient data storage, manipulation, and retrieval.


To complete this lab, you will use the MySQL relational database service available in the IBM Skills Network Labs (SN Labs) Cloud IDE.

About the dataset
The dataset used here is not a real life dataset, but has been synthetically created for this lab.

Prepare the lab environment
Before you proceed with the lab, complete the following steps:

Start the MySQL server.

Use the link below to download the database_create_load.sql file using the MySQL terminal.

https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/e5knO3aPawlYYRCObCOKKg/database-create-load.sql

          

            
            
            
            
          

        
Use the MySQL CLI or terminal to create a new database sales.

Use the .sql file to create the tables and populate them with data.

Assignment tasks
Task 1: Configure the Server with connection password
Edit the configuration file of Cloud IDE interface with the relevant client information to establish connections automatically, without requiring manual entry of passwords.

Save the code entered here as a separate text file for answering graded quizzes.

Task 2: Creating the backup operation bash script
Create a bash script backup_automation.sh that has the following features.

Create the database backup as a zip file. The nomenclature of the saved backup should be backup_sales_<timestamp>.gz.

If the database doesn't exist, it should display an appropriate message. If the backup directory doesn't exist, it should create one.

Set the backup retention period to 10 days. The script should also clean up old backups.

Save the script in a separate document and take a screenshot of its contents. Name this image backup_automation.jpg.

Make the script executable.

Task 3: Schedule the CRON job
Using Crontab, add a command to execute the backup_automation script every 3 minutes. Save the command in a separate text document.

Start the Cron service.

After waiting for 3 minutes, print the contents of the backup directory and take a screenshot of the output. Save this image as cron_job_output.jpg.

Stop the Cron service once done.

Task 4: Simulate data loss and restore the database
Write a bash script, named truncate_tables.sh to truncate all tables in the database. Make sure to disable the foriegn key checks before truncation and enabling them after. Save a copy of the code used in a separate text document.

Make the bash script executable and run it.

Execute a data pull query on the DimDate table. Take a screenshot of the output and save it as data_truncate_code.jpg.

Unzip the latest backup file and restore the database. Save all the commands used in this process in a separate text document.

To demonstrate the restoration, query the top 10 entries from the DimDate table in the dataset. Take a screenshot of this output and save it as restored_data_automation.jpg.

Conclusion
Congratulations on completing this lab!

You automated the database backup and restore process to enhance data security and ensure recovery in case of data loss. You created a Bash script to back up the database, scheduled it to run every three minutes using a CRON job, and implemented a retention policy to manage old backups. Additionally, you simulated a data loss scenario by truncating the tables and successfully restored the database from the latest backup.

