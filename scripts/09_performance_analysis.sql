/*
===============================================================================
Performance Analysis (Year-over-Year, Month-over-Month)
===============================================================================
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.

SQL Functions Used:
    - LAG(): Accesses data from previous rows.
    - AVG() OVER(): Computes average values within partitions.
    - CASE: Defines conditional logic for trend analysis.
===============================================================================
*/


/* Analyze the yearly performance of products by comparing their sales 
to both the average sales performance of the product and the previous year's sales */

WITH yearly_product_sales AS(
Select
    Year(f.order_date) as order_year,
    p.product_name,
    Sum(f.sales_amount) as current_sales
from gold.fact_sales f
left join gold.dim_products p
   on p.product_key = f.product_key
   where f.order_date is not NULL
Group by    
   Year(f.order_date), p.product_name
)

Select
order_year,
product_name,
current_Sales,
Avg(current_Sales) over(partition by product_name) as Avg_sales,
current_sales - Avg(current_Sales) over(partition by product_name) as avg_diff,
CASE 
  When current_sales - Avg(current_Sales) over(partition by product_name) > 0 then 'Above avg'
  When current_sales - Avg(current_Sales) over(partition by product_name) < 0 then 'Below_avg'
  Else 'Avg'

END as avg_change,
    -- Year-over-Year Analysis
LAG(current_sales) over(partition by product_name order by order_year) as py_Sales,
current_sales - LAG(current_sales) over(partition by product_name order by order_year) as diff_py,

CASE
  When current_sales - LAG(current_sales) over(partition by product_name order by order_year) > 0 then 'Increase'
  When current_sales - LAG(current_sales) over(partition by product_name order by order_year) < 0 then 'Decrease'
  else 'No_change'
END as py_change

from yearly_product_sales
Order by product_name,order_year


