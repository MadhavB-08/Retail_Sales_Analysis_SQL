# 🛒 Retail Sales SQL Analysis Project

> A hands-on SQL project exploring a real-world retail dataset — uncovering revenue trends, customer behavior, product performance, and more using MySQL.

---

## 📌 Project Overview

This project dives deep into a retail sales dataset using SQL. The goal was to answer real business questions — things like *"Which product categories bring in the most revenue?"*, *"Who are our top-spending customers?"*, and *"Which cities drive the most sales?"*

The entire analysis was done in **MySQL**, working with a table called `retail_data_python` inside the `sales` database.

---

## 🗂️ Database Setup

```sql
CREATE DATABASE sales;
USE sales;
```

The main table used throughout this project is:

```
retail_data_python
```

It contains information about customers, their purchases, locations, product details, payment methods, shipping, and feedback.

---

## 🔍 Exploratory Data Analysis (EDA)

Before jumping into analysis, I took a look at the data to understand its structure.

```sql
-- Quick peek at the data
SELECT * FROM retail_data_python LIMIT 10;

-- Total number of records
SELECT COUNT(*) AS total_records FROM retail_data_python;

-- Table structure
DESC retail_data_python;

-- Unique product categories
SELECT DISTINCT product_category FROM retail_data_python;
```

---

## 🧹 Data Quality Checks

One of the most important steps in any data project — checking for missing or blank values across all key columns.

```sql
-- Checking for NULL and blank Customer IDs
SELECT
  COUNT(*) AS total_rows,
  COUNT(Customer_ID) AS rows_with_customer_id,
  COUNT(*) - COUNT(Customer_ID) AS null_customer_ids
FROM retail_data_python;

SELECT COUNT(*) AS blank_customer_ids FROM retail_data_python WHERE Customer_ID = '';
```

I also checked for blanks in:
- `name`, `email`, `phone`, `address`
- `city`, `country`
- `product_category`, `product_type`, `products`
- `shipping_method`, `payment_method`, `feedback`

**Amount Column Validation:**

```sql
SELECT
  COUNT(*) AS total_records,
  SUM(total_amount = 0) AS zero_amount_records,
  SUM(total_amount < 0) AS negative_amount_records,
  MIN(total_amount) AS lowest_amount,
  MAX(total_amount) AS highest_amount,
  ROUND(AVG(total_amount), 2) AS average_amount
FROM retail_data_python;
```

---

## 💰 Revenue Analysis

### Overall Revenue

```sql
-- Total revenue across all transactions
SELECT SUM(total_amount) AS total_revenue FROM retail_data_python;

-- Average transaction value
SELECT AVG(total_amount) AS average_amount FROM retail_data_python;
```

### Revenue by Product Category

```sql
SELECT product_category,
       SUM(total_amount) AS category_revenue
FROM retail_data_python
GROUP BY product_category
ORDER BY category_revenue DESC;
```

### Revenue by Brand

```sql
SELECT product_brand,
       SUM(total_amount) AS brand_revenue
FROM retail_data_python
WHERE product_brand != ''
GROUP BY product_brand
ORDER BY brand_revenue DESC
LIMIT 10;
```

### Revenue by Year & Month

```sql
-- Yearly Revenue Trend
SELECT year,
       SUM(total_amount) AS yearly_revenue
FROM retail_data_python
GROUP BY year
ORDER BY year;

-- Monthly Revenue (Best months first)
SELECT month,
       SUM(total_amount) AS monthly_revenue
FROM retail_data_python
GROUP BY month
ORDER BY monthly_revenue DESC;
```

---

## 📦 Product Performance

### Top Product Types by Transaction Count & Revenue

```sql
-- Most popular product types
SELECT product_type,
       COUNT(*) AS total_records
FROM retail_data_python
GROUP BY product_type
ORDER BY total_records DESC
LIMIT 10;

-- Top revenue-generating product types
SELECT product_type,
       SUM(total_amount) AS type_revenue
FROM retail_data_python
GROUP BY product_type
ORDER BY type_revenue DESC
LIMIT 10;
```

### Top 10 Products by Revenue

```sql
SELECT products,
       ROUND(SUM(CAST(total_amount AS DECIMAL(10,2))), 2) AS total_sales
FROM retail_data_python
WHERE product_category != ''
GROUP BY products
ORDER BY total_sales DESC
LIMIT 10;
```

### Product Category Deep Dive

```sql
-- Average, Max, and Min transaction values per category
SELECT
  product_category,
  COUNT(*) AS transaction_records,
  ROUND(AVG(total_amount), 2) AS average_transaction_values,
  ROUND(MAX(total_amount), 2) AS max_transaction_values,
  ROUND(MIN(total_amount), 2) AS min_transaction_values
FROM retail_data_python
WHERE Product_Category != ''
GROUP BY product_category
ORDER BY average_transaction_values DESC;
```

### Products Within Each Category

```sql
-- All products listed under their category with order counts
SELECT
  Product_Category,
  Products,
  COUNT(*) AS total_orders
FROM retail_data_python
WHERE Product_Category <> '' AND Products <> ''
GROUP BY Product_Category, Products
ORDER BY Product_Category, total_orders DESC;
```

---

## 🌍 Geographic Analysis

### Top Countries by Revenue

```sql
SELECT country,
       SUM(total_amount) AS country_revenue
FROM retail_data_python
GROUP BY country
ORDER BY country_revenue DESC;
```

### Top 10 Cities by Revenue

```sql
SELECT city,
       SUM(CAST(total_amount AS DECIMAL(10,2))) AS total_sales
FROM retail_data_python
WHERE city != ''
GROUP BY city
ORDER BY total_sales DESC
LIMIT 10;
```

### Top 10 States by Revenue

```sql
SELECT state,
       COUNT(*) AS total_transactions,
       ROUND(SUM(CAST(Total_Amount AS DECIMAL(10,2))), 2) AS total_sales
FROM retail_data_python
WHERE state <> ''
GROUP BY state
ORDER BY total_sales DESC
LIMIT 10;
```

### High-Volume Countries (1000+ Transactions)

```sql
SELECT Country,
       COUNT(*) AS total_transactions,
       ROUND(SUM(CAST(Total_Amount AS DECIMAL(10,2))), 2) AS total_sales
FROM retail_data_python
WHERE Country <> ''
GROUP BY Country
HAVING COUNT(*) > 1000
ORDER BY total_sales DESC
LIMIT 10;
```

---

## 👤 Customer Analysis

### Gender Distribution & Spending

```sql
-- Transaction count by gender
SELECT gender, COUNT(*) AS total_records
FROM retail_data_python
GROUP BY gender
ORDER BY total_records DESC;

-- Revenue by gender with average age
SELECT
  Gender,
  COUNT(*) AS total_transactions,
  ROUND(AVG(Age), 1) AS average_age,
  ROUND(SUM(CAST(Total_Amount AS DECIMAL(10,2))), 2) AS total_sales
FROM retail_data_python
WHERE Gender != ''
GROUP BY Gender
ORDER BY total_sales DESC;
```

### Age Group Analysis

```sql
SELECT
  CASE
    WHEN Age < 25 THEN 'Under 25'
    WHEN Age BETWEEN 25 AND 40 THEN '25-40'
    WHEN Age BETWEEN 41 AND 60 THEN '41-60'
    ELSE 'Above 60'
  END AS age_group,
  COUNT(*) AS total_transactions,
  ROUND(SUM(CAST(Total_Amount AS DECIMAL(10,2))), 2) AS total_sales
FROM retail_data_python
GROUP BY age_group
ORDER BY total_sales DESC;
```

### Top 10 High-Spending Customers

```sql
-- Customers with 5+ orders, ranked by spending
SELECT
  Customer_ID,
  COUNT(*) AS total_orders,
  ROUND(SUM(total_amount), 2) AS total_spent,
  ROUND(AVG(total_amount), 2) AS average_spent
FROM retail_data_python
WHERE Customer_ID IS NOT NULL
GROUP BY Customer_ID
HAVING COUNT(*) >= 5
ORDER BY total_spent DESC
LIMIT 10;
```

### Customers Spending 20,000+

```sql
SELECT customer_id,
       COUNT(*) AS total_records,
       ROUND(SUM(total_amount), 2) AS total_spent
FROM retail_data_python
WHERE customer_id IS NOT NULL
GROUP BY customer_id
HAVING SUM(total_amount) >= 20000
ORDER BY total_spent DESC;
```

### High-Value Transactions (Above 4,500)

```sql
SELECT
  Customer_ID,
  Products,
  Product_Category,
  CAST(Total_Amount AS DECIMAL(10,2)) AS purchase_amount
FROM retail_data_python
WHERE CAST(Total_Amount AS DECIMAL(10,2)) > 4500
ORDER BY purchase_amount DESC
LIMIT 10;
```

### Unique Customers per Category

```sql
SELECT
  Product_Category,
  COUNT(*) AS total_orders,
  COUNT(DISTINCT Customer_ID) AS unique_customers
FROM retail_data_python
WHERE Product_Category <> ''
GROUP BY Product_Category
ORDER BY unique_customers DESC
LIMIT 10;
```

---

## 💳 Payment Method Analysis

```sql
-- Transaction count by payment method
SELECT payment_method,
       COUNT(*) AS total_transactions
FROM retail_data_python
GROUP BY payment_method
ORDER BY total_transactions DESC;

-- Revenue and average spend by payment method
SELECT
  Payment_Method,
  COUNT(*) AS total_orders,
  ROUND(AVG(CAST(Total_Amount AS DECIMAL(10,2))), 2) AS average_purchase
FROM retail_data_python
WHERE Payment_Method <> ''
GROUP BY Payment_Method
ORDER BY average_purchase DESC;
```

---

## 🚚 Shipping Method Analysis

```sql
-- Orders by shipping method
SELECT shipping_method,
       COUNT(*) AS total_orders
FROM retail_data_python
GROUP BY shipping_method
ORDER BY total_orders DESC;

-- Revenue breakdown by shipping method
SELECT
  shipping_method,
  COUNT(*) AS total_orders,
  ROUND(SUM(CAST(Total_Amount AS DECIMAL(10,2))), 2) AS total_sales
FROM retail_data_python
WHERE shipping_method <> ''
GROUP BY shipping_method
ORDER BY total_sales DESC;
```

---

## 💬 Customer Feedback Analysis

```sql
-- Overall feedback distribution
SELECT Feedback,
       COUNT(*) AS feedback_count
FROM retail_data_python
GROUP BY Feedback
ORDER BY feedback_count DESC;

-- Which categories have the most "Bad" feedback?
SELECT Product_Category,
       COUNT(*) AS bad_feedback
FROM retail_data_python
WHERE Feedback = 'Bad'
GROUP BY Product_Category
ORDER BY bad_feedback DESC;
```

---

## 🏆 High-Value Order Analysis

```sql
-- Categories with high-value orders (>=4000) and 100+ such orders
SELECT
  Product_Category,
  COUNT(*) AS high_value_orders,
  ROUND(AVG(CAST(Total_Amount AS DECIMAL(10,2))), 2) AS average_purchase
FROM retail_data_python
WHERE CAST(Total_Amount AS DECIMAL(10,2)) >= 4000
GROUP BY Product_Category
HAVING COUNT(*) >= 100
ORDER BY high_value_orders DESC;

-- High-value orders (>=3000) split by gender
SELECT
  Gender,
  COUNT(*) AS high_value_orders,
  ROUND(AVG(CAST(Total_Amount AS DECIMAL(10,2))), 2) AS average_purchase
FROM retail_data_python
WHERE CAST(Total_Amount AS DECIMAL(10,2)) >= 3000
GROUP BY Gender
ORDER BY high_value_orders DESC;
```

---

## 🗃️ SQL Views Created

To make repeated queries easier, I created the following reusable views:

### 1. Category Sales Summary
```sql
CREATE VIEW category_sales_summary AS
SELECT
  Product_Category,
  SUM(CAST(Total_Amount AS DECIMAL(10,2))) AS total_sales
FROM retail_data_python
GROUP BY Product_Category;
```

### 2. Payment Sales Summary
```sql
CREATE VIEW payment_sales_summary AS
SELECT
  payment_method,
  COUNT(*) AS total_transactions,
  SUM(CAST(total_amount AS DECIMAL(10,2))) AS total_sales
FROM retail_data_python
GROUP BY payment_method;

-- Query the view
SELECT * FROM payment_sales_summary ORDER BY total_sales DESC;
```

### 3. Shipping Sales Summary
```sql
CREATE VIEW shipping_sales_summary AS
SELECT
  shipping_method,
  COUNT(*) AS total_transactions,
  SUM(CAST(total_amount AS DECIMAL(10,2))) AS total_sales
FROM retail_data_python
GROUP BY shipping_method;

-- Query the view
SELECT * FROM shipping_sales_summary ORDER BY total_sales DESC;
```

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| **MySQL** | Database & all SQL queries |
| **Python (pandas)** | Data was originally cleaned/prepared before loading |
| **SQL Views** | Reusable query abstractions |

---

## 📁 Project Structure

```
Retail-Sales-SQL-Project/
│
├── retail_sales_analysis.sql   ← All SQL queries used in this project
└── README.md                   ← You are reading it!
```

---

## 💡 Key Insights (What I Found)

- 📈 Revenue varied significantly across **product categories** — some categories clearly dominated
- 🌍 Certain **cities and countries** were major revenue drivers
- 👥 **Age groups 25–60** made up the bulk of transactions and revenue
- 💳 Different **payment methods** had noticeably different average order values
- ⭐ Some categories consistently received **bad feedback**, worth investigating further
- 🏆 A small group of **loyal customers** contributed disproportionately to total revenue

---

## 🚀 How to Run This Project

1. **Set up MySQL** on your local machine (or use MySQL Workbench)
2. **Import the dataset** into a table named `retail_data_python` inside a database called `sales`
3. **Open** `retail_sales_analysis.sql` in your SQL editor
4. **Run the queries** section by section to explore the data

```sql
CREATE DATABASE sales;
USE sales;
-- Then import your CSV data into retail_data_python table
-- Then run the analysis queries!
```

---

