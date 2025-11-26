/*
===============================================================================
Product Report
===============================================================================
Purpose:
    - This report consolidates key product metrics and behaviors.

Highlights:
    1. Gathers essential fields such as product name, category, subcategory, and cost.
    2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
    3. Aggregates product-level metrics:
       - total orders
       - total sales
       - total quantity sold
       - total customers (unique)
       - lifespan (in months)
    4. Calculates valuable KPIs:
       - recency (months since last sale)
       - average order revenue (AOR)
       - average monthly revenue
===============================================================================
*/
-- =============================================================================
-- Create Report: gold.report_products
-- =============================================================================

CREATE VIEW gold.report_products AS
WITH base_query AS (
SELECT 
	f.order_number,
	f.order_date,
	f.product_key,
	f.sales_amount,
	f.customer_key,
	f.quantity,
	p.product_number,
	p.product_name,
	p.category,
	p.subcategory,
	p.cost
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p 
	ON f.product_key = p.product_key
WHERE order_date IS NOT NULL
)
, aggregation_query AS(
SELECT 
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	COUNT(DISTINCT order_number) AS total_order,
	SUM(sales_amount) AS total_sales,
	ROUND(AVG(CAST(sales_amount AS FLOAT) / NULLIF(quantity,0)), 2) AS avg_selling_price,
	SUM(quantity) AS total_quantity,
	COUNT(DISTINCT customer_key) AS total_customer,
	MAX(order_date) AS last_order_date,
	DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan
FROM base_query
GROUP BY
	product_key,
	product_name,
	category,
	subcategory,
	cost 
) 

SELECT
	product_key,
	product_name,
	category,
	subcategory,
	total_order,
	CASE 
		WHEN total_order = 0 THEN 0
		ELSE ROUND(CAST(total_sales AS FLOAT) / total_order, 2)
	END AS avg_order_sales,
	avg_selling_price,
	total_sales,
	CASE	
		WHEN total_sales >= 50000 THEN 'High performer'
		WHEN total_sales >= 10000 THEN 'Mid range'
		ELSE 'Low performer'
	END AS product_segments,
	total_customer,
	total_quantity,
	last_order_date,
	lifespan,
	DATEDIFF(MONTH, last_order_date, GETDATE()) AS recency,
	CASE 
		WHEN lifespan = 0 THEN 0
		ELSE ROUND(CAST(total_sales AS FLOAT) / lifespan,2)
END AS avg_monthly_sales
FROM
aggregation_query