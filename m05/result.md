Your grade: 57.14%
Your latest: 57.14%•
Your highest: 57.14%•
To pass you need at least 70%. We keep your highest score.
1.
Question 1
Refer to the screenshot “pre_indexing_output.jpg”. How many records were retrieved upon execution of the query?



5,364



300,000



50 



10,000


Incorrect
Review the Database and Query Optimization lab.

1 point
2.
Question 2
Refer to the screenshot “post_indexing_output.jpg”. What is the value of key_len displayed under the output of the EXPLAIN command?



5



5364



Null



100


Correct
The key_len value for the indexed table should be 5.

1 / 1 point
3.
Question 3
Refer to the screenshot “final_data_types.jpg”. What is the ideal length of the QuarterName field based on the contents of the DimDate table?



9



2



50



5


Incorrect
Review the Database and Query Optimization lab.

1 point
4.
Question 4
Refer to the screenshot “final_data_types.jpg“. What data type did you set the 'DAY' field to in order to minimize the size requirement of the column?



MEDIUM INT



BIG INT



SMALL INT



TINY INT


Correct
Since the value of the field cannot exceed 31, the TINYINT data type is sufficient.

1 / 1 point
5.
Question 5
Refer to the screenshot “db_analyst_access.jpg“. Which of the following structural privileges should the Analyst user not be provided with?



CREATE TEMPORARY TABLES



CREATE ROUTINE



CREATE



CREATE VIEW


Incorrect
Review the Access Management and Database Security lab.

1 point
6.
Question 6
Refer to the screenshot “db_reporter_access.jpg”. Which of the following data privileges does the reporting user have?



SELECT



UPDATE



INSERT



DELETE


Correct
The reporting user is allowed only viewing access.

1 / 1 point
7.
Question 7
What is the command used to generate the hash for the passphrase in the Data Encryption task?



SET @key_str = ENCRYPT('sales info encryption', 'SHA2', 512);



SET @key_str = MD5('sales info encryption');



SET @key_str = HASH('sales info encryption', 512);



SET @key_str = SHA2('sales info encryption', 512);


Correct
This is a valid statement to convert the passphrase into a hash.