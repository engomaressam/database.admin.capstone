#!/bin/bash

# Truncate Tables Script for Data Loss Simulation
# This script truncates all tables in the sales database
# Disables foreign key checks before truncation and re-enables them after

database="sales"

echo "Starting data loss simulation for database: $database"

# Disable foreign key checks
echo "Disabling foreign key checks..."
mysql --execute="SET FOREIGN_KEY_CHECKS = 0;" "$database"

if [ $? -eq 0 ]; then
    echo "Foreign key checks disabled successfully"
else
    echo "Error: Failed to disable foreign key checks"
    exit 1
fi

# Get list of all tables in the database
echo "Getting list of tables in database '$database'..."
tables=$(mysql --execute="SHOW TABLES;" "$database" | tail -n +2)

if [ -z "$tables" ]; then
    echo "No tables found in database '$database'"
    exit 1
fi

echo "Found tables: $tables"

# Truncate each table
echo "Truncating all tables..."
for table in $tables; do
    echo "Truncating table: $table"
    mysql --execute="TRUNCATE TABLE $table;" "$database"
    
    if [ $? -eq 0 ]; then
        echo "Table '$table' truncated successfully"
    else
        echo "Error: Failed to truncate table '$table'"
    fi
done

# Re-enable foreign key checks
echo "Re-enabling foreign key checks..."
mysql --execute="SET FOREIGN_KEY_CHECKS = 1;" "$database"

if [ $? -eq 0 ]; then
    echo "Foreign key checks re-enabled successfully"
else
    echo "Error: Failed to re-enable foreign key checks"
fi

echo "Data loss simulation completed"
echo "All tables in database '$database' have been truncated"