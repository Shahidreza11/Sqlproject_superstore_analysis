select * from orderslist;
select * from eachorder;

--Data Exploration
--1)List the top 10 orders with the highest sales from the eachorder table;

--method-1 using (window function)
select * from (select e.*,dense_rank() over(order by sales desc)top10 from eachorder e order by sales desc)
where top10<=10; 
--method-2 (using order by)
select * From eachorder order by sales desc fetch first 10 rows only;

--2) Show the number of orders for each product category in the eachorder table

select category, count(*) as No_of_orders from eachorder group by category;

--3) Find the total profit for each sub_category in the eachorder table;

select subcategory, sum(profit) as total_profit from eachorder group by subcategory;

--4) Identify the customer with the highest total sales across all orders


select o.customername,sum(e.sales) as Total_sales from orderslist o full join eachorder e 
ON o.orderid=e.orderid 
GROUP BY o.customername
ORDER BY sum(e.sales) desc FETCH FIRST 1 ROW ONLY; 


--5) Find the month with the highest Average sales in the orderslist table
select * From orderslist;

select to_char(o.orderdate,'month') AS MONTH,round(avg(e.sales),2)as AVG_SALES from orderslist o join eachorder e
on o.orderid=e.orderid group by to_char(o.orderdate,'month') 
ORDER BY AVG_SALES DESC 
FETCH FIRST 1 ROW ONLY;

--6) Find out the Average quantity ordered by customers whose first name starts with an alphabet 's'?

select avg(e.quantity) from orderslist o join eachorder e 
on o.orderid=e.orderid 
WHERE substr(o.customername,1,1)='S';

--7) Find out how many new customers were acquired in the year 2014?

select count(*) as No_of_New_customers from (
select  customername,min(orderdate) as first_order_date from orderslist
group by customername
having extract(year from min(orderdate))='2014');


--8) Calculate the percentage of Total profit contributed by each sub-category to the overall profit.

select  subcategory,sum(profit) as Total_Profit,
round((sum(profit)/sum(sum(profit)) over())*100,2)as percent_of_total
from eachorder 
GROUP BY subcategory;

--9) Find the Average Sales Per Customer , Considering only Customers who have made more than 1 order.

select o.customername,round(avg(e.sales),2) as Average_Sales,count(distinct(o.orderid))as no_of_ords
from orderslist o
join eachorder e on o.orderid=e.orderid
GROUP BY o.customername 
HAVING count(distinct(o.orderid))>1;


--10) Identify the top-perfoming subcategory in each category based on total sales .
--Include the sub-category name,total sales and ranking of sub-category within each category


select * from (
select category,subcategory,sum(sales) as Total_sales,dense_rank() over(partition by category order by sum(sales) desc)as ranking from eachorder
group by category,subcategory
) where ranking=1;