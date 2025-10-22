# Module 04: Database Backup and Restoration

## Overview
This module focuses on implementing robust database backup and restoration processes, including both manual operations and automated solutions. The module covers critical database administration skills for data protection and disaster recovery.

## Learning Objectives
- Create and manage database backups using MySQL CLI
- Implement data loss scenarios and recovery procedures
- Develop automated backup scripts with retention policies
- Schedule automated backups using cron jobs
- Configure secure database connections for automation
- Validate backup integrity and restoration processes

## Lab Components

### Lab 1: Database Backup and Restoration
**Objective**: Learn manual backup and restore operations using MySQL CLI

**Tasks**:
1. Create backup of FactSales table using mysqldump
2. Simulate data loss by dropping the FactSales table
3. Restore the table from backup file
4. Verify restoration with data queries

**Key Files**:
- `sales_backup.sql` - Database backup file
- Screenshots: `FactSales_backup.jpg`, `FactSales_dropped.jpg`, `FactSales_restored.jpg`

### Lab 2: Backup and Restore Automation
**Objective**: Implement automated backup and restore processes

**Tasks**:
1. Configure MySQL client for automated connections (`~/.my.cnf`)
2. Create backup automation script (`backup_automation.sh`)
3. Schedule backups using cron jobs (every 3 minutes)
4. Simulate data loss and automated restoration
5. Implement backup retention policy (10 days)

**Key Files**:
- `backup_automation.sh` - Automated backup script
- `truncate_tables.sh` - Data loss simulation script
- `my.cnf` - MySQL client configuration template
- Screenshots: `backup_automation.jpg`, `cron_job_output.jpg`, `data_truncate_code.jpg`, `restored_data_automation.jpg`

## Core Implementation Files

### Scripts
- **`backup_automation.sh`** - Comprehensive backup automation with error handling, directory management, and cleanup
- **`truncate_tables.sh`** - Safe table truncation with foreign key constraint handling
- **`my.cnf`** - MySQL client configuration for automated connections

### Documentation
- **`commands_documentation.txt`** - Complete record of all MySQL commands used
- **`checklist.md`** - Manual backup/restore task checklist
- **`checklist2.md`** - Automation task checklist
- **`questions.md`** - Assessment questions and answers

## Database Schema
The labs use a `sales` database with the following key tables:
- **FactSales** - Main transactional data table
- **DimDate** - Date dimension table
- **DimCategory** - Product category dimension
- **DimCountry** - Country dimension

## Backup Strategy
- **Frequency**: Every 3 minutes (for demonstration)
- **Retention**: 10 days
- **Format**: Compressed SQL dumps (.gz)
- **Naming**: `backup_sales_YYYYMMDD_HHMMSS.gz`
- **Location**: `/home/project/backups/`

## Security Considerations
- MySQL configuration files should have restricted permissions (600)
- Passwords should be properly secured in configuration files
- Backup files should be stored in secure locations
- Regular testing of backup integrity is essential

## Automation Features
- **Error Handling**: Database existence validation
- **Directory Management**: Automatic backup folder creation
- **Cleanup**: Automated removal of old backups
- **Logging**: Comprehensive status reporting
- **Compression**: Automatic backup file compression

## Testing and Validation
- Backup creation verification
- Data loss simulation
- Restoration accuracy testing
- Cron job execution monitoring
- Backup file integrity checks

## Prerequisites
- MySQL server access
- Bash shell environment
- Cron service availability
- Appropriate file system permissions
- Network connectivity to database server