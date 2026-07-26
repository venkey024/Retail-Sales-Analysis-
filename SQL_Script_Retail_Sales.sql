-- sql reatail Analysis

create database project;
use project;

-- Create a table name 
create table retail_sales(
transactions_id int Primary Key,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR(10),
age INT,
category VARCHAR(20),
quantiy INT,
price_per_unit FLOAT, 
cogs FLOAT,
total_sale FLOAT);

select * from retail_sales;

-- Total count
select count(*) from retail_sales;

--
select * from retail_sales
where transactions_id is NULL;


select * from retail_sales
where transactions_id is NULL 
  or
  sale_date is NULL   or
sale_time is NUll or
customer_id is NUll or
gender is NUll or
age is NUll or
category is NUll or
quantiy is NUll or
price_per_unit is NUll or
cogs is NUll or
total_sale is NUll;

-- How many total sales we have
select count(total_sale) as Total_sales from retail_sales;

-- How many customer we have
select count(Distinct customer_id) as Total_customers from retail_sales;

-------------- Business Key Problems --------------------------
-- 1. write query to retrieve all columns for sales made on '2022-11-05 ---

select * from retail_sales where sale_date = '2022-11-05';

-- 2. write a query retrieve alt transactions where the category is 'Clothing' and  quamtity is sold more than 4 in the month  nov-22
select *from retail_sales
where category = 'clothing' and month(sale_date) = '11' and year(sale_date) = '2022'
and quantiy > 2;

-- 3.Q calculate the total sales (total _ sale) for each 'category ---

select category , sum(total_sale) as Total_sales from retail_sales
group by category;

-- 4. write a query find the average age of customers who purchased from bequty category --

select avg(age) as avg_age from retail_sales
where category = 'beauty';

-- find all transactions where the total _ sale is greater than 1000

select * from retail_sales
where total_sale> 1000;

-- find the total number of transactions (transaction_id) made by each gender in each category.4


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty';


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * FROM retail_sales
WHERE total_sale > 1000;


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1
    
-- ORDER BY 1, 3 DESC

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.


SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category



-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift





  









