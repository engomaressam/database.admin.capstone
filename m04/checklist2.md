Bash Script and Automation Checklist
[ ] Create the Bash script backup_automation.sh.

[ ] Ensure the script includes all required features:

[ ] Display an error message if the database doesn’t exist.

[ ] Create the backup folder if it is missing.

[ ] Clean up old backups, retaining them for 10 days.

[ ] Take a screenshot of the contents of the Bash file and name it backup_automation.jpg.

[ ] Set up a cron job to execute the backup_automation.sh file every 3 minutes.

[ ] Review the contents of the backup directory after waiting for 3 minutes and save the screenshot as cron_job_output.jpg.

[ ] Truncate all tables in the database.

[ ] Run a query on the DimDate table and save the screenshot of the output as data_truncate_code.jpg.

[ ] Unzip the latest backup file and use it to restore the database.

[ ] Run a query on the DimDate table after restoration and save the output as a screenshot named restored_data_automation.jpg.