/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/
-- Find the Total Sales -- 

Select
Sum(sales_amount) as Total_sales
from gold.fact_sales

-- Find how many items are sold

Select
Sum(quantity) as items_sold
from gold.fact_sales

-- Find the average selling price

Select
Avg(price) as avg_selling_price
from gold.fact_sales

-- Find the Total number of Orders

Select
Count(order_number) as Total_orders,
Count(distinct order_number) as Total_orders
from gold.fact_sales

-- Find the total number of products
SELECT COUNT(product_name) AS total_products FROM gold.dim_products

-- Find the total number of customers

Select
Count(customer_key) as Total_customers
from gold.dim_customers

-- Find the total number of customers that has placed an order

Select
Count(distinct customer_key) as total_customers
from gold.fact_sales

-- Generate a Report that shows all key metrics of the business


Select 'Total_Sales' as measure_name, SUM(sales_amount) as measure_value
from gold.fact_sales
Union all
Select 'Total_quantity' as measure_name, Sum(quantity) as measure_value
from gold.fact_sales
Union all 
Select 'Avg_Price' as measure_name, Avg(price) as measure_value
from gold.fact_sales
Union all 
Select 'Total_orders' as measure_name, Count(distinct order_number) as measure_value
from gold.fact_sales
Union all 
Select 'Total_products' as measure_name, COUNT(product_name) as measure_value
from gold.dim_products
Union all 
Select 'Total_customers' as measure_name, Count(customer_key) as measure_value
from gold.dim_customers
