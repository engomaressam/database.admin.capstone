#!/bin/bash

# datadump.sh - Script to export sales_data table to SQL file
# This script exports the sales_data table from the sales database to a SQL file

# Database connection parameters
DB_USER="root"
DB_PASSWORD="PMO@1234"
DB_NAME="sales"
TABLE_NAME="sales_data"
OUTPUT_FILE="sales_data_export.sql"

# MySQL executable path
MYSQL_PATH="/c/Program Files/MySQL/MySQL Server 8.0/bin/mysqldump.exe"

# Export the table to SQL file
echo "Starting export of $TABLE_NAME table from $DB_NAME database..."

"$MYSQL_PATH" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" "$TABLE_NAME" > "$OUTPUT_FILE"

if [ $? -eq 0 ]; then
    echo "Export completed successfully!"
    echo "Data exported to: $OUTPUT_FILE"
    echo "File size: $(ls -lh $OUTPUT_FILE | awk '{print $5}')"
else
    echo "Export failed!"
    exit 1
fi