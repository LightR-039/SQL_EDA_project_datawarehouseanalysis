/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
    - UNION
===============================================================================
*/

-- FIND THE TOTAL SAlES
SELECT SUM(sales_amount) AS total_sales FROM gold.fact_sales

-- FIND HOW MANY ITEMS ARE SOLD
SELECT SUM(quantity) AS sold_items FROM gold.fact_sales

-- FIND THE TOTAL NUMBERS OF ORDERS
SELECT COUNT(DISTINCT order_number) as total_order FROM gold.fact_sales

-- FIND THE AVG SELLING PRICE
SELECT AVG(price) AS avarage_price FROM gold.fact_sales

-- FIND THE TOTAL NUMBERS OF PRODUCTS
SELECT COUNT(DISTINCT product_name) AS total_product FROM gold.dim_products

-- FIND THE TOTAL NUMBERS OF CUSTOMERS
SELECT COUNT(customer_id) AS total_customers FROM gold.dim_customers

-- FIND THE TOTAL NUMBERS OF CUSTOMERS THAT HAS PLACED AN ORDER 
SELECT COUNT(DISTINCT customer_key) AS total_customers_have_ordered FROM gold.fact_sales

-- REPORT TO SHOW ALL METRICS
SELECT 'Total sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total_items_sold' AS measure_name, SUM(quantity) AS sold_items FROM gold.fact_sales
UNION ALL
SELECT 'Total_orders' AS measure_name, COUNT(DISTINCT order_number) as total_order FROM gold.fact_sales
UNION ALL
SELECT 'AVG_price' AS measure_name, AVG(price) AS avarage_price FROM gold.fact_sales
UNION ALL
SELECT 'Total_products' AS measure_name, COUNT(DISTINCT product_name) AS total_product FROM gold.dim_products
UNION ALL
SELECT 'Total_customers' AS measure_name, COUNT(customer_id) AS total_customers FROM gold.dim_customers
UNION ALL
SELECT 'Total_ordered_customers' AS measure_name, COUNT(DISTINCT customer_key) AS total_customers_have_ordered FROM gold.fact_sales
