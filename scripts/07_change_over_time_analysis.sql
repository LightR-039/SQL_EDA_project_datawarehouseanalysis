/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.
    - To track performance over time cumulatively.

SQL Functions Used:
    - Date Functions: DATEPART(), DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG(), OVER()
===============================================================================
*/


-- Quick Date Function
-- Sales perfprmance by year
SELECT
    YEAR(order_date) AS order_year,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customer,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date)

-- Sales performace by month
SELECT
    MONTH(order_date) AS order_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customer,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL 
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date)


-- CALCULATE THE TOTAL SALES PER MONTH
-- AND THE RUNNING TOTAL SALES OVER TIME
SELECT 
    order_date, 
    total_sales,
    SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales
FROM 
(
	SELECT 
	    DATETRUNC(MONTH,order_date) AS order_date,
	    SUM(sales_amount) AS total_sales
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(MONTH,order_date)
) t

-- Running total by year and moving avarage price
SELECT 
    order_date,
    total_sales,
    SUM(total_sales) OVER(ORDER BY order_date) AS running_total,
    AVG(avg_price) OVER(ORDER BY order_date) AS moving_avg_price
FROM 
(
    SELECT 
        DATETRUNC(YEAR, order_date) AS order_date,
        SUM(sales_amount) AS total_sales,
        AVG(price) AS avg_price
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(YEAR, order_date)
) t