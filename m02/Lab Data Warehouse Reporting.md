Data Warehouse Reporting

Estimated time needed: 30 minutes.
Software Used in this Lab

To complete this lab you will utilize the PostgreSQL Database relational database service available as part of IBM Skills Network Labs (SN Labs) Cloud IDE. SN Labs is a virtual lab environment used in this course.

PostgreSQL
Scenario
You are a data engineer hired by an ecommerce company named SoftCart.com . The company retails download only items like E-Books, Movies, Songs etc. The company has international presence and customers from all over the world. You have designed the schema for the data warehouse in the previous assignment. Data engineering is a team game. Your senior data engineer reviewed your design. Your schema design was improvised to suit the production needs of the company. In this assignment you will generate reports out of the data in the data warehouse.

Objectives
In this assignment you will:

Load data into Data Warehouse
Write aggregation queries
Create MQTs
Throughout this lab you will be prompted to take screenshots and save them on your own device. You will need these screenshots to either answer graded quiz questions or to upload as your submission for peer review at the end of this course. You can use various free screengrabbing tools to do this or use your operating system’s shortcut keys to do this (for example Alt+PrintScreen in Windows).

About the dataset
The dataset you would be using in this assignment is not a real life dataset. It was programmatically created for this assignment purpose.

Prepare the lab environment
Before you start the assignment:

Right Click on this link and save this SQL file in you local system.

Start PostgreSQL server

Create a new database Test1

Create the following tables

DimDate
DimCategory
DimCountry
FactSales
Loading Data
In this exercise you will load the data into the tables. You will load the data provided by the company in csv format.

Note: Ensure that you upload the files to this path: /var/lib/pgadmin/

Task 1 - Load data into the dimension table DimDate
Download the data from this link

Load the downloaded data into DimDate table.

Take a screenshot of the first 5 rows in the table DimDate.

Name the screenshot DimDate.jpg. (Images can be saved with either the .jpg or .png extension.)

Task 2 - Load data into the dimension table DimCategory
Download the data from this link

Load the downloaded data into DimCategory table.

Take a screenshot of the first 5 rows in the table DimCategory.

Name the screenshot DimCategory.jpg. (Images can be saved with either the .jpg or .png extension.)

Task 3 - Load data into the dimension table DimCountry
Download the data from this link

Load the downloaded data into DimCountry table.

Take a screenshot of the first 5 rows in the table DimCountry.

Name the screenshot DimCountry.jpg. (Images can be saved with either the .jpg or .png extension.)

Task 4 - Load data into the fact table FactSales
Download the data from this link

Load this data into FactSales table.

Take a screenshot of the first 5 rows in the table FactSales.

Name the screenshot FactSales.jpg. (Images can be saved with either the .jpg or .png extension.)

Queries for data analytics
In this exercise you will query the data you have loaded in the previous exercise.

Task 5 - Create a grouping sets query
Create a grouping sets query using the columns country, category, totalsales.

Take a screenshot of the sql query and the output rows. Also save the query as a text for later use.

Name the screenshot groupingsets.jpg. (Images can be saved with either the .jpg or .png extension.)

Task 6 - Create a rollup query
Create a rollup query using the columns year, country, and totalsales.

Take a screenshot of the sql query and the output rows. Also save the query as a text for later use.

Name the screenshot rollup.jpg. (Images can be saved with either the .jpg or .png extension.)

Task 7 - Create a cube query
Create a cube query using the columns year, country, and average sales.

Take a screenshot of the sql query and the output rows. Also save the query as a text for later use.

Name the screenshot cube.jpg. (Images can be saved with either the .jpg or .png extension.)

Task 8 - Create an MQT
Create an MQT named total_sales_per_country that has the columns country and total_sales.

Take a screenshot of the sql query and the output rows. Also save the query as a text for later use.

Name the screenshot mqt.jpg. (Images can be saved with either the .jpg or .png extension.)

Conclusion
You have successfully created and queried the data warehousefor basic data analytics.