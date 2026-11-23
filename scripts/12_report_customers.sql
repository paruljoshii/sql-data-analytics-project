/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
	   - total orders
	   - total sales
	   - total quantity purchased
	   - total products
	   - lifespan (in months)
    4. Calculates valuable KPIs:
	    - recency (months since last order)
		- average order value
		- average monthly spend
===============================================================================
*/
IF OBJECT_ID('gold.report_customers', 'V') IS NOT NULL
    DROP VIEW gold.report_customers;
GO

CREATE VIEW gold.report_customers AS



WITH base_query AS(
/*---------------------------------------------------------------------------
1) Base Query: Retrieves core columns from tables
---------------------------------------------------------------------------*/

Select
	f.order_number,
	f.product_key,
	f.order_date,
	f.sales_amount,
	f.quantity,
	c.customer_number,
	c.customer_key,
	CONCAT(c.first_name, ' ', c.last_name) as customer_name,
	c.birthdate,
	DATEDIFF(year, birthdate, getdate()) as age
from gold.fact_sales f
	left join gold.dim_customers c
	on c.customer_key = f.customer_key
WHERE order_date IS NOT NULL),

customer_aggregation AS

/*---------------------------------------------------------------------------
2) Customer Aggregations: Summarizes key metrics at the customer level
---------------------------------------------------------------------------*/
(
Select
	customer_key,
	customer_number,
	customer_name,
	age,
	count(distinct order_number) as total_orders,
	sum(sales_amount) as total_sales,
	sum(quantity) as total_quantity,
	Count( distinct product_key) as total_products,
	MIN(order_date) as first_order_date,
	MAX(order_Date) as last_order_date,
	DATEDIFF(month, MIN(order_date), MAX(order_date)) as lifespan
from base_query
GROUP BY 
	customer_key,
	customer_number,
	customer_name,
	age
)

Select
	customer_key,
	customer_number,
	customer_name,
	age,
		CASE
		  when age<20 then 'Below 20'
		  When age between 20 and 29 then '20-29'
		  When age between 30 and 39 then '29-40'
		  When age between 40 and 49 then '40-49'
		  else 'above 50'

		END as age_group,

		CASE 
		   when lifespan >=12 and total_sales>5000 then 'VIP'
		   when lifespan >=12 and total_Sales<5000 then 'Regular'
		   else 'NEW'
		END as customer_segment,
	last_order_date,
	Datediff(month, last_order_date, getdate()) as recency,
	total_orders,
	total_sales,
	total_quantity,
	total_products
	lifespan,
	-- Compuate average order value (AVO)
	CASE when total_Sales = 0 then 0
	Else Total_sales/total_orders
	END AS avg_order_value,
	-- Compuate average monthly spend
	CASE
	  when lifespan = 0 then total_sales
	  else total_sales/lifespan
	END as avg_monthly_spend
FROM customer_aggregation
