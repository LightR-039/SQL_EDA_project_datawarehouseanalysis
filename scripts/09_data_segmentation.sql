/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis.

SQL Functions Used:
    - CASE: Defines custom segmentation logic.
    - GROUP BY: Groups data into segments.
===============================================================================
*/

/*Segment products into cost ranges and 
count how many products fall into each segment*/
WITH products_segments_table AS (
SELECT 
	product_key,
	product_name,
	cost,
	CASE
		WHEN cost < 100 THEN 'below 100'
		WHEN cost BETWEEN 100 AND 500 THEN '100-500'
		WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
		WHEN cost BETWEEN 1000 AND 1500 THEN '1000-1500'
		ELSE 'above 1500' 
	END cost_range
FROM gold.dim_products
)

SELECT
	cost_range,
	COUNT(product_key) AS total_products
FROM products_segments_table
GROUP BY cost_range
ORDER BY total_products DESC

/*Group customers into three segments based on their spending behavior:
	- VIP: Customers with at least 12 months of history and spending more than €5,000.
	- Regular: Customers with at least 12 months of history but spending €5,000 or less.
	- New: Customers with a lifespan less than 12 months.
And find the total number of customers by each group
And how much spending total in each group
*/
WITH customer_table AS (
SELECT
	c.customer_id,
	SUM(f.sales_amount) AS total_sales,
	MIN(f.order_date) AS first_order,
	MAX(f.order_date) AS last_order,
	DATEDIFF(MONTH, MIN(f.order_date), MAX(f.order_date)) AS lifespan,
	CASE	
		WHEN SUM(f.sales_amount) > 5000 AND DATEDIFF(MONTH, MIN(f.order_date), MAX(f.order_date)) >= 12 THEN 'VIP'
		WHEN SUM(f.sales_amount) <= 5000 AND DATEDIFF(MONTH, MIN(f.order_date), MAX(f.order_date)) >= 12 THEN 'Regular'
		ELSE 'New'
	END customers_type
FROM gold.fact_sales f
INNER JOIN gold.dim_customers c
	ON f.customer_key = c.customer_key
GROUP BY c.customer_id
)

SELECT 
	customers_type,
	COUNT(DISTINCT customer_id) AS total_customer,
	SUM(total_sales) AS total_spending
FROM customer_table
GROUP BY customers_type
ORDER BY total_customer DESC