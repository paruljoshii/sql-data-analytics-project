/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/



-- Determine the first and last order date and the total duration in months

Select
Min(order_date) as first_order_date,
Max(order_date) as last_order_date,
DATEDIFF(Month, Min(Order_date), Max(order_date)) as order_range_months
from gold.fact_sales



-- Find the youngest and oldest customer based on birthdate

Select
Min(birthdate) as oldest_birthdate,
DATEDIFF(YEAR, Min(birthdate), Getdate()) as oldest_age,
Max(birthdate) as youngest_birthdate,
DATEDIFF(YEAR, Max(birthdate), Getdate()) as youngest_age
from gold.dim_customers