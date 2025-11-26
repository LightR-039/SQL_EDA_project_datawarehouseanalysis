/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - To compare performance or metrics across dimensions or time periods.
    - To evaluate differences between categories.
    - Useful for A/B testing or regional comparisons.

SQL Functions Used:
    - SUM(), AVG(): Aggregates values for comparison.
    - Window Functions: SUM() OVER() for total calculations.
===============================================================================
*/

-- Which categories contribute the most to overall sales?
WITH category_sales AS (
SELECT
p.category,
SUM(f.sales_amount) AS total_sales,
SUM(f.quantity) AS total_quantity
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY p.category
)

SELECT 
category,
total_sales,
SUM(total_sales) OVER() AS overall_sales,
CONCAT(ROUND(CAST(total_sales AS FLOAT) / SUM(total_sales) OVER() * 100,2), ' ','%') AS pct
FROM category_sales
ORDER BY total_sales DESC


--- Which category contribute the most to total order
WITH category_total_order AS (
SELECT
p.category,
COUNT(DISTINCT order_number) AS total_order
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY p.category
)

SELECT 
category,
total_order,
SUM(total_order) OVER() AS overall_order,
CONCAT(ROUND(CAST(total_order AS FLOAT) / SUM(total_order) OVER() * 100,2), ' ','%') AS pct
FROM category_total_order
ORDER BY total_order DESC
