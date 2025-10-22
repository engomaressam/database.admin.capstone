# Module 04 Quiz Answers

## Question 1
**Which command did you use to create a backup file of the FactSales table?**

**Answer: mysqldump**

Explanation: The mysqldump command is the standard MySQL utility for creating logical backups of databases and tables. The specific command used would be:
```bash
mysqldump --host=mysql --port=3306 --user=root --password sales FactSales > FactSales_backup.sql
```

## Question 2
**Which of the following is the command used to drop the FactSales table using the MySQL terminal?**

**Answer: mysql --host=mysql --port=3306 --user=root --password --execute="DROP TABLE sales.FactSales"**

Explanation: This command connects to the MySQL server and executes the DROP TABLE statement for the FactSales table in the sales database. The full connection parameters ensure proper authentication and database targeting.

## Question 3
**Which command was used to restore the FactSales table from the backup file?**

**Answer: mysql**

Explanation: The mysql command is used to restore data from a backup file. The specific command would be:
```bash
mysql --host=mysql --port=3306 --user=root --password sales < FactSales_backup.sql
```

## Question 4
**Refer to the script created for automating the backup process, backup_automation.sh. What command was used to find and delete backup files that were modified more than a defined number of days before the script execution?**

**Answer: find $backupfolder -mtime +$keep_day -delete**

Explanation: This find command searches in the backup folder for files modified more than the specified number of days ago and deletes them. The -mtime +$keep_day option finds files older than the retention period, and -delete removes them.

## Question 5
**Which command was used to make the backup automation script executable?**

**Answer: chmod u+x+r backup_automation.sh**

Explanation: The chmod command with u+x+r gives the user (owner) execute and read permissions on the backup_automation.sh script, making it executable.

## Question 6
**Which file was edited as part of configuring the interface with the client connection particulars?**

**Answer: ~/.my.cnf**

Explanation: The ~/.my.cnf file is the MySQL client configuration file that stores connection parameters (host, port, user, password) in the user's home directory, allowing automated connections without manual password entry.

## Question 7
**What was the output of the data pull query on the DimDate table executed after the truncation step?**

**Answer: Empty Set**

Explanation: After truncating the DimDate table (and all other tables), a SELECT query would return "Empty set" because TRUNCATE removes all rows from the table, leaving it empty but with its structure intact.