/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
	   - total orders
	   - total sales
	   - total quantity purchased
	   - total products
	   - lifespan (in months)
    4. Calculates valuable KPIs:
	    - recency (months since last order)
		- average order value
		- average monthly spend
===============================================================================
*/

-- =============================================================================
-- Create Report: gold.report_customers
-- =============================================================================

CREATE VIEW gold.report_customers AS
WITH base_query AS (
SELECT 
	c.customer_id,
	c.customer_number,
	CONCAT(c.first_name,' ',c.last_name) AS customer_name,
	DATEDIFF(YEAR, c.birthdate,GETDATE()) AS age,
	f.order_number,
	f.product_key,
	f.order_date,
	f.sales_amount,
	f.quantity
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
	ON f.customer_key = c.customer_key
WHERE order_date IS NOT NULL
)

, aggegration_query AS (
SELECT 
	customer_id,
	customer_number,
	customer_name,
	age,
	COUNT(DISTINCT product_key) AS total_product,
	MAX(order_date) AS last_order,
	DATEDIFF(MONTH, MAX(order_date), GETDATE()) AS recency,
	DATEDIFF(MONTH,MIN(order_date), MAX(order_date)) AS lifespan,
	SUM(sales_amount) AS total_spending,
	SUM(quantity) AS total_quantity,
	COUNT(DISTINCT order_number) AS total_order
FROM base_query
GROUP BY 
	customer_id,
	customer_number,
	customer_name,
	age
)

SELECT 
	customer_id,
	customer_number,
	customer_name,
	CASE
		WHEN lifespan >= 12 AND total_spending >= 5000 THEN 'VIP'
		WHEN lifespan >= 12 AND total_spending < 5000 THEN 'Regular'
		ELSE 'New'
	END customer_segments,
	age,
	CASE
		WHEN age < 20 THEN 'Below 20'
		WHEN age BETWEEN 20 AND 30 THEN '20-30'
		WHEN age BETWEEN 30 AND 40 THEN '30-40'
		WHEN age BETWEEN 40 AND 50 THEN '40-50'
		ELSE 'Above 50'
	END AS age_group,
	total_spending,
	CASE	
		WHEN lifespan = 0 THEN 0
		ELSE total_spending / lifespan
	END AS avg_monthly_spending,
	total_quantity,
	total_order,
	CASE 
		WHEN total_order = 0 THEN 0
		ELSE total_spending / total_order 
	END AS avg_order_value,
	total_product,
	last_order,
	recency,
	lifespan
FROM aggegration_query

