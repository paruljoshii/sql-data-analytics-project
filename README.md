# 📊 SQL Data Analytics & Business Intelligence Project

Welcome to the **SQL Data Analytics Project** repository! This project demonstrates end-to-end exploratory data analysis (EDA) and advanced business intelligence reporting using **SQL Server (T-SQL)**. It transforms raw transactional data from a Data Warehouse (`gold` schema) into actionable business insights across sales, products, and customer behavior.

---

## 🎯 Project Objectives
- **Explore Data Structure:** Understand database schemas, table relationships, dimensions, and key business metrics.
- **Analyze Trends Over Time:** Track yearly and monthly sales performance, customer acquisition, and order volumes.
- **Measure Cumulative Growth:** Calculate running totals and moving averages to evaluate long-term business momentum.
- **Evaluate Product Performance:** Benchmark yearly product sales against historical averages and prior-year performance (YoY).
- **Segment Customers & Products:** Categorize products by cost ranges and group customers into tiers (`VIP`, `Regular`, `New`) based on spending behavior and lifespan.
- **Build Consolidated Reports:** Create reusable SQL Views (`gold.report_customers`, `gold.report_products`) for BI tools like Power BI or Tableau.

---

## 🗂️ Repository Structure

```text
sql-data-analytics-project/
│
├── 01_database_exploration.sql       # Schema, tables, and columns inspection
├── 02_dimensions_exploration.sql     # Distinct countries, categories, and product hierarchies
├── 03_date_range_exploration.sql     # Order timelines and customer age boundaries
├── 04_measures_exploration.sql       # Core KPIs (Total Sales, Quantity, Avg Price, Active Customers)
├── 05_magnitude_analysis.sql         # Metric breakdowns by country, gender, and category
├── 06_ranking_analysis.sql           # Top & bottom performing products and customers
├── 07_change_over_time_analysis.sql  # Yearly and monthly sales & customer growth trends
├── 08_cumulative_analysis.sql        # Running total sales and moving average prices
├── 09_performance_analysis.sql       # YoY comparison and average sales benchmarking
├── 10_part_to_whole_analysis.sql     # Category percentage contribution to overall revenue
├── 11_data_segmentation.sql          # Cost-based product tiers and customer loyalty segments
├── 12_customer_report.sql            # Final consolidated Customer Analytics View
└── 13_product_report.sql             # Final consolidated Product Analytics View
```

---

## 🛠️ SQL Techniques & Concepts Used
- **Common Table Expressions (CTEs):** Modularizing complex multi-step transformations for readability.
- **Window Functions:** `LAG()`, `AVG() OVER()`, `SUM() OVER()`, `RANK()`, and `DENSE_RANK()` for period-over-period comparisons and cumulative metrics.
- **Data Aggregation & Grouping:** `GROUP BY`, `SUM()`, `COUNT(DISTINCT)`, `AVG()`, `MIN()`, `MAX()`.
- **Conditional Logic:** `CASE WHEN` statements for dynamic customer and product segmentation.
- **Date & Time Manipulation:** `YEAR()`, `MONTH()`, `DATETRUNC()`, `DATEDIFF()` for cohort and lifespan calculations.
- **Joins & Views:** `LEFT JOIN` across star-schema tables (`gold.fact_sales`, `gold.dim_products`, `gold.dim_customers`) and `CREATE VIEW` for reporting readiness.

---



## 👤 Author
**Parul Joshi**  
- GitHub: [@paruljoshii](https://github.com)
