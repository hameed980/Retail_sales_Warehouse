

# 🛒 Retail Sales Data Warehouse Using SQL and Python

This project simulates the role of a Data Engineer by designing and building a SQL-based Data Warehouse to transform messy retail sales data into a clean, analytics-ready format using star schema modeling. The data is automated into Microsoft SQL Server using Python and `pyodbc`.

## 🔍 Key Objectives
- Normalize raw retail sales data from CSVs into dimensional models.
- Apply **Star Schema** to support efficient business analysis.
- Automate ETL using Python and load data into Microsoft SQL Server.
- Enable analysis of sales by region, product, and customer segment over time.

## 🧱 Schema Overview

| Table Name      | Description                                     |
|------------------|-------------------------------------------------|
| `staging_sales`  | Raw retail sales data from CSV                 |
| `dim_customer`   | Customer details                                |
| `dim_product`    | Product and category information                |
| `dim_region`     | Geographic location (city, state, country)      |
| `dim_date`       | Calendar dates and attributes                   |
| `fact_sales`     | Sales metrics (quantity, sales, profit) linked to all dimensions |

## 🏢 Real-World Scenario

A retail company wants to analyze sales performance across different regions, product categories, and customer segments. This backend enables such analytics by storing sales data in a well-structured, query-efficient data warehouse format.

## ⚙️ Tools & Technologies

- **SQL Server** (Database & Data Warehouse)
- **Python** (ETL Automation)
- **Pandas** (Data Transformation)
- **pyodbc** (SQL Server Connectivity)
