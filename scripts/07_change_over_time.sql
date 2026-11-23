/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: DATEPART(), DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/



-- Analyse sales performance over time
-- Quick Date Functions

Select
Year(order_date) as order_year,
Month(order_date) as order_month,
Count(Distinct customer_key) as total_customers,
Sum(quantity) as total_quantity,
Sum(sales_amount) as total_sales
from gold.fact_sales 
where order_date is NOT NULL
Group by Year(order_date), Month(order_date)
Order by Year(order_date), Month(order_date);

-- DATETRUNC()

Select
Datetrunc(month,order_date) as order_year,
Count(Distinct customer_key) as total_customers,
Sum(quantity) as total_quantity,
Sum(sales_amount) as total_sales
from gold.fact_sales 
where order_date is NOT NULL
Group by Datetrunc(month,order_date)
Order by Datetrunc(month,order_date);


-- FORMAT()

Select
Format(order_date, 'yyyy-MMM') as order_Date,
Count(Distinct customer_key) as total_customers,
Sum(quantity) as total_quantity,
Sum(sales_amount) as total_sales
from gold.fact_sales 
where order_date is NOT NULL
Group by Format(order_date, 'yyyy-MMM')
Order by Format(order_date, 'yyyy-MMM');
