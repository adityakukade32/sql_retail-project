create table retail_sales 
		(
		transactions_id INT PRIMARY KEY,
		sale_date	DATE,
		sale_time TIME,
		customer_id INT,
		gender VARCHAR(15),
		age INT,
		category VARCHAR(11),
		quantiy INT,
		price_per_unit FLOAT,
		cogs FLOAT,
		total_sale FLOAT
		);


		SELECT * FROM retail_sales
		WHERE 
		transactions_id IS NULL
		or
		sale_date IS null
		or 
		sale_time is null
		or customer_id is null
		or age is null
		or category is null
		or quantiy is null
		or price_per_unit is null
		or cogs is null
		or total_sale is null


		
		delete FROM retail_sales
		WHERE 
		transactions_id IS NULL
		or
		sale_date IS null
		or 
		sale_time is null
		or customer_id is null
		or age is null
		or category is null
		or quantiy is null
		or price_per_unit is null
		or cogs is null
		or total_sale is null

		-- what is the total sale

		select count(*) as total_sale from retail_sales


		--how many sutomer we have 
		select count(customer_id) as total_sale from retail_sales


		--how many  unique cutomer we have 
		select  distinct category  from retail_sales


--data analyasis and businees key problems


select * from retail_sales
where sale_date='2022-11-05'


select * from retail_sales
where category='Clothing'
and
quantiy>=4
and to_char(sale_date,'YYYY-MM')='2022-11'


select 
category,
sum(total_sale)as net_sale,
count(*) as total_orders
from retail_sales
group by 1
--Q4 write a sql query to find the average age of customer who purchased items from beauty category
select round(avg(age),2) as avg_age  from retail_sales where category='Beauty'

--Q5 write a sql query to find all transactions where total_sale is greater than 1000
select * from retail_sales
where total_sale> 1000

--Q6 write a sql query to find total number of transactions(transaction_id) made by each gender in each catego

select category, gender, count(*) as total_trans from retail_sales group by category,gender order by 1


--Q7 write a sql query to find the average scale for the each month .find ut the best selling in month in each year
select year,month,avg_sale
from (
select
extract(YEAR from sale_date) as year,
extract(MONTH from sale_date) as month,
avg(total_sale) as avg_sale,
rank()over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rank
from retail_sales
group by 1,2

)as t1
where rank=1



--Q8 write a sql query to find 5 customer based on the highest total sales

select customer_id,
sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2
limit 5

--Q9 write a sql query to find the number of unique customers who purchased items from each category 

select category,count(distinct customer_id) from retail_sales group by category

--Q10 write a sql query to create each shift and number of order(Example Morning<=12, Afternoon between 12 &17,evening >17)
with hourly_sale
as
(
select *,
case 
	when extract(hour from sale_time)<12 then 'Morning'
	when extract(hour from sale_time)between 12 and 17  then 'Afternoon'
	else 'Evening'
end as shift
from retail_sales
)
select shift, count(*)as total_orders from hourly_sale group by shift