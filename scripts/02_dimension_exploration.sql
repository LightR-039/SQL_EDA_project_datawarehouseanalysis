/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/

-- EXPLORE ALL THE COUNTRIES OUR CUSTOMERS COME FROM

SELECT DISTINCT country FROM gold.dim_customers	

-- EXPLORE ALL THE CATEGORIES "THE MAJOR DIVISIONS"

SELECT DISTINCT category FROM gold.dim_products

SELECT DISTINCT category, subcategory, product_name FROM gold.dim_products
ORDER BY 1,2,3