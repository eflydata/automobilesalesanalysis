# Auto Sales SQL Analysis Project

## Overview

This project contains a relational database schema and a set of analytical SQL queries designed to explore sales performance for an auto sales business. It focuses on extracting insights such as top-performing products, customer segmentation, and geographic distribution of customers.

---

## Project Structure

```
.
├── db_setup.sql     # Database schema and table creation
└── analysis.sql     # Analytical SQL queries
```

---

## Database Schema (`db_setup.sql`)

The database is named `auto_sales` and includes the following tables:

### 1. `product_lines`

* Stores categories of products
* Fields:

  * `product_line_id` (PK)
  * `product_line`

### 2. `products`

* Stores individual products
* Fields:

  * `product_code` (PK)
  * `product_line_id` (FK)
  * `msrp`

### 3. `customers`

* Stores customer information
* Fields include:

  * `customer_id` (PK)
  * `customer_name`
  * Contact and address details

### 4. `orders`

* Stores order-level data
* Fields:

  * `order_number` (PK)
  * `customer_id` (FK)
  * `order_date`
  * `status`

### 5. `order_items`

* Stores line-item details for each order
* Fields:

  * `order_item_id` (PK)
  * `order_number` (FK)
  * `product_code` (FK)
  * `quantity_ordered`
  * `price_each`
  * `sales`
  * `deal_size`

---

## Analysis Queries (`analysis.sql`)

The project includes several business-focused SQL queries:

### Revenue Analysis

* Identify products generating the most revenue
* Rank products by revenue contribution

### Product Performance

* Determine most frequently ordered products
* Analyze total quantity sold per product

### Customer Insights

* Identify the top 20% of customers by revenue (Pareto principle)
* Rank customers based on spending

### Geographic Insights

* Find countries with the highest number of customers
* Identify top cities by customer count

### Product Line Performance

* Analyze which product lines generate the most revenue
* Rank product lines accordingly

---

## How to Use

1. **Set up the database**

   ```sql
   SOURCE db_setup.sql;
   ```

2. **Run analysis queries**

   ```sql
   SOURCE analysis.sql;
   ```

3. Use a SQL client such as MySQL Workbench, DBeaver, or any compatible tool.

---

## Key Concepts Used

* Aggregations (`SUM`, `COUNT`)
* Window functions (`RANK`, `NTILE`)
* Common Table Expressions (CTEs)
* Joins (INNER, LEFT)
* Data grouping and ranking

---

## Purpose

This project is ideal for:

* Practicing SQL for data analysis
* Understanding relational database design
* Demonstrating business intelligence queries
* Portfolio projects for data analysts

---

## Notes

* Ensure your SQL environment supports window functions (e.g., MySQL 8+)
* Data population scripts are not included and should be added separately

---

## Future Improvements

* Add sample dataset for testing
* Create dashboards (e.g., Tableau, Power BI)
* Optimize queries for large-scale datasets

---
