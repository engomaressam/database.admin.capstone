-- Database Setup Script for Module 04 Labs
-- This script creates the sales database and sample tables for testing

-- Create the sales database
CREATE DATABASE IF NOT EXISTS sales;
USE sales;

-- Create DimDate table
CREATE TABLE IF NOT EXISTS DimDate (
    DateID INT PRIMARY KEY,
    Date DATE,
    Year INT,
    Month INT,
    Day INT,
    Quarter INT,
    Weekday VARCHAR(10)
);

-- Create DimCategory table
CREATE TABLE IF NOT EXISTS DimCategory (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50),
    CategoryDescription TEXT
);

-- Create DimCountry table
CREATE TABLE IF NOT EXISTS DimCountry (
    CountryID INT PRIMARY KEY,
    CountryName VARCHAR(50),
    Region VARCHAR(50)
);

-- Create FactSales table
CREATE TABLE IF NOT EXISTS FactSales (
    SalesID INT PRIMARY KEY AUTO_INCREMENT,
    DateID INT,
    CategoryID INT,
    CountryID INT,
    SalesAmount DECIMAL(10,2),
    Quantity INT,
    FOREIGN KEY (DateID) REFERENCES DimDate(DateID),
    FOREIGN KEY (CategoryID) REFERENCES DimCategory(CategoryID),
    FOREIGN KEY (CountryID) REFERENCES DimCountry(CountryID)
);

-- Insert sample data into DimDate
INSERT INTO DimDate (DateID, Date, Year, Month, Day, Quarter, Weekday) VALUES
(1, '2024-01-01', 2024, 1, 1, 1, 'Monday'),
(2, '2024-01-02', 2024, 1, 2, 1, 'Tuesday'),
(3, '2024-01-03', 2024, 1, 3, 1, 'Wednesday'),
(4, '2024-01-04', 2024, 1, 4, 1, 'Thursday'),
(5, '2024-01-05', 2024, 1, 5, 1, 'Friday'),
(6, '2024-01-06', 2024, 1, 6, 1, 'Saturday'),
(7, '2024-01-07', 2024, 1, 7, 1, 'Sunday'),
(8, '2024-01-08', 2024, 1, 8, 1, 'Monday'),
(9, '2024-01-09', 2024, 1, 9, 1, 'Tuesday'),
(10, '2024-01-10', 2024, 1, 10, 1, 'Wednesday');

-- Insert sample data into DimCategory
INSERT INTO DimCategory (CategoryID, CategoryName, CategoryDescription) VALUES
(1, 'Electronics', 'Electronic devices and accessories'),
(2, 'Clothing', 'Apparel and fashion items'),
(3, 'Books', 'Books and educational materials'),
(4, 'Home & Garden', 'Home improvement and garden supplies'),
(5, 'Sports', 'Sports equipment and accessories');

-- Insert sample data into DimCountry
INSERT INTO DimCountry (CountryID, CountryName, Region) VALUES
(1, 'USA', 'North America'),
(2, 'Canada', 'North America'),
(3, 'UK', 'Europe'),
(4, 'Germany', 'Europe'),
(5, 'France', 'Europe');

-- Insert sample data into FactSales
INSERT INTO FactSales (DateID, CategoryID, CountryID, SalesAmount, Quantity) VALUES
(1, 1, 1, 1500.00, 3),
(1, 2, 2, 250.00, 5),
(2, 3, 3, 75.00, 2),
(2, 4, 4, 320.00, 1),
(3, 5, 5, 180.00, 4),
(3, 1, 1, 2200.00, 2),
(4, 2, 2, 150.00, 3),
(4, 3, 3, 95.00, 1),
(5, 4, 4, 450.00, 2),
(5, 5, 5, 275.00, 6);

-- Display table information
SHOW TABLES;
SELECT COUNT(*) as 'FactSales Records' FROM FactSales;
SELECT COUNT(*) as 'DimDate Records' FROM DimDate;
SELECT COUNT(*) as 'DimCategory Records' FROM DimCategory;
SELECT COUNT(*) as 'DimCountry Records' FROM DimCountry;