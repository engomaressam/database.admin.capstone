Lab: Database and Query Optimization

Estimated time: 60 mins
Scenario
For better query performance and memory efficiency, it is often recommended to employ strategies that reduce the time required to retrieve data from tables, thereby optimizing data usage efficiency.

Learning objectives
In this lab, you will:

Compare the performance of a query with and without indexes

Modify the data types of a table based on the information it contains

Execute a table optimization command

Software used in this lab
In this lab, you will use MySQL, a Relational Database Management System (RDBMS) designed for efficient data storage, manipulation, and retrieval.


To complete this lab, you will use the MySQL relational database service available in the IBM Skills Network Labs (SN Labs) Cloud IDE.

About the dataset
The dataset used here is not a real-life dataset but has been synthetically created for this lab.

Prepare the lab environment
Before you proceed with the assignment, complete the steps below.

Start the MySQL server

Use the link below to download the database_create_load.sql file using the MySQL terminal

https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/uvQey-CCjpeFVSloFPL5wA/data-loader.sql

          

            
            
            
            
          

        
Use the MySQL CLI to create a new database sales

Use the .sql file to create the tables and populate them with the data

Assignment tasks
Task 1: Indexing the tables
All of the following tasks are to be performed on the MySQL CLI. For each step, save the command used in a text document for later use in the quizzes.

Retrieve the entries from the FactSales table where the countryid field is 50. After executing the query, run it again using the EXPLAIN command.

Take a screenshot of the output, ensuring that both the execution time of the previous query and the tabular output of the EXPLAIN query are visible. Save this image as pre_indexing_output.jpg.

Create an index on the countryid column in the FactSales table. Verify its creation by displaying the indexes for the FactSales table.

Take a screenshot ensuring that both the statements and their outputs are visible. Save this screenshot as index_creation.jpg.

Re-execute both statements from Step 1: the query to retrieve entries where countryid is 50 and the EXPLAIN command for this query. Capture a similar screenshot showing the query's execution time and the tabular output of EXPLAIN, ensuring both are visible. Save this image as post_indexing_output.jpg.

Task 2: Modifying the data types
Perform the following tasks using the phpMyAdmin interface:

Open the columns page of the DimDate table and take a screenshot of the Information section. Save the screenshot as memory_before_editing.jpg.

Explore the columns of the DimDate table and review their contents. Adjust the data types to minimize memory usage based on the field requirements.

For example, the Weekday field contains values from 1 to 7, so using tinyint instead of int would be more efficient. Modify the data type of each field accordingly. Take a screenshot of the final data types assigned to each column and save it as final_data_types.jpg.

Check the updated memory utilization in the Information section and take a screenshot. Save the screenshot as memory_after_editing.jpg.

Task 3: Execute table optimization command
On the MySQL CLI, execute the table optimization command for the DimDate table. Save a screenshot of the output as DimDate_optimized.jpg.

Conclusion
Congratulations on completing this lab!

You have successfully optimized the performance of a database table by introducing indexing, updating data types, and executing the table optimization command.