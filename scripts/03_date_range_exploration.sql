/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/


-- FIND THE DATE OF FIRST AND LAST ORDER

SELECT order_date FROM gold.fact_sales

SELECT 
    MIN(order_date) AS First_order_date, 
    MAX(order_date) AS Last_order_date,
    DATEDIFF(year, MIN(order_date), MAX(order_date)) AS order_range_years,
    DATEDIFF(month, MIN(order_date), MAX(order_date)) AS order_range_months
FROM gold.fact_sales

-- FIND THE YOUNGEST AND THE OLDEST CUSTOMERS

SELECT 
    MIN(birthdate) AS oldest_customer,
    DATEDIFF(year, MIN(birthdate), GETDATE()) AS oldest_age,
    MAX(birthdate) AS yongest_customer,
    DATEDIFF(year, MAX(birthdate), GETDATE()) AS youngest_age
FROM gold.dim_customers
