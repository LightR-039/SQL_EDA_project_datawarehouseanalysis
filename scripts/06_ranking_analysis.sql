/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/

-- WHICH 5 PRODUCTS GENERATE THE HIGHEST REVENUE
SELECT TOP 5
p.product_name, SUM(f.sales_amount) AS total_sales
FROM gold.fact_sales f 
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_sales DESC
-- Ranking Using Window Functions
SELECT *
FROM (
    SELECT
        p.product_name,
        SUM(f.sales_amount) AS total_revenue,
        RANK() OVER (ORDER BY SUM(f.sales_amount) DESC) AS rank_products
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON p.product_key = f.product_key
    GROUP BY p.product_name
) AS ranked_products
WHERE rank_products <= 5

-- WHAT ARE THE 5 WORST PERFORMING PRODUCT IN TERM OF SALES
SELECT TOP 5
p.product_name, SUM(f.sales_amount) AS total_sales
FROM gold.fact_sales f 
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_sales ASC

-- WHAT ARE THE TOP 5 SPENDING CUSTOMER
SELECT TOP 5
    c.customer_key,
    c.customer_number,
    CONCAT(c.first_name,' ', c.last_name) AS customer_name,
    SUM(f.sales_amount) AS total_spending
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY 
    c.customer_key,
    c.customer_number,
    CONCAT(c.first_name,' ', c.last_name)
ORDER BY total_spending DESC

-- WHAT ARE THE TOP 5 CUSTOMERS HAVE THE MOST ORDER
SELECT TOP 5
    c.customer_key,
    c.customer_number,
    CONCAT(c.first_name,' ', c.last_name) AS customer_name,
    COUNT(DISTINCT order_number) AS total_order
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY 
    c.customer_key,
    c.customer_number,
    CONCAT(c.first_name,' ', c.last_name)
ORDER BY total_order DESC