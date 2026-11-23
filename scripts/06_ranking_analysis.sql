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

-- Which 5 products Generating the Highest Revenue?

-- Simple Ranking


Select TOP 5
p.product_name,
sum(f.sales_amount) as Total_revenue
from gold.fact_sales f
left join gold.dim_products p
on p.product_key = f.product_key
Group by p.product_name
Order by Total_revenue desc

-- Complex but Flexibly Ranking Using Window Functions
Select
*
from
(
Select
p.product_name,
sum(f.sales_amount) as Total_revenue,
Rank() over(Order by sum(f.sales_amount) desc) as Rank_products
from gold.fact_sales f
left join gold.dim_products p
on p.product_key = f.product_key
Group by p.product_name
) as Ranked_products
where rank_products<=5


-- What are the 5 worst-performing products in terms of sales?

Select
*
from
(
Select
p.product_name,
sum(f.sales_amount) as Total_revenue,
Rank() over(Order by sum(f.sales_amount) asc) as Rank_products
from gold.fact_sales f
left join gold.dim_products p
on p.product_key = f.product_key
Group by p.product_name
) as Ranked_products
where rank_products<=5


-- Find the top 10 customers who have generated the highest revenue


Select TOP 10
    c.customer_key,
    c.first_name,
    c.last_name,
sum(f.sales_amount) as Total_revenue
from gold.fact_sales f
left join gold.dim_customers c
    on c.customer_key = f.customer_key
    Group by c.customer_key,
    c.first_name,
    c.last_name
Order by Total_revenue desc

-- The 3 customers with the fewest orders placed

SELECT TOP 3
    c.customer_key,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY 
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_orders ;

