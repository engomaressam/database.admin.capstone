Hands-on Lab: OLTP Database




Estimated time needed: 30 minutes.

About This SN Labs Cloud IDE
This Skills Network Labs Cloud IDE provides a hands-on environment for course and project related labs. It utilizes Theia, an open-source IDE (Integrated Development Environment) platform, that can be run on desktop or on the cloud. To complete this lab, we will be using the Cloud IDE based on Theia and MySQL running in a Docker container.

Important Notice about this lab environment
Please be aware that sessions for this lab environment are not persisted. Every time you connect to this lab, a new environment is created for you. Any data you may have saved in the earlier session would get lost. Plan to complete these labs in a single session, to avoid losing your data.

Scenario
You are a data engineer at an e-commerce company. Your company needs you to design a data platform that uses MySQL as an OLTP database. You will be using MySQL to store the OLTP data.

Objectives
In this assignment you will:

design the schema for OLTP database.
load data into OLTP database.
automate admin tasks.
Tools / Software
MySQL 8.0.22
phpMyAdmin 5.0.4
Note - Screenshots
Throughout this lab you will be prompted to take screenshots and save them on your own device. You will need these screenshots to either answer graded quiz questions or to upload as your submission for peer review at the end of this course. You can use various free screengrabbing tools to do this or use your operating system's shortcut keys to do this (for example Alt+PrintScreen in Windows).

Exercises - Setting up the database
Exercise 1 - Check the lab environment
Before you proceed with the assignment :

Start MySQL server.
Exercise 2 - Design the OLTP Database
Task 1 - Create a database.
Create a database named sales.

Task 2 - Design a table named sales_data.
Design a table named sales_data based on the sample data given.



Create the sales_data table in sales database.

Take a screenshot of the sql statement you used and the output. Also save the code in a text document for later use.

Name the screenshot as createtable.jpg. (images can be saved with either .jpg or .png extension)

Exercises - Querying and Admin tasks
Exercise 3 - Load the Data
Task 3 - Import the data in the file oltpdata.csv
Download the file oltpdata.csv from here.

Import the data from oltpdata.csv into sales_data table using phpMyAdmin.

Take a screenshot of the phpMyAdmin import status.

Name the screenshot as importdata.jpg. (images can be saved with either .jpg or .png extension)

Task 4 - List the tables in the database sales.
Take a screenshot of the command you used and the output. Also save the code in a text document for later use.

Name the screenshot as listtables.jpg. (images can be saved with either .jpg or .png extension)

Task 5. Write a query to find out the count of records in the tables sales_data.
Take a screenshot of the command you used and the output. Also save the code in a text document for later use.

Name the screenshot as salesrows.jpg. (images can be saved with either .jpg or .png extension)

Exercise 4 - Set up Admin tasks
Task 6 - Create an index
Create an index named ts on the timestamp field.

Task 7 - List indexes
List indexes on the table sales_data.

Take a screenshot of the command you used and the output. Also save the code in a text document for later use.

Name the screenshot as listindexes.jpg. (images can be saved with either .jpg or .png extension)

Task 8 - Write a bash script to export data.
Write a bash script named datadump.sh that exports all the rows in the sales_data table to a file named sales_data.sql

Take a screenshot of the contents of the datadump.sh bash file command you used and the output. Also save the code in a text document for later use.

Name the screenshot as exportdata.jpg. (images can be saved with either .jpg or .png extension)

Conclusion
You have successfully created the OLTP database with all the required tables and data.