create database walmart_sales
use walmart_sales
drop table sales
create table sales(
invoice_id varchar(30) not null primary key,
branch VARCHAR(5) not null,
city VARCHAR(30) not null,
customer_type VARCHAR(30) not null,
gender VARCHAR(10) not null,
product_line VARCHAR(100) not null,
unit_price DECIMAL(10, 2) not null,
quantity INT not null,
VAT FLOAT(6, 4) not null,
total DECIMAL(10, 2) ,
date DATE not null,
time TIME not null,
payment_method varchar(15) not null,
cogs DECIMAL(10, 2) not null,
gross_margin_percentage FLOAT(11, 9) not null,
gross_income DECIMAL(10, 2) not null,
rating FLOAT(2, 1) not null
	)
    select * from sales
    
----------------------------------FEATURED ENGINEERING-----------------------------------------------

#1 Add a new column named "time_of_day" to give insight of sales in the Morning, Afternoon and Evening. 

	SET SQL_SAFE_UPDATES = 0;  #To turn off safe update mode

alter table sales
add column time_of_day varchar(20)
 
 UPDATE sales
set time_of_day=case when time(Time) >='00:00:00' and time(Time) <'12:00:00' then 'Morning'
when time(Time) >='12:00:00' and time(Time) <'18:00:00' then 'Afternoon'
else 'Evening'
end;

-------------------------------------------------------------------------------------
#2 Add a new column named "day_name"  (Mon, Tue, Wed, Thur, Fri). 
alter table sales
add column day_name varchar(20)

update sales
set day_name =dayname(date)
------------------------------------------------------------------------------------------------------------------------------

#3 Add a new column named "month_name"
alter table sales
add column month_name varchar(20)

update sales
set month_name = monthname(date)
-------------------------------------------------------------------------------------------------------------------------------------


---------------------------------------GENERIC QUESTION----------------------------------------------------------
#1 How many unique cities does the data have?
SELECT DISTINCT  CITY  AS UNIQUE_CITY FROM SALES

#2 -- In which city is each branch?
SELECT  DISTINCT CITY,BRANCH FROM SALES;
--------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------PRODUCT---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
-- #1 How many unique product lines does the data have?
SELECT COUNT(DISTINCT PRODUCT_LINE) FROM SALES;

#2 What is the most common payment method?
 SELECT PAYMENT_METHOD,COUNT(PAYMENT_METHOD)  AS COMMON_PAYMENT FROM SALES
 GROUP BY PAYMENT_METHOD
 ORDER BY COMMON_PAYMENT DESC
 LIMIT 1
  
  #3 What is the most selling product line?
  SELECT PRODUCT_LINE, COUNT(PRODUCT_LINE) AS PRODUCT FROM SALES 
  GROUP  BY PRODUCT_LINE
  ORDER BY PRODUCT DESC
  LIMIT 1
  
  #4----What is the total revenue by month?
  SELECT MONTH_NAME,SUM(TOTAL) AS REVENUE FROM SALES
  GROUP BY MONTH_NAME
 ORDER BY REVENUE DESC;
 
 #5---What month had the largest COGS?


SELECT MONTH_NAME,SUM(COGS) AS LARGEST_COGS FROM SALES
GROUP BY MONTH_NAME 

#6----What product line had the largest revenue?
SELECT PRODUCT_LINE ,SUM(TOTAL) AS LARGEST_REVENUE FROM SALES
GROUP BY PRODUCT_LINE 
ORDER BY LARGEST_REVENUE  DESC

#7----What is the city with the largest revenue?
SELECT CITY,SUM(TOTAL) AS LARGEST_REVENUE FROM SALES
GROUP BY CITY
ORDER BY LARGEST_REVENUE DESC
SELECT * FROM SALES
#8------What product line had the largest VAT?
SELECT PRODUCT_LINE,SUM(VAT) AS LARGEST_VAT FROM SALES
GROUP BY PRODUCT_LINE
ORDER BY LARGEST_VAT DESC



#9------Which branch sold more products than average product sold?

select branch,sum(quantity) as qty from sales
group by branch
having sum(quantity)> (select avg(quantity) from sales);

 #10 -------What is the most common product line by gender?
SELECT product_line, gender,count(gender) as gender_cnt
FROM sales
GROUP BY product_line,gender
order by gender_cnt desc;

#11------What is the average rating of each product line?

select product_line,round(avg(rating),2) as avg_rating from sales
group by product_line 
order by avg_rating desc


---------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------Sales---------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
#1-----Number of sales made in each time of the day per weekday
select * from sales
SELECT
	time_of_day,
	COUNT(*) AS total_sales
FROM sales
where day_name='sunday'
GROUP BY time_of_day 
ORDER BY total_sales DESC;

#2-----Which of the customer types brings the most revenue?
select customer_type,sum(total) as revenue from sales
group by customer_type
order by revenue desc
#-----Which city has the largest tax percent/ VAT (Value Added Tax)?
select city,avg(vat) as vat from sales
group  by city
order  by vat desc

#3-----Which customer type pays the most in VAT?
select customer_type,avg(vat) as vat from sales 
group by customer_type
order by vat desc

----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------Customer----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
#1-----How many unique customer types does the data have?
select * from sales;
select distinct customer_type from sales

#2---How many unique payment methods does the data have?
select distinct payment_method from sales

#3-------What is the most common customer type?
SELECT
	customer_type,
	count(*) as count
FROM sales
GROUP BY customer_type
ORDER BY count DESC;

#4---Which customer type buys the most?
select customer_type,sum(quantity) as qnty from sales
group by customer_type
SELECT
	customer_type,
    COUNT(*)
FROM sales
GROUP BY customer_type;

#5-----What is the gender of most of the customers?
select gender,count(gender) as customer from sales
group by gender
order by customer desc

#6-----What is the gender distribution per branch?
select branch,gender,count(gender) as cnt_gender from sales
group by branch,gender
order by branch 

#7--------Which time of the day do customers give most ratings?

select time_of_day,avg(rating) as rating 
from sales
group by time_of_day
order by rating desc

#8---Which time of the day do customers give most ratings per branch?
select time_of_day,branch,avg(rating) as rating from sales
group by branch,time_of_day
order by branch

#9---Which day fo the week has the best avg ratings?
select * from sales
select day_name,avg(rating) as rating from sales
group  by day_name
order by rating desc

#10---Which day of the week has the best average ratings per branch?
select day_name ,branch,avg(rating) as rating from sales
group by day_name,branch
order by rating desc