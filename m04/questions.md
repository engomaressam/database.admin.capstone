1.
Question 1
Which command did you use to create a backup file of the FactSales table?



Export table



Backup table



mysqldump



mysql


1 point
2.
Question 2
Which of the following is the command used to drop the FactSales table using the MySQL terminal?



DROP sales.FactSales



mysql --host=mysql --port=3306 --user=root --password --execute="DROP TABLE sales.FactSales”



mysql --execute="DROP FactSales”



DROP TABLE FactSales from sales


1 point
3.
Question 3
Which command was used to restore the FactSales table from the backup file?



mysqldump



Restore Table



mysql



Import table


1 point
4.
Question 4
Refer to the script created for automating the backup process, backup_automation.sh. What command was used to find and delete backup files that were modified more than a defined number of days before the script execution?



find $backupfolder -mtime +$keep_day -delete



find +$keep_day -delete



find $backupfolder +$keep_day -delete



find $backupfolder -mtime +$keep_day


1 point
5.
Question 5
Which command was used to make the backup automation script executable?



chmod --execute backup_automation.sh



bash backup_automation.sh



chmod u+x+r backup_automation.sh



source backup_automation.sh


1 point
6.
Question 6
Which file was edited as part of configuring the interface with the client connection particulars?



/home/.mycnf



~/.my.cnf



./mysql.config



./my_cnf


1 point
7.
Question 7
What was the output of the data pull query on the DimDate table executed after the truncation step?



All previous records



Null



Empty Set



Error: Table does not exist


1 point
C