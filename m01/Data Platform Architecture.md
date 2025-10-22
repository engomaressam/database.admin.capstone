Data Platform Architecture
Estimated time: 5 minutes

Environment
This document introduces the data platform architecture of an eCommerce company named SoftCart.

SoftCart uses a hybrid architecture, with some databases hosted on-premises and others in the cloud.

Tools and Technologies
SoftCart's data platform relies on a combination of industry-standard tools and technologies to ensure efficient data processing, storage, and management:

OLTP database: MySQL
Staging & Data warehouse: PostgreSQL
Data Pipelines: Apache Airflow
Database Administration: MySQL
Process
SoftCart's online presence is primarily through its website, which customers access using a variety of devices, such as laptops, mobile phones, and tablets.

Data Storage
All product catalog data, along with transactional data such as inventory and sales, is stored in a MySQL database server.

SoftCart's web server is entirely driven by this database.

Data Warehousing
Data is periodically extracted from this database and loaded into the staging data warehouse, which runs on PostgreSQL.

Data Integration and Processing
To move data between the OLTP system and the data warehouse, ETL pipelines are used, running on Apache Airflow.

Database Administration
Database administration is managed through the MySQL server space. This includes data security, access management, memory optimization, query optimization, backup and restore policies, and more.


This video will give you an overview of the exercises you need to perform for the transactional database system. In this module, you will perform three exercises with multiple tasks. But before proceeding with the assignment, you will check the lab environment by starting the MySQL server. The first exercise requires you to design the schema for the OLTP database by storing data like product ID, customer ID, price, quantity, and timestamp of sales in a sales database. In the second exercise, you will load this data into the OLTP database by importing the data from the downloaded CSV file into the data table using phpMyAdmin. Further, you will list the tables in the database. And you will also write a query to find out the count of records in the tables. 
In the third and final exercise, you will set up admin tasks by creating an index on the timestamp field and then listing the indexes on the table. Finally, you will write a bash script that exports all the rows in the data table to a SQL file. After performing each task, you will take a screenshot of the command used and the output obtained and give a name to the screenshot. Good luck, and let’s get started! 