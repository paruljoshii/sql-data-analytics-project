/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/


-- Calculate the total sales per month 
-- and the running total of sales over time 

Select
    Order_date,
    total_sales,
    Sum(total_Sales) over(Order by order_date) as running_total_sales,
    Sum(avg_price) over(Order by order_date) as moving_avg_price
from
(
    Select
    Datetrunc(year, order_date) as order_Date,
    Sum(sales_amount) as total_Sales,
    Avg(price) as avg_price
    from gold.fact_sales
    where order_date is not NULL
    Group by Datetrunc(year, order_date)
)t