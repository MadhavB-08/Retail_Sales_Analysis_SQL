CREATE DATABASE sales;
use sales;

SELECT *
FROM retail_data_python
LIMIT 10;


SELECT COUNT(*) AS total_records
FROM sales.retail_data_python;


Desc sales.retail_data_python;

SELECT *
FROM retail_data_python
LIMIT 10;

select distinct product_category
from retail_data_python;

use sales;
select product_category,
count(*) as total_records
from retail_data_python
group by product_category
order by total_records desc;

select *
from retail_data_python
limit 1;

select sum(total_amount) as total_revenue
from retail_data_python;

select avg(total_amount) as average_amount
from retail_data_python;

select product_category,
sum(total_amount) as category_revenue
from retail_data_python
group by product_category
order by category_revenue desc;

select product_brand,
sum(total_amount) as brand_revenue
from retail_data_python
group by product_brand
order by brand_revenue desc;

select year,
sum(total_amount) as yearly_revenue
from retail_data_python
group by year
order by year;

select month,
sum(total_amount) as monthly_revenue
from retail_data_python
group by month
order by monthly_revenue desc;

select product_type,
count(*) as total_records
from retail_data_python
group by product_type
order by total_records desc
limit 10;

select product_type,
sum(total_amount) as type_revenue
from retail_data_python
group by product_type
order by type_revenue desc
limit 10;

select payment_method,
count(*) as total_transactions
from retail_data_python
group by payment_method
order by total_transactions desc;

select payment_method,
sum(total_amount) as payment_revenue
from retail_data_python
group by payment_method
order by payment_revenue desc;

select country,
sum(total_amount) as country_revenue
from retail_data_python
group by country
order by country_revenue;

select city,
sum(total_amount) as city_revenue
from retail_data_python
group by city
order by city_revenue desc
limit 10;

select gender,
count(*) as total_records
from retail_data_python
group by gender
order by total_records desc;

select gender,
sum(total_amount) as gender_revenue
from retail_data_python
group by gender
order by gender_revenue desc;

select avg(age) as average_age
from retail_data_python;

select age,
count(*) as total_records
from retail_data_python
group by age
order by total_records desc
limit 10;

select city,
count(*) as total_records
from retail_data_python
group by city
order by total_records desc
limit 10;

select
Feedback,
COUNT(*) as feedback_count
from retail_data_python
group by Feedback
order by feedback_count DESC;

select product_category,
count(*) as bad_feedback_count
from retail_data_python
where feedback = "bad"
group by product_category
order by bad_feedback_count desc;


select
Product_Category,
COUNT(*) as bad_feedback
from retail_data_python
where Feedback = 'Bad'
group by Product_Category
order by bad_feedback desc;

select shipping_method,
count(*) as total_orders
from retail_data_python
group by shipping_method
order by total_orders desc;

select shipping_method,
count(*) as total_records,
sum(total_amount) as total_revenue,
avg(total_amount) as average_revenue
from retail_data_python
group by shipping_method
order by total_revenue desc;

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

select customer_id,
count(*) as total_records,
round(sum(total_amount), 2) as total_spent
from retail_data_python
where customer_id is not null
group by customer_id
having sum(total_amount) >= 20000
order by total_spent desc; 


select
count(*) as total_rows,
COUNT(Customer_ID) as rows_with_customer_id,
COUNT(*) - COUNT(Customer_ID) as null_customer_ids
from retail_data_python;

select
COUNT(*) as blank_customer_ids
FROM retail_data_python
WHERE Customer_ID = '';

select
customer_ID,
count(*) as total_records
from retail_data_python
group by Customer_ID
order by total_records desc
limit 10;

select 
count(*) as blank_names
from retail_data_python
where name = ' ';

select 
count(*) as blank_emails
from retail_data_python
where email = '';

select
count(*) as blank_phones
from retail_data_python
where phone = '';

select
count(*) as blank_addresses
from retail_data_python
where address = '';


select
count(*) as blank_cities
from retail_data_python
where city = '';


select
count(*) as blank_countries
from retail_data_python
where country = '';

select
count(*) as blank_product_categories
from retail_data_python
where product_category = '';

select
count(*) as blank_product_types
from retail_data_python
where product_type = '';

select
count(*) as blank_shipping_methods
from retail_data_python
where shipping_method = '';

select
count(*) as blank_payment_methods
from retail_data_python
where payment_method = '';

select
count(*) as blank_feedback_values
from retail_data_python
where feedback = '';

select
count(*) as blank_product
from retail_data_python
where products = '';

select
count(*) as blank_product_types
from retail_data_python
where product_type = '';

select product_category,
count(*) as total_sales
from retail_data_python
group by product_category
order by total_sales;

SELECT *
FROM retail_data_python
WHERE Product_Category = ''
limit 10;

select product_category,
sum(total_amount) as total_sales
from retail_data_python
where product_category = ''
group by product_category;

-- Find the best-selling product categories

select product_category,
sum(total_amount) as total_sales
from retail_data_python
where product_category != ''
group by product_category
order by total_sales desc;

select
country,
sum(Total_Amount) AS total_sales
from retail_data_python
group by country
order by total_sales desc
limit 10;

use sales;
select product_brand,
sum(total_amount) as brand_sales
from retail_data_python
where product_brand != ''
group by product_brand
order by brand_sales desc
limit 10;

select
product_category,
count(*) as transaction_records,
round(avg(total_amount), 2) as average_transaction_values,
round(max(total_amount), 2) as max_transaction_values,
round(min(total_amount), 2) as min_transaction_values
from retail_data_python
WHERE Product_Category != ''
group by product_category
order by average_transaction_values desc;


select
count(*) as total_records,
sum(total_amount = 0) as zreo_amount_records,
sum(total_amount < 0) as negative_amount_records,
min(total_amount) as lowest_amount,
max(total_amount) as highest_amount,
round(avg(total_amount), 2) as average_amount
from retail_data_python;


select
column_name,
data_type,
column_type,
is_nullable
from INFORMATION_SCHEMA.columns
WHERE TABLE_SCHEMA = 'sales'
AND TABLE_NAME = 'retail_data_python'
AND COLUMN_NAME = 'Total_Amount';

SELECT
MIN(CAST(Total_Amount AS DECIMAL(10,2))) AS min_amount,
MAX(CAST(Total_Amount AS DECIMAL(10,2))) AS max_amount,
ROUND(AVG(CAST(Total_Amount AS DECIMAL(10,2))), 2) AS avg_amount
FROM retail_data_python
WHERE Total_Amount <> '';


SELECT
Product_Category,
SUM(CAST(Total_Amount AS DECIMAL(10,2))) AS total_sales
FROM retail_data_python
WHERE Product_Category <> ''
GROUP BY Product_Category
ORDER BY total_sales DESC;

SELECT
product_brand,
SUM(CAST(total_amount AS DECIMAL(10,2))) AS brand_sales
FROM retail_data_python
GROUP BY product_brand
ORDER BY brand_sales DESC
LIMIT 5;

select 
gender,
sum(cast(total_amount as decimal(10,2))) as total_sales
from retail_data_python
group by gender
order by total_sales desc;

select city,
sum(cast(total_amount as decimal(10,2))) as total_sales
from retail_data_python
where city != ''
group by city
order by total_sales desc
limit 10 ;

select payment_method,
count(*) as total_transactions
from retail_data_python
group by payment_method
order by total_transactions desc;

select shipping_method,
count(*) as total_orders
from retail_data_python
group by shipping_method
order by total_orders desc;

select product_category,
round(avg(cast(total_amount as decimal(10,2))), 2) as average_orders
from retail_data_python
where product_category != ''
group by product_category
order by average_orders desc;

select product_category,
round(avg(cast(total_amount as decimal(10,2))), 2) as average_orders
from retail_data_python
where product_category != ''
group by product_category
order by average_orders desc;

select products,
round(sum(cast(total_amount as decimal(10,2))), 2) as total_sales
from retail_data_python
where product_category != ''
group by products
order by total_sales desc
limit 10;


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

SELECT
payment_method,
COUNT(*) AS total_transactions,
ROUND(SUM(CAST(Total_Amount AS DECIMAL(10,2))), 2) AS total_sales
FROM retail_data_python
WHERE payment_method <> ''
GROUP BY payment_method
ORDER BY total_sales DESC;

SELECT
shipping_method,
COUNT(*) AS total_orders,
ROUND(SUM(CAST(Total_Amount AS DECIMAL(10,2))), 2) AS total_sales
FROM retail_data_python
WHERE shipping_method <> ''
GROUP BY shipping_method
ORDER BY total_sales DESC;

SELECT
state,
COUNT(*) AS total_transactions,
ROUND(SUM(CAST(Total_Amount AS DECIMAL(10,2))), 2) AS total_sales
FROM retail_data_python
WHERE state <> ''
GROUP BY state
ORDER BY total_sales DESC
LIMIT 10;

CREATE VIEW category_sales_summary AS
SELECT
Product_Category,
SUM(CAST(Total_Amount AS DECIMAL(10,2))) AS total_sales
FROM retail_data_python
GROUP BY Product_Category;

create view payment_sales_summary as
select
payment_method,
count(*) as total_transactions,
sum(cast(total_amount as decimal(10,2))) as total_sales
from retail_data_python
group by payment_method;

SELECT *
FROM payment_sales_summary
ORDER BY total_sales DESC;

create view shipping_sales_summary as
select
shipping_method,
count(*) as total_transactions,
sum(cast(total_amount as decimal(10,2))) as total_sales
from retail_data_python
group by shipping_method;

SELECT *
FROM shipping_sales_summary
ORDER BY total_sales DESC;

SELECT
Country,
COUNT(*) AS total_transactions,
ROUND(SUM(CAST(Total_Amount AS DECIMAL(10,2))), 2) AS total_sales
FROM retail_data_python
WHERE Country <> ''
GROUP BY Country
HAVING COUNT(*) > 1000
ORDER BY total_sales DESC
LIMIT 10;

SELECT
products,
COUNT(*) AS total_transactions,
ROUND(SUM(CAST(Total_Amount AS DECIMAL(10,2))), 2) AS total_sales
FROM retail_data_python
WHERE products != ''
GROUP BY products
HAVING COUNT(*) > 1000
ORDER BY total_sales DESC
LIMIT 10;

SELECT
Gender,
COUNT(*) AS total_transactions,
ROUND(AVG(Age), 1) AS average_age,
ROUND(SUM(CAST(Total_Amount AS DECIMAL(10,2))), 2) AS total_sales
FROM retail_data_python
WHERE Gender != ''
GROUP BY Gender
ORDER BY total_sales DESC;

SELECT
Customer_ID,
Products,
Product_Category,
CAST(Total_Amount AS DECIMAL(10,2)) AS purchase_amount
FROM retail_data_python
WHERE CAST(Total_Amount AS DECIMAL(10,2)) > 4500
ORDER BY purchase_amount DESC
LIMIT 10;

SELECT
Product_Category,
COUNT(*) AS high_value_orders,
ROUND(AVG(CAST(Total_Amount AS DECIMAL(10,2))), 2) AS average_purchase
FROM retail_data_python
WHERE CAST(Total_Amount AS DECIMAL(10,2)) >= 4000
GROUP BY Product_Category
HAVING COUNT(*) >= 100
ORDER BY high_value_orders DESC;

SELECT
Customer_ID,
ROUND(SUM(CAST(Total_Amount AS DECIMAL(10,2))), 2) AS total_spending
FROM retail_data_python
WHERE Customer_ID IS NOT NULL
GROUP BY Customer_ID
ORDER BY total_spending DESC
LIMIT 10;

SELECT
Product_Category,
COUNT(*) AS total_orders,
COUNT(DISTINCT Customer_ID) AS unique_customers
FROM retail_data_python
WHERE Product_Category <> ''
GROUP BY Product_Category
ORDER BY unique_customers DESC
LIMIT 10;

SELECT
Payment_Method,
COUNT(*) AS total_orders,
ROUND(AVG(CAST(Total_Amount AS DECIMAL(10,2))), 2) AS average_purchase
FROM retail_data_python
WHERE Payment_Method <> ''
GROUP BY Payment_Method
ORDER BY average_purchase DESC;

SELECT
Gender,
COUNT(*) AS high_value_orders,
ROUND(AVG(CAST(Total_Amount AS DECIMAL(10,2))), 2) AS average_purchase
FROM retail_data_python
WHERE CAST(Total_Amount AS DECIMAL(10,2)) >= 3000
GROUP BY Gender
ORDER BY high_value_orders DESC;

SELECT
Product_Category,
Products,
COUNT(*) AS total_orders
FROM retail_data_python
WHERE Product_Category <> ''
  AND Products <> ''
GROUP BY Product_Category, Products
ORDER BY Product_Category, total_orders DESC;


