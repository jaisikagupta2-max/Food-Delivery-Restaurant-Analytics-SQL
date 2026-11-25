🍔 Food Delivery & Restaurant Operations Analytics System (MySQL)
📌 Project Overview

The Food Delivery & Restaurant Operations Analytics System is an end-to-end relational database project developed using MySQL 8.0.

This project simulates a real-world food delivery platform where customers can place orders from different restaurants, restaurants manage menu items, delivery partners handle deliveries, and customers provide ratings and feedback.

The primary goal of this project is to manage food delivery operations efficiently and generate meaningful business insights using SQL queries.

All names, transactions, and amounts used in this project are fictional and intended for learning purposes.

🎯 Project Objectives
Design and implement a relational database using MySQL.
Manage customer, restaurant, menu, order, delivery, and payment information.
Establish relationships between tables using Primary Keys and Foreign Keys.
Perform data analysis using SQL queries.
Identify top-performing restaurants and popular menu items.
Analyse customer behaviour and order trends.
Evaluate delivery partner performance.
Generate business insights to support operational decision-making.
🛠️ Technologies Used
Database: MySQL 8.0+
IDE: MySQL Workbench 8.0+
Language: SQL
Concepts: DBMS, Relational Database Design, Data Analytics
🗄️ Database Schema

The project consists of 9 relational tables:

Table Name	Description
customers	Stores customer information
restaurants	Stores restaurant details
menu_items	Stores restaurant menu items and prices
delivery_partners	Stores delivery partner information
orders	Stores customer order details
order_items	Stores individual items within each order
deliveries	Stores delivery tracking information
payments	Stores payment transactions
ratings	Stores customer ratings and reviews
🔗 Database Relationships
One customer can place multiple orders.
One restaurant can receive multiple orders.
One restaurant can have multiple menu items.
One order can contain multiple order items.
One delivery partner can handle multiple deliveries.
Each order has one associated delivery record.
Each order has one associated payment record.
Each order can have one customer rating.

📊 SQL Concepts Implemented

This project demonstrates the following SQL concepts:
•	CREATE DATABASE and USE
•	CREATE TABLE, data types and AUTO_INCREMENT
•	PRIMARY KEY and FOREIGN KEY constraints
•	One-to-many relationships
•	INSERT, UPDATE and DELETE basics
•	INNER JOIN and LEFT JOIN
•	WHERE, ORDER BY and GROUP BY
•	COUNT, SUM, AVG, MIN and MAX
•	Subqueries and date/time calculations
•	CREATE VIEW and stored procedures

📈 Business Analytics Performed

The project answers several real-world business questions using SQL.
•	Which restaurants receive the highest number of orders?
•	What is the total sales value and average order value?
•	Which menu items generate the most revenue?
•	How many orders are delivered, cancelled or still in progress?
•	Which delivery partners complete the most deliveries?
•	How long does delivery take on average?
•	Which restaurants have the strongest customer ratings?
•	How much payment is collected through each payment method?

⚙️ Advanced SQL Implementation

1. Restaurant Performance Summary View

Created a SQL view named restaurant_performance_summary to analyse:

Total orders received by each restaurant.
Total delivered order value.
Average customer rating.

Important: Orders and ratings are aggregated separately before joining to prevent duplicate rows and incorrect sales calculations.

2. Customer Order History Stored Procedure

Created a stored procedure named GetCustomerOrderHistory.

It accepts a customer ID as input and retrieves:

Customer order history.
Restaurant names.
Order dates and statuses.
Order amounts.
Payment methods.
Payment statuses.
Amount paid.

Example:

sql
CALL GetCustomerOrderHistory(1);

📁 Project Structure
text
Food-Delivery-Analytics/
│
├── README.md
│
├── SQL/
│   ├── 01_Create_Database_And_Tables.sql
│   ├── 02_Insert_Sample_Data.sql
│   ├── 03_Business_Analytics_Queries.sql
│   └── 04_View_And_Stored_Procedure.sql
│
└── Screenshots/
    ├── database_tables.png
    ├── restaurant_analysis.png
    ├── order_analysis.png
    └── payment_analysis.png


Note: The folder structure above is a suggested organisation for the GitHub repository.

🚀 How to Run This Project

Follow these steps to execute the project:

Install MySQL Server 8.0 or later.
Install and open MySQL Workbench.
Connect to your MySQL Server.
Create the database using the provided SQL script.
Execute the table creation statements in the correct order.
Insert the sample data into all nine tables.
Run the business analytics queries.
Create and test the restaurant performance view.
Create and execute the customer order history stored procedure.

Select the database before executing the queries:

sql
USE food_delivery_analytics;

💡 Key Business Insights

Using the sample dataset, this project helps analyse:

Restaurant-wise order performance and sales.
Customer ordering patterns and repeat customers.
Most popular food items.
Order cancellation and delivery status.
Average delivery time.
Delivery partner efficiency.
Customer satisfaction through ratings.
Payment collection across different methods.
Daily order volume and sales trends.
🎓 Learning Outcomes

Through this project, I gained practical experience in:

Relational database design and implementation.
Managing data using MySQL.
Establishing relationships between multiple tables.
Writing complex SQL queries.
Performing business analysis using aggregate functions and joins.
Creating views and stored procedures.
Extracting meaningful business insights from structured data.

👨‍💻 Author

jaisika | SQL | MySQL | Data Analytics

