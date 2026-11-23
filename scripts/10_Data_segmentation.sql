/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis.

SQL Functions Used:
    - CASE: Defines custom segmentation logic.
    - GROUP BY: Groups data into segments.
===============================================================================
*/

/*Segment products into cost ranges and 
count how many products fall into each segment*/

WITH product_segments AS
(
Select
product_key,
product_name,
cost,
CASE
  when cost < 100 then 'Below 100'
  when cost between 100 and 500 then '100-500'
  when cost between 500 and 1000 then '500-1000'
  Else 'Above 1000'
END as cost_range
from gold.dim_products
)

Select 
cost_range,
count(product_key) as total_products
from product_segments
GROUP BY cost_range
ORDER BY total_products DESC;


/*Group customers into three segments based on their spending behavior:
	- VIP: Customers with at least 12 months of history and spending more than â‚¬5,000.
	- Regular: Customers with at least 12 months of history but spending â‚¬5,000 or less.
	- New: Customers with a lifespan less than 12 months.
And find the total number of customers by each group
*/


WITH customer_spending AS
(
Select
c.customer_key,
Sum(f.sales_amount) as total_spending,
MIN(order_date) as first_order_date,
MAX(order_date) as last_order_date,
DATEDIFF(month, MIN(order_date), MAX(order_date)) as lifespan
from gold.fact_sales f
left join gold.dim_customers c
on c.customer_key = f.customer_key
Group by c.customer_key
)

Select
count(customer_key) as total_customers,
customer_segment
from
(
Select
customer_key,
CASE
  when lifespan >=12 and total_spending > 5000 then 'VIP'
  when lifespan >=12 and total_spending < 5000 then 'Regular'
  Else 'NEW'

END as customer_segment

from customer_spending
) segmented_customers

GROUP BY customer_segment
ORDER BY total_customers DESC;