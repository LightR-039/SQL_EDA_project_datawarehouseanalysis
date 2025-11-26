# 📊 SQL Exploratory Data Analysis (EDA) Project

## 📌 Overview
SQL-powered EDA on a relational database to drive business decisions. Features complex queries (CTEs, window functions, joins), customer RFM & cohort analysis, sales trends, YoY growth, and top performers. 

## 💡 Key Objectives
- Clean and prepare raw data entirely using SQL techniques
- Uncover actionable insights on sales performance, customer behavior, and product trends from a relational database
- Leverage SQL features including aggregations, joins, window functions, and CTEs

## 🏗️ Database Schema
The dataset consists of multiple relational tables, including:
- **Customers**: Contains customer information (ID, Name, Location, etc.).
- **Products**: Stores product details (ID, Name, Category, Price, Cost etc.).
- **Sales**: Links orders and products to track revenue and quantity sold.

## 🔍 Key Analyses
### 1️⃣ Sales Analysis
- Total revenue, average order value, and monthly revenue trends.
- Year over year sales performance.
- Contributions of products and categories to total revenue.

### 2️⃣ Customer Insights
- Customer retention and churn analysis.
- customer segmentation by age and spending.
- Purchase frequency and order trends.

### 3️⃣ Product Performance
- Products and catefories performance ranking.
- Stock and inventory turnover analysis.
- Product category-wise sales breakdown.

## 🛠️ SQL Techniques Used
- **Aggregate Functions** (`SUM`, `AVG`, `COUNT`, `MAX`, `MIN`)
- **Joins** (`INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`)
- **Window Functions** (`ROW_NUMBER()`, `RANK()`, `DENSE_RANK()`, `LAG()`)
- **Common Table Expressions (CTEs)**
- **Subqueries and Nested Queries**
- **Group By & Having Clauses**
- **Case Statements for Conditional Analysis**

## 📂 Project Structure
```
📦 SQL-EDA-Project
 ┣ 📜 queries.sql  # Collection of SQL queries for EDA
 ┣ 📜 dataset.csv  # Sample dataset (if applicable)
 ┣ 📜 README.md    # Project documentation
```

## 🚀 How to Run
1. **Clone the repository**
   ```bash
   git clone https://github.com/LightR-039/SQL_EDA_project_datawarehouseanalysis.git
   cd     SQL_EDA_project_datawarehouseanalysis
2. Load the dataset into your SQL Server Management Studio
   **OR**
   Run this file from scripts → [scripts/00_init_database.sql](./scripts/00_init_database.sql)
3. Run the SQL queries from [scripts](./scripts) to explore the dataset and extract insights.

## 🔗 Future Enhancements
- Integrate with **Power BI/Tableau** for interactive visualizations.
- Automate SQL queries using **Python scripts.**
- Expand analysis with **predictive analytics** using machine learning.

## 🤝 Contributing
Feel free to fork the repository and submit **pull requests** for improvements! Suggestions and collaborations are welcome. 🚀

## 📜 License
This project is licensed under the **MIT License**.

---
💡 *If you found this project helpful, consider giving it a ⭐ on GitHub!*
