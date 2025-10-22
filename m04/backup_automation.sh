#!/bin/bash

# Backup Automation Script for MySQL Database
# This script creates automated backups of the sales database
# Features: timestamp naming, directory creation, old backup cleanup

# Configuration variables
database="sales"
backupfolder="/home/project/backups"
keep_day=10
timestamp=$(date +%Y%m%d_%H%M%S)
backup_file="backup_${database}_${timestamp}.sql"
backup_gz="backup_${database}_${timestamp}.gz"

# Function to display error messages
display_error() {
    echo "Error: $1" >&2
}

# Check if database exists
echo "Checking if database '$database' exists..."
db_exists=$(mysql --execute="SHOW DATABASES LIKE '$database';" | grep -c "$database")

if [ $db_exists -eq 0 ]; then
    display_error "Database '$database' does not exist!"
    exit 1
fi

echo "Database '$database' found. Proceeding with backup..."

# Create backup directory if it doesn't exist
if [ ! -d "$backupfolder" ]; then
    echo "Creating backup directory: $backupfolder"
    mkdir -p "$backupfolder"
fi

# Create database backup
echo "Creating backup of database '$database'..."
mysqldump "$database" > "$backupfolder/$backup_file"

# Check if backup was successful
if [ $? -eq 0 ]; then
    echo "Database backup created successfully: $backup_file"
    
    # Compress the backup file
    echo "Compressing backup file..."
    gzip "$backupfolder/$backup_file"
    
    if [ $? -eq 0 ]; then
        echo "Backup compressed successfully: $backup_gz"
    else
        display_error "Failed to compress backup file"
    fi
else
    display_error "Failed to create database backup"
    exit 1
fi

# Clean up old backups (older than $keep_day days)
echo "Cleaning up backups older than $keep_day days..."
find "$backupfolder" -name "backup_${database}_*.gz" -mtime +$keep_day -delete

if [ $? -eq 0 ]; then
    echo "Old backup cleanup completed"
else
    display_error "Failed to clean up old backups"
fi

echo "Backup automation script completed successfully"
echo "Backup saved as: $backupfolder/$backup_gz"