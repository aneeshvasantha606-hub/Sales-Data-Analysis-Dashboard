CREATE DATABASE sales_db;
USE sales_db;

CREATE TABLE sales (
    Order_ID INT PRIMARY KEY,
    Order_Date VARCHAR(50),
    Customer_Name VARCHAR(100),
    Region VARCHAR(50),
    Product VARCHAR(100),
    Category VARCHAR(50),
    Quantity INT,
    Price INT,
    Sales INT );
    
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Cleaned_Sales_Dataset.csv'
INTO TABLE sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

ALTER TABLE sales
ADD COLUMN New_Order_Date DATE;

UPDATE sales
SET New_Order_Date = STR_TO_DATE(Order_Date,'%m/%d/%Y');

ALTER TABLE sales
DROP COLUMN Order_Date;

ALTER TABLE sales
CHANGE New_Order_Date Order_Date DATE;

ALTER TABLE sales
MODIFY COLUMN Order_Date DATE
AFTER Order_ID;

SELECT * FROM sales;
SELECT COUNT(*) FROM sales;

#Total Sales by Region
SELECT Region, SUM(Sales) AS Total_Sales
FROM sales
GROUP BY Region; 

#Top 5 Products
SELECT Product, SUM(Sales) AS Revenue
FROM sales
GROUP BY Product
ORDER BY Revenue DESC
LIMIT 5; 

#Monthly Sales Trend
SELECT MONTH(Order_Date) AS Month, SUM(Sales) AS Total_Sales
FROM sales
GROUP BY MONTH(Order_Date)
ORDER BY Month ASC; 

