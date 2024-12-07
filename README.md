# Restaurant-Order-Analysis-MySQL
Data analysis project using MySQL

In the repository you can find:

1. Restaurant_Order_Analysis_SQLProject.sql, the SQL script of my project
2. Restaurant Order Analysis MySQL.txt, the SQL script of my project in .txt format


## Introduction 

As a Data Analyst for Taste of the World Cafe, an international cuisine restaurant, I conducted a thorough analysis of a quarter's worth of orders to uncover insights into the most and least popular menu items and the preferences of top customers. From January 1, 2023, to March 31, 2023, the cafe processed over 5,000 orders and served more than 12,000 items, providing a rich dataset for analysis.

Given the database structure—divided into two interconnected tables—I chose MySQL as the most effective tool for handling and analyzing this relational dataset. My approach involved:

1. Exploring each table individually to develop a strong understanding of the data structure and contents.
2. Joining the tables to derive actionable insights into customer behavior and preferences.

The database, restaurant_db, comprises two tables:

1. menu_items: A lookup table listing all menu items along with their categories and prices.
2. order_details: A fact table recording detailed information about each order, including the date and time.

This analysis allowed me to generate data-driven recommendations to optimize the menu and enhance customer satisfaction. 

## Key Findings

1. Most ordered items: Hamburger, Edamame, Korean Beef Bowl, Cheeseburger, French Fries
2. Least ordered items and their category: Chicken Tacos, Potstickers, Cheese Lasagna, Steak Tacos
3. The Top 5 highest spend orders tend to prefer Italian food, followed by Asian and Mexican
4. The average order spend is 30$
5. The menu have four different food categories: **American**(6 items, avg price 10$ ), **Asian**(8 items, avg price 13.5$), **Mexican**(9 items, avg price 12$), **Italian**(9 items, avg price 17$) 


## Impact

1. **Optimized the menu to better align with customers' tastes and expectations.** Our top customers prefer Italian, Asian, and Mexican food. By focusing our efforts on expanding the offers in these categories, we can increase sales. For now, we can think about removing from these categories the least ordered items listed on key findings #2.
2. **Enhanced decision-making by focusing on popular items and addressing underperforming ones.** From the least ordered items insight, we can decide to try to change the recipes or to replace them with new items to meet the tastes of the customers better.
3. **Cost reduction and improved menu efficiency.** Analyzing customer purchase behavior led to the elimination of underperforming menu items, resulting in cost reduction and improved menu efficiency.

## Disclaimer

This project uses a dataset provided by Maven Analytics. I do not own or claim any rights to the dataset. All rights to the data belong to Maven Analytics. This analysis is conducted purely for educational and non-commercial purposes. The names and the data provided in this project are fictitious.





     
