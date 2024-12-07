-- Maven Analytics Restaurant Order Analysis with SQL project

/* 
To help the "Taste of the World Cafe", a restaurant with diverse menu options, to have abetter understanding 
of what menu items are going well/not well and what the top customers seems to like best, I analyzed a quarter's worth of orders,
 12,266 records and 8 fields.

I created a restaurant database, restaurant_db, composed of a lookup table menu_items,
including all the menu items with name and category, and a fact table order_details, including all the quarter's orders.

The guided project is divide in three parts:
- Part 1. Dedicated to explore menu_items table (from line 19)
- Part 2. Dedicated to explore order_details table (from line 95)
- Part 3. Dedicated to analyze customer behavior by left joining order_details and menu_items tables together (from line 161)
- Part 4. After finishing the guided project part I decided to add some calculations to further undeerstand the data (from line 231)
*/

use restaurant_db; -- to tell MySQL which db to use

-- PART 1
-- Explore items table

/* 
	Table break down:

	1. 32 items on the menu
    2. Most Expensive Item:  Shrimp Scampi 19.95$
    3. Least Expensive Item: Edamame 5.00$
    4. The menu have four different food categories: American(6 items, avg price 10$ ), Asian(8 items, avg price 13.5$),
	    Mexican(9 items, avg price 12$), Italian(9 items, avg price 17$) 
*/


-- Q1. View the menu_items table and write a query to find the number of items on the menu

select *
from menu_items;

-- Query to know the number of items on the menu
select
	count(menu_item_id) as number_of_items -- can also be done with count(*)
from menu_items;

-- The menu has 32 items

-- Q2. What are the least and most expensive items on the menu?

select  -- can also be select *
    item_name,
    price
from menu_items
order by price;

-- Most Expensive: Shrimp Scampi 19.95
-- Least Expensive: Edamame 5.00

-- Q3. How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu?

select
	count(menu_item_id) as number_of_items -- also possible count(*)
from menu_items
where category = 'Italian';

select 
    item_name, -- aslo select * possible
    price
from menu_items
where category = 'Italian'
order by price;
-- Number of Italian dishes: 9
-- Most Expensive italian dish: Shrimp Scampi 
-- Cheapest italian dish: Spaghetti

-- Q4. How many dishes are in each category? What is the average dish price within each category?

select
	category,
	count(menu_item_id) as number_of_items
from menu_items
group by category;

select
	category,
	avg(price) as avg_price
from menu_items
group by category;



/* American: 6  avg price 10.06
	Asian: 8 avg price 13.47
    Mexican: 9 avg price 11.8
    Italian: 9 avg price 16.75
    */
    
-- PART 2 
-- Explore order_details table 

/* 
	Table Break down:
    
    1. The time period goes from 2023-01-01 to 2023-03-31
    2. 5,370 orders made in this period
    3. 12,234 items ordered
    4. 20 orders with more than 12 items 
*/
select * 
from order_details;

-- Q1. View the order_details table. What is the date range of the table?

select * 
from order_details
order by order_date desc;

-- Date range is from 2023-01-01 to 2023-03-31

-- Q2. How many orders were made within this date range? How many items were ordered within this date range?

select 
	count(DISTINCT order_id) as num_of_orders
from order_details;

-- 5,370 orders made in this period  

select 
	count(*) as num_of_items
from order_details;

-- 12,234 items 
-- Pay attention to count and count distinct

-- Q3. Which orders had the most number of items?

select 
	order_id,
	count(item_id) as num_of_items
from order_details
group by order_id
order by count(item_id) desc;

-- Orders: 4035, 3473, 1957, 330, 440, 443, 2675. With 14 items each

-- Q4. How many orders had more than 12 items?

-- Solution 

SELECT 
	count(*) 
FROM 
	(select 
		order_id,
		count(item_id) as num_of_items
	from order_details
	group by order_id
	having num_of_items > 12) as num_orders;

-- I was near with my query, but to obtain the count how how many orders where above 12 items I needed a subquery 


-- PART 3 
-- Analyze customer behavior

/*
	Key findings from customer behavior:
    
    1. Most ordered items and their category: 
		Hamburger(american), Edamame(asian), Korean Beef Bowl(asian), Cheeseburger(american), French Fries(american)
	2. Least ordered items and their category:
		Chicken Tacos(mexican), Potstickers(asian), Cheese Lasagna(italian), Steak Tacos(mexican)
	3. Top 5 orders: 440, 2075, 1957, 330, 2675
    4. Order 440 category details an num of items: mexican 2, american 2, italian 8, asian 2
    5. The Top 5 orders tend to prefer italian food, followed by asian and mexican
*/

-- Q1. Combine the menu_items and order_details tables into a single table 

Select * 
From order_details as od
	left join menu_items as mi
		on od.item_id=mi.menu_item_id;

-- Q2 What were the least and most ordered items? What categories were they in?

Select 
	item_name,
    category, 
	count(order_details_id) as num_purchases
From order_details as od
	left join menu_items as mi
		on od.item_id=mi.menu_item_id
 group by item_name, category
 order by num_purchases asc -- or desc
 Limit 5;

-- Q3 What were the top 5 orders that spent the most money?

Select 
	order_id,
    sum(price) as total_spend
From order_details as od
	left join menu_items as mi
		on od.item_id=mi.menu_item_id
group by order_id
order by total_spend desc 
limit 5;

-- Q4. View the details of the highest spend order. Which specific items were purchased?

Select 
	category,
    count(item_id) as num_items
From order_details as od
	left join menu_items as mi
		on od.item_id=mi.menu_item_id
where order_id = 440
group by category; 
 
-- Q5. BONUS: View the details of the top 5 highest spend orders

Select 
	/*order_id,*/
	category,
    count(item_id) as num_items
From order_details as od
	left join menu_items as mi
		on od.item_id=mi.menu_item_id
where order_id in (440, 2075, 1957, 330, 2675)
group by /*order_id, */category; 

-- PART 4 
-- Adding a bit more of calculations to get more insights

/*
	Key insights:
    
    1. Average order spend: 30$
*/

-- Average order cost
Select 
	avg(total_spend) as average_spend

from
	(Select 
		order_id,
		sum(price) as total_spend
	From order_details as od
		left join menu_items as mi
			on od.item_id=mi.menu_item_id
	group by order_id) as orders_total;
    


