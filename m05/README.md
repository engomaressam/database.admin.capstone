# Module 05: Database and Query Optimization & Access Management and Database Security

## Overview
This module focuses on two critical aspects of database administration:
1. **Database and Query Optimization** - Improving query performance and memory efficiency
2. **Access Management and Database Security** - Implementing user access controls and data encryption

## Learning Objectives

### Lab 1: Database and Query Optimization
- Compare query performance with and without indexes
- Modify data types for optimal memory usage
- Execute table optimization commands
- Analyze query execution plans using EXPLAIN

### Lab 2: Access Management and Database Security
- Create multiple user accounts with different privilege levels
- Implement Role-Based Access Control (RBAC)
- Apply AES encryption to sensitive data fields
- Test access controls and encryption/decryption

## Lab Components

### Lab 1: Database and Query Optimization

#### Task 1: Indexing the Tables
- Query FactSales table without indexes and analyze performance
- Create indexes on frequently queried columns
- Compare performance before and after indexing
- Use EXPLAIN command to analyze query execution plans

#### Task 2: Modifying Data Types
- Analyze current data types and memory usage
- Optimize data types based on actual data requirements
- Reduce memory footprint through efficient type selection

#### Task 3: Table Optimization
- Execute OPTIMIZE TABLE command
- Reorganize table data for improved storage efficiency
- Validate performance improvements

### Lab 2: Access Management and Database Security

#### Task 1: Access Management
- **Admin User (db_admin)**: Full privileges for all operations
- **Analytics User (db_analyst)**: Structural privileges (views, routines, temp tables)
- **Reporting User (db_reporter)**: Read-only access to all tables
- **External User (db_external)**: Limited access to specific columns

#### Task 2: Data Encryption
- Hash encryption passphrase using SHA2
- Encrypt sensitive amount field in FactSales table
- Test data access with and without decryption key

## Database Schema
The labs use a `sales` database with the following key tables:
- **FactSales**: Main fact table containing sales transactions
- **DimDate**: Date dimension table
- **DimCountry**: Country dimension table
- **DimCategory**: Category dimension table

## Key Technologies
- **MySQL**: Primary database management system
- **phpMyAdmin**: Web-based database administration interface
- **MySQL CLI**: Command-line interface for database operations
- **AES Encryption**: Advanced Encryption Standard for data security

## Security Considerations
- User accounts created without passwords (lab environment only)
- Principle of least privilege applied to user access
- Sensitive data encrypted with strong passphrase
- Role-based access control implementation

## Performance Optimization Techniques
- **Indexing Strategy**: Create indexes on frequently queried columns
- **Data Type Optimization**: Use smallest appropriate data types
- **Table Optimization**: Regular maintenance for storage efficiency
- **Query Analysis**: Use EXPLAIN to understand execution plans

## Required Screenshots
### Lab 1 Screenshots:
- `pre_indexing_output.jpg`: Query performance before indexing
- `index_creation.jpg`: Index creation confirmation
- `post_indexing_output.jpg`: Query performance after indexing
- `memory_before_editing.jpg`: Memory usage before optimization
- `final_data_types.jpg`: Optimized data types
- `memory_after_editing.jpg`: Memory usage after optimization
- `DimDate_optimized.jpg`: Table optimization results

### Lab 2 Screenshots:
- `db_admin_access.jpg`: Admin user privileges
- `db_analyst_access.jpg`: Analyst user privileges
- `db_reporter_access.jpg`: Reporter user privileges
- `db_external_database_level.jpg`: External user database privileges
- `db_external_table_level.jpg`: External user table privileges
- `encrypted_data_query.jpg`: Encrypted data output
- `decrypted_data_query.jpg`: Decrypted data output

## Assessment Questions
The module includes comprehensive quiz questions covering:
- Index performance analysis
- Data type optimization decisions
- User privilege configurations
- Encryption implementation details

## Prerequisites
- MySQL server running and accessible
- phpMyAdmin interface available
- Basic understanding of SQL and database concepts
- Familiarity with user management and security principles

## Implementation Notes
- All commands and procedures are documented for reference
- Screenshots capture both commands and their outputs
- Performance metrics are recorded for comparison
- Security best practices are followed throughout

## Next Steps
After completing this module, you will have:
- Optimized database performance through indexing and data type selection
- Implemented comprehensive user access controls
- Applied encryption to protect sensitive data
- Gained practical experience with database security and optimization