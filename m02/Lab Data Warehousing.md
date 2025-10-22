Data Warehousing

Estimated time needed: 60 minutes.

About This SN Labs Cloud IDE
This Skills Network Labs Cloud IDE provides a hands-on environment for course and project related labs. It utilizes Theia, an open-source IDE (Integrated Development Environment) platform, that can be run on desktop or on the cloud. To complete this lab, we will be using the Cloud IDE based on Theia and PostgreSQL database running in a Docker container.

Important Notice about this lab environment
Please be aware that sessions for this lab environment are not persistent. A new environment is created for you every time you connect to this lab. Any data you may have saved in an earlier session will get lost. To avoid losing your data, please plan to complete these labs in a single session.

Scenario
You are a data engineer hired by an ecommerce company named SoftCart.com . The company retails download only items like E-Books, Movies, Songs etc. The company has international presence and customers from all over the world. The company would like to create a data warehouse so that it can create reports like

total sales per year per country
total sales per month per category
total sales per quarter per country
total sales per category per country
You will use your data warehousing skills to design and implement a data warehouse for the company.

Objectives
In this assignment you will:

Design a Data Warehouse using the pgAdmin ERD design tool.
Create the schema in the Data Warehouse
Tools / Software
ERD Design Tool of pgAdmin
PostgreSQL Database Server
Note - Screenshots
Throughout this lab you will be prompted to take screenshots and save them on your own device. These screenshots will be required either to answer graded quiz questions or to upload as part of your submission for AI grading. You can use various free screengrabbing tools to do this or use your operating system's shortcut keys to do this (for example Alt+PrintScreen in Windows).

About the dataset
The dataset you would be using in this assignment is not a real life dataset. It was programmatically created for this assignment purpose.

Exercise 1 - Design a Data Warehouse
The ecommerce company has provied you the sample data.



You will start your project by designing a Star Schema for the warehouse by identifying the columns for the various dimension and fact tables in the schema. Name your database as softcart

Task 1 - Design the dimension table softcartDimDate
Using the ERD design tool design the table softcartDimDate. The company is looking at a granularity of a day. Which means they would like to have the ability to generate the report on yearly, monthly, daily, and weekday basis.

Here is a partial list of fields to serve as an example:

dateid

month

monthname

…

…

Take a screenshot of the table softcartDimDate in the ERD tool clearly showing all the fieldnames and data types.

Name the screenshot softcartDimDate.jpg. (Images can be saved with either the .jpg or .png extension.)

Task 2 - Design the dimension table softcartDimCategory
Using the ERD design tool design the table softcartDimCategory.

Task 3 - Design the dimension table softcartDimItem
Using the ERD design tool design the table softcartDimItem.

Task 4 - Design the dimension table softcartDimCountry
Using the ERD design tool design the table softcartDimCountry.

Take a screenshot clearly showing all three tables(softcartDimCategory, softcartDimItem, softcartDimCountry) in the ERD tool with all the fieldnames and data types. Name the screenshot dimtables.jpg. (Images can be saved with either the .jpg or .png extension.)

Task 5 - Design the fact table softcartFactSales
Using the ERD design tool design the table softcartFactSales.

Take a screenshot of the table softcartFactSales in the ERD tool clearly showing all the fieldnames and data types.

Name the screenshot softcartFactSales.jpg. (Images can be saved with either the .jpg or .png extension.)

Task 6 - Design the relationships
Using the ERD design tool design the required relationships(one-to-one, one-to-many etc) amongst the tables.

Take a screenshot of the entire ERD clearly showing all the relationships amongst the tables.

Name the screenshot softcartRelationships.jpg. (Images can be saved with either the .jpg or .png extension.)

Exercise 2 - Create the schema
In this exercise you will create the schema of the data warehouse.

Task 7 - Create the schema.
Download the schema sql from ERD tool and create the schema in a database named staging.

Take a screenshot showing the success of the schema creation.

Name the screenshot createschema.jpg. (Images can be saved with either the .jpg or .png extension.)

Conclusion
You have sucesfully completed all the tasks for setting up a data warehouse.