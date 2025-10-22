Prepare to Submit Your Project
Before submitting your work, ensure you have completed all the hands-on labs for this project. This Capstone project is worth 75 points and includes 25 tasks that reference every lab covered in this course. Your final project will be AI-graded, providing prompt, precise, and constructive feedback on your performance.

Each question in the assignment will require you to refer to screenshots or code, as instructed in the labs so that you can easily reference the specific technicalities associated with each lab. This final assignment will help validate your understanding of the concepts and processes learned throughout the course.

Here is the point breakdown for the questions across the labs in the course:

Q1. Enter the query used in Exercise 3, Task 5 of the OLTP Database lab, which gives the count of the records in the sales_data table. (2 points)

Q2. Enter the contents of the file datadump.sh created as part of Exercise 4, Task 8 of the OLTP lab, which extracts all the rows from the sales_data table into the sales_data.sql file. (2 points)

Q3. Refer to the screenshot softcartRelationships.jpg created in Exercise 1, Task 6 of the Data Warehouse Lab. How many direct connections does the softcartFactSales table have with other tables? (1 point)

Q4. Refer to the screenshot groupingsets.jpg created in Task 5 of the Data Warehouse Reporting lab. Enter the SQL command used to create a GROUPING SETS query using the country, category, and total_sales columns. (3 points)

 The Script should be in this format:

1234567891011121314151617
SELECT  
     -- Country name from DimCountry table  
     -- Category name from DimCategory table  
      -- Summing sales amounts  
FROM  
    public."FactSales" FactSales  
LEFT JOIN  
      -- Joining FactSales with DimCountry  
LEFT JOIN  
      -- Joining FactSales with DimCategory  

Q5. Refer to the screenshot rollup.jpg created in Task 6 of the Data Warehouse Reporting lab. Enter the SQL command used to create a ROLLUP query using the year, country, and total_sales columns. (3 points)

Q6. Refer to the screenshot cube.jpg created in Task 7 of the Data Warehouse Reporting lab. Enter the SQL command used to create a CUBE query using the year, country, and average_sales columns. (3 points)

Q7. Refer to the screenshot mqt.jpg created in Task 8 of the Data Warehouse Reporting lab. Enter the SQL command used to create an MQT named total_sales_per_country with the country and total_sales columns. (3 points)

Q8. What is the SQL query used in Exercise 1, Task 1 of the ETL lab for implementing the get_row_id() function that returns the last row ID of the sales_data table? (5 points)

Q9. What is the code snippet used in Exercise 1, Task 2 of the ETL lab, while implementing the get_latest_records() function that returns the latest records of the sales_data table, that is, with row id greater than a passed argument? (5 points)

 Q10. What is the code snippet used in Exercise 1, Task 3 of the ETL lab for implementing the insert_records() function that inserts all the given records into the sales_data table? (5 points)

Q11. Enter the Python code block that defines the configuration to be used for the DAG in Exercise 2, Task 1 of the Data Pipelines Using Apache Airflow lab. (3 points)

Q12. Enter the Python code block that defines the DAG in Exercise 2, Task 2 of the Data Pipelines Using Apache Airflow lab. (3 points)

The Script should be:

1234567
dag = DAG(
    # DAG ID
    # Default arguments
    # Description of the DAG
    # Runs daily
    catchup=False  # Prevents running all past failed runs
)
Q13. Enter the Python code block that extracts the IP address field from the web server log file and saves it to a file named extracted_data.txt in Exercise 2, Task 3 of the Data Pipelines Using Apache Airflow lab. (3 points). 

Q14. Enter the Python code block that filters out all occurrences of the IP address 198.46.149.143 from extracted_data.txt and saves the output to a file named transformed_data.txt in Exercise 2, Task 4 of the Data Pipelines Using Apache Airflow lab. (3 points)

Q15. Enter the Python code block that archives the file transformed_data.txt into a tar file named weblog.tar in Exercise 2, Task 5 of the Data Pipelines Using Apache Airflow lab. (3 points)

Q16. Enter the MySQL terminal command used to create a backup of the FactSales table to the file sales_backup.sql, specifying port 3306 and requiring manual password entry, as part of Task 1 in the Backup and Restore lab. (2 points)

Q17. Enter the MySQL terminal command used to restore the FactSales table from the file sales_backup.sql, specifying port 3306 and requiring manual password entry, as part of Task 3 in the Backup and Restore lab. (2 points)

Q18. Enter the contents of the bash script backup_automation.sh as a part of Task 2 in the Backup and Restore Automation lab. This script should:

Create the database backup as a zip file. The nomenclature of the saved backup should be backup_sales_<timestamp>.gz.

Check if the backup directory exists; if not, create it.

Set the backup retention period to 10 days and delete the old backups. (7 points)

Q19. Enter the crontab command used to schedule the backup_automation.sh script to run every three minutes, every day, as part of Task 3 in the Backup and Restore Automation lab. (3 points)

Q20. Enter the MySQL terminal commands that were used to unzip the latest backup file and restore the database, as part of Task 4 in the Backup and Restore Automation lab. (3 points)

Q21. Enter the MySQL CLI command used to create the index country_id on the countryid field in the FactSales table, as part of Task 1 in the Database and Query Optimization lab. (3 points)

Q22. Refer to the screenshot final_data_types.jpg created as a part of Task 2 in the Database and Query Optimization lab. What is the ideal length of the QuarterName field, based on the contents of the DimDate table? (1 point)

Q23. Enter the command used to modify the data type of the amount field in the FactSales table to a variable length binary with a maximum size of 255 bits, as used in Task 2 of the Access Management and Database Security lab. (3 points)

Q24. Enter the command used to encrypt the data in the amount field of the table FactSales using the hashed passphrase, as used in Task 2 of the Access Management and Database Security lab. (3 points)

Q25. What is the difference between the output of the data query executed with and without decryption, as used in the last 2 steps of Task 2 of the Access Management and Database Security lab? (1 point)

All the best for the successful completion of this project!