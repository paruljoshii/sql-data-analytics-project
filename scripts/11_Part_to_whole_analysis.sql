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

WITH category_sales AS
(
Select
p.category,
Sum(f.sales_amount) as total_sales
from gold.fact_sales f
left join gold.dim_products p
on p.product_key = f.product_key
Group by p.category
)

Select
category,
total_sales,
Sum(total_Sales) over() as overall_sales,
ROUND(CAST(total_sales as float)/sum(total_Sales) over() * 100,2) as percentage_of_total
from category_Sales
ORDER BY total_sales DESC;