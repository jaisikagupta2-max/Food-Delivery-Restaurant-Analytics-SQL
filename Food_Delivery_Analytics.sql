CREATE DATABASE food_delivery_analytics;
USE food_delivery_analytics;

select database();

-- Create Tables  customers, restaurants, menu items, orders, order items, delivery partners, deliveries, payments and customer ratings.

-- CUSTOMERS

CREATE TABLE customers(
customer_id int primary key Auto_increment, 
customer_name varchar(100),
phone varchar(15) not null  unique,
email varchar(120) unique,
city varchar(50) not null,
signup_date DATE not null);


-- RESTAURANTS

create table restaurants (
restaurant_id int primary key auto_increment,
restaurant_name varchar(120) not null,
cuisine_type varchar(60) not null,
city varchar(50) not null,
opening_date date,
is_active TINYINT(1) NOT NULL DEFAULT 1
);

-- MENU ITEMS

create table menu_items(
item_id int primary key auto_increment,
restaurant_id int not null,
item_name varchar(100) not null,
category varchar(50),
price decimal(10,2) not null,
is_available tinyint(1) not null default 1,
constraint fk_menu_restaurant 
foreign key (restaurant_id) references restaurants(restaurant_id),

constraint chk_items_prices check(price >=0)
);


-- Delivery Partners

create table delivery_partners (
partner_id int primary key auto_increment,
partner_name varchar(100) not null,
phone varchar(15) not null unique,
vehical_type varchar(30),
joining_date DATE,
partner_city varchar(50) 
);


-- Orders

CREATE TABLE orders (     
order_id INT PRIMARY KEY AUTO_INCREMENT,     
customer_id INT NOT NULL,    
restaurant_id INT NOT NULL,     
order_datetime DATETIME NOT NULL,     
order_status VARCHAR(20) NOT NULL,     
total_amount DECIMAL(10,2) NOT NULL,     
delivery_address VARCHAR(200) NOT NULL,     

CONSTRAINT fk_orders_customer
FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    
CONSTRAINT fk_orders_restaurant
FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id),
CONSTRAINT chk_order_amount CHECK (total_amount >= 0),
CONSTRAINT chk_order_status CHECK(order_status IN ('Placed','Preparing','Out for Delivery','Delivered','Cancelled'))
);


-- Order Items

CREATE TABLE order_items (     
order_item_id INT PRIMARY KEY AUTO_INCREMENT,     
order_id INT NOT NULL,     
item_id INT NOT NULL,     
quantity INT NOT NULL,     
unit_price DECIMAL(10,2) NOT NULL,     
CONSTRAINT fk_orderitems_order
FOREIGN KEY (order_id) REFERENCES orders(order_id),
    
CONSTRAINT fk_orderitems_item
FOREIGN KEY (item_id) REFERENCES menu_items(item_id),
    
CONSTRAINT chk_quantity CHECK (quantity > 0),
CONSTRAINT chk_unit_price CHECK (unit_price >= 0)
);


-- Deliveries

CREATE TABLE deliveries (     
delivery_id INT PRIMARY KEY AUTO_INCREMENT,     
order_id INT NOT NULL UNIQUE,     
partner_id INT,     
pickup_time DATETIME,     
delivered_time DATETIME,     
delivery_status VARCHAR(20) NOT NULL,     
CONSTRAINT fk_delivery_order
FOREIGN KEY (order_id) REFERENCES orders(order_id),
    
CONSTRAINT fk_delivery_partner
FOREIGN KEY (partner_id) REFERENCES delivery_partners(partner_id),
    
CONSTRAINT chk_delivery_status CHECK(delivery_status IN ('Assigned','Picked Up','Delivered','Failed'))
);



-- Payments

CREATE TABLE payments (     
payment_id INT PRIMARY KEY AUTO_INCREMENT,     
order_id INT NOT NULL UNIQUE,     
payment_date DATETIME,     
payment_method VARCHAR(30) NOT NULL,     
payment_status VARCHAR(20) NOT NULL,     
amount_paid DECIMAL(10,2) NOT NULL,     
CONSTRAINT fk_payment_order
FOREIGN KEY (order_id) REFERENCES orders(order_id),

CONSTRAINT chk_payment_amount CHECK (amount_paid >= 0),
CONSTRAINT chk_payment_status CHECK(payment_status IN ('Paid','Pending','Failed','Refunded'))
);



-- Ratings

CREATE TABLE ratings (     
rating_id INT PRIMARY KEY AUTO_INCREMENT,     
order_id INT NOT NULL UNIQUE,     
customer_id INT NOT NULL,     
restaurant_id INT NOT NULL,     
rating TINYINT NOT NULL,     
review_text VARCHAR(300),     
rating_date DATE NOT NULL,     
CONSTRAINT fk_rating_order 
FOREIGN KEY (order_id) REFERENCES orders(order_id),
    
CONSTRAINT fk_rating_customer 
FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
CONSTRAINT fk_rating_restaurant 
FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id),
    
CONSTRAINT chk_rating_value CHECK (rating BETWEEN 1 AND 5)
);

SHOW TABLES;
DESCRIBE orders;
DESCRIBE order_items;


-- Insert data of  Customers

INSERT INTO customers(customer_name, phone, email, city, signup_date) 
VALUES
('Aarav Sharma','9876500001','aarav@example.com','Dehradun','2025-01-05'),
('Meera Verma','9876500002','meera@example.com','Delhi','2025-01-12'),
('Kabir Singh','9876500003','kabir@example.com','Dehradun','2025-02-01'),
('Ananya Gupta','9876500004','ananya@example.com','Jaipur','2025-02-15'),
('Rohan Das','9876500005','rohan@example.com','Delhi','2025-03-02'),
('Ishita Rao','9876500006','ishita@example.com','Dehradun','2025-03-10');



-- Insert data of Restaurants

INSERT INTO restaurants(restaurant_name, cuisine_type, city, opening_date, is_active) 
VALUES
('Himalayan Bites','North Indian','Dehradun','2020-04-10',1),
('Spice Route Kitchen','Chinese','Delhi','2019-08-20',1),
('Green Bowl Cafe','Healthy Food','Dehradun','2022-01-15',1),
('Royal Thali House','North Indian','Jaipur','2018-06-01',1);



-- Insert data of Menu Items

INSERT INTO menu_items(restaurant_id, item_name, category, price, is_available) 
VALUES
(1,'Paneer Butter Masala','Main Course',260.00,1),
(1,'Butter Naan','Bread',40.00,1),
(1,'Veg Biryani','Main Course',190.00,1),
(2,'Hakka Noodles','Main Course',180.00,1),
(2,'Manchurian','Starter',160.00,1),
(2,'Spring Rolls','Starter',120.00,1),
(3,'Quinoa Salad','Healthy Bowl',220.00,1),
(3,'Fruit Smoothie','Beverage',130.00,1),
(4,'Special Veg Thali','Combo Meal',240.00,1),
(4,'Gulab Jamun','Dessert',70.00,1);



-- Insert data of Delivery Partners

INSERT INTO delivery_partners(partner_name, phone, vehical_type, joining_date, partner_city) 
VALUES
('Vikas Rawat','9811100001','Bike','2024-05-01','Dehradun'),
('Neha Khan','9811100002','Scooter','2024-07-15','Delhi'),
('Arjun Yadav','9811100003','Bike','2025-01-10','Jaipur'),
('Simran Kaur','9811100004','Bike','2025-02-20','Dehradun');



-- Insert data of Orders

INSERT INTO orders(customer_id, restaurant_id, order_datetime, order_status, total_amount, delivery_address) 
VALUES
(1,1,'2025-04-01 12:15:00','Delivered',340.00,'Rajpur Road, Dehradun'),
(2,2,'2025-04-01 13:05:00','Delivered',340.00,'Lajpat Nagar, Delhi'),
(3,3,'2025-04-02 19:20:00','Delivered',350.00,'Ballupur, Dehradun'),
(4,4,'2025-04-03 20:10:00','Cancelled',310.00,'Vaishali Nagar, Jaipur'),
(1,1,'2025-04-04 14:30:00','Delivered',450.00,'Rajpur Road, Dehradun'),
(5,2,'2025-04-04 21:00:00','Out for Delivery',300.00,'Dwarka, Delhi'),
(6,3,'2025-04-05 10:45:00','Preparing',350.00,'Clement Town, Dehradun'),
(2,2,'2025-04-06 18:25:00','Delivered',300.00,'Lajpat Nagar, Delhi'),
(3,1,'2025-04-07 13:40:00','Delivered',380.00,'Ballupur, Dehradun'),
(5,4,'2025-04-08 19:15:00','Delivered',550.00,'Dwarka, Delhi');



-- Insert data of Order_Items

INSERT INTO order_items (order_id, item_id, quantity, unit_price) 
VALUES
(1,1,1,260.00),(1,2,2,40.00),
(2,4,1,180.00),(2,5,1,160.00),
(3,7,1,220.00),(3,8,1,130.00),
(4,9,1,240.00),(4,10,1,70.00),
(5,1,1,260.00),(5,3,1,190.00),
(6,4,1,180.00),(6,6,1,120.00),
(7,7,1,220.00),(7,8,1,130.00),
(8,4,1,180.00),(8,5,1,120.00),
(9,1,1,260.00),(9,2,3,40.00),
(10,9,2,240.00),(10,10,1,70.00);



-- Insert data of Deliveries

INSERT INTO deliveries(order_id, partner_id, pickup_time, delivered_time, delivery_status) 
VALUES
(1,1,'2025-04-01 12:35:00','2025-04-01 13:05:00','Delivered'),
(2,2,'2025-04-01 13:25:00','2025-04-01 14:00:00','Delivered'),
(3,4,'2025-04-02 19:45:00','2025-04-02 20:20:00','Delivered'),
(4,3,NULL,NULL,'Failed'),
(5,1,'2025-04-04 14:55:00','2025-04-04 15:30:00','Delivered'),
(6,2,'2025-04-04 21:25:00',NULL,'Picked Up'),
(7,4,NULL,NULL,'Assigned'),
(8,2,'2025-04-06 18:50:00','2025-04-06 19:25:00','Delivered'),
(9,1,'2025-04-07 14:00:00','2025-04-07 14:40:00','Delivered'),
(10,3,'2025-04-08 19:40:00','2025-04-08 20:20:00','Delivered');



-- Insert data of Payments

INSERT INTO payments(order_id, payment_date, payment_method, payment_status, amount_paid) 
VALUES
(1,'2025-04-01 12:16:00','UPI','Paid',340.00),
(2,'2025-04-01 13:06:00','Card','Paid',340.00),
(3,'2025-04-02 19:21:00','UPI','Paid',350.00),
(4,'2025-04-03 20:11:00','Cash','Refunded',310.00),
(5,'2025-04-04 14:31:00','UPI','Paid',450.00),
(6,'2025-04-04 21:01:00','Card','Pending',0.00),
(7,'2025-04-05 10:46:00','UPI','Pending',0.00),
(8,'2025-04-06 18:26:00','Cash','Paid',300.00),
(9,'2025-04-07 13:41:00','UPI','Paid',380.00),
(10,'2025-04-08 19:16:00','Card','Paid',550.00);


-- Insert data of Ratings

INSERT INTO ratings(order_id, customer_id, restaurant_id, rating, review_text, rating_date) 
VALUES
(1,1,1,5,'Fresh food and quick delivery','2025-04-01'),
(2,2,2,4,'Good taste','2025-04-01'),
(3,3,3,5,'Healthy and delicious','2025-04-02'),
(5,1,1,4,'Good food, slightly late','2025-04-04'),
(8,2,2,3,'Average experience','2025-04-06'),
(9,3,1,5,'Excellent meal','2025-04-07'),
(10,5,4,4,'Good portion size','2025-04-08');



-- Verify Inserted Records

SELECT COUNT(*) AS total_customers 
FROM customers;

SELECT COUNT(*) AS total_restaurants 
FROM restaurants;


SELECT COUNT(*) AS total_orders 
FROM orders;

SELECT * FROM orders ORDER BY order_id;




-- Total Order Value

SELECT SUM(total_amount) AS total_order_value
FROM orders;


-- Number of Orders by Status

SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Restaurant-wise Orders and Sales

SELECT r.restaurant_name,
COUNT(o.order_id) AS total_orders,
SUM(o.total_amount) AS order_value
FROM restaurants r
LEFT JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, 
r.restaurant_name ORDER BY order_value DESC;


-- Top-selling Menu Items by Quantity

SELECT m.item_name,
SUM(oi.quantity) AS units_sold
FROM menu_items m
JOIN order_items oi ON m.item_id = oi.item_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY m.item_id, m.item_name
ORDER BY units_sold DESC;


-- Revenue by Cuisine Type

SELECT r.cuisine_type,
SUM(o.total_amount) AS total_order_value
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
WHERE o.order_status <> 'Cancelled'
GROUP BY r.cuisine_type
ORDER BY total_order_value DESC;


-- Average Order Value (AOV)

SELECT ROUND(AVG(total_amount), 2) AS average_order_value
FROM orders;

SELECT ROUND(AVG(total_amount), 2) AS delivered_order_aov
FROM orders
WHERE order_status = 'Delivered';


-- Customers with More Than One Order

SELECT c.customer_name,
COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 1
ORDER BY order_count DESC;


-- Pending or Unpaid Payments

SELECT o.order_id, c.customer_name, p.payment_method, p.payment_status,o.total_amount, p.amount_paid
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN payments p ON o.order_id = p.order_id
WHERE p.payment_status = 'Pending';



-- Average Restaurant Rating

SELECT r.restaurant_name,
ROUND(AVG(rt.rating), 2) AS average_rating,
COUNT(rt.rating_id) AS number_of_reviews
FROM restaurants r
LEFT JOIN ratings rt ON r.restaurant_id = rt.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name ORDER BY average_rating DESC;


-- Delivery Time in Minutes

SELECT d.delivery_id, d.order_id, dp.partner_name,        
TIMESTAMPDIFF(MINUTE, d.pickup_time, d.delivered_time) AS delivery_minutes
FROM deliveries d
LEFT JOIN delivery_partners dp ON d.partner_id = dp.partner_id
WHERE d.pickup_time IS NOT NULL AND d.delivered_time IS NOT NULL
ORDER BY delivery_minutes;


-- Average Delivery Time by Partner
SELECT dp.partner_name,        
ROUND(AVG(TIMESTAMPDIFF(MINUTE,d.pickup_time, d.delivered_time)), 2) AS avg_delivery_minutes,        
COUNT(d.delivery_id) AS completed_deliveries FROM delivery_partners dp
JOIN deliveries d ON dp.partner_id = d.partner_id
WHERE d.delivery_status = 'Delivered'
AND d.pickup_time IS NOT NULL AND d.delivered_time IS NOT NULL
GROUP BY dp.partner_id, dp.partner_name
ORDER BY avg_delivery_minutes;


-- Payment Collection by Method


SELECT payment_method,
COUNT(*) AS payment_transactions,
SUM(amount_paid) AS amount_collected
FROM payments
WHERE payment_status = 'Paid'
GROUP BY payment_method
ORDER BY amount_collected DESC;



-- Orders Above the Overall Average Value

SELECT order_id, total_amount, order_status
FROM orders
WHERE total_amount > (SELECT AVG(total_amount) FROM orders)
ORDER BY total_amount DESC;


-- Daily Order Trend

SELECT DATE(order_datetime) AS order_date,
COUNT(*) AS total_orders, SUM(total_amount) AS order_value
FROM orders
GROUP BY DATE(order_datetime)
ORDER BY order_date;


-- Restaurant Menu Price Analysis
SELECT r.restaurant_name,
COUNT(m.item_id) AS menu_item_count,
ROUND(AVG(m.price), 2) AS average_menu_price,
MIN(m.price) AS lowest_item_price,
MAX(m.price) AS highest_item_price
FROM restaurants r
LEFT JOIN menu_items m ON r.restaurant_id = m.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY average_menu_price DESC;


-- CREATE A VIEW (RESTAURANT PERFORMANCE SUMMARY)

CREATE VIEW restaurant_performance_summary AS SELECT r.restaurant_id, r.restaurant_name, r.cuisine_type,    
COUNT(o.order_id) AS total_orders,
COALESCE(SUM(CASE WHEN o.order_status = 'Delivered' THEN o.total_amount ELSE 0 END), 0) AS delivered_order_value,
ROUND(AVG(rt.rating), 2) AS average_rating
FROM restaurants r
LEFT JOIN orders o ON r.restaurant_id = o.restaurant_id
LEFT JOIN ratings rt ON r.restaurant_id = rt.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name, r.cuisine_type; 


SELECT * FROM restaurant_performance_summary;

SELECT restaurant_name, delivered_order_value
FROM restaurant_performance_summary
ORDER BY delivered_order_value DESC;


-- STORED PROCEDURE (CUSTOMER ORDER HISTORY)

DELIMITER //
CREATE PROCEDURE GetCustomerOrderHistory(IN p_customer_id INT)
BEGIN  
SELECT o.order_id, o.order_datetime, r.restaurant_name, o.order_status, o.total_amount     
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id 
WHERE o.customer_id = p_customer_id
ORDER BY o.order_datetime DESC;
    
    
    
SELECT o.order_id, p.payment_method, p.payment_status, p.amount_paid  
FROM orders o
JOIN payments p ON o.order_id = p.order_id
WHERE o.customer_id = p_customer_id
ORDER BY o.order_datetime DESC;

END //
DELIMITER ;

CALL GetCustomerOrderHistory(1);


-- Update a Menu Item Price

UPDATE menu_items
SET price = 275.00
WHERE item_id = 1;

SELECT * FROM menu_items WHERE item_id = 1;


-- Change an Order Status

UPDATE orders
SET order_status = 'Delivered'
WHERE order_id = 6;


SELECT order_id, order_status
FROM orders
WHERE order_id = 6;


-- Delete a Rating (Optional Practice)
-- Optional: delete only the rating for order 8
DELETE FROM ratings
WHERE order_id = 8;



USE food_delivery_analytics;

show tables;


SELECT * FROM restaurant_performance_summary;

CALL GetCustomerOrderHistory(1);

CALL GetCustomerOrderHistory(2);

SELECT * FROM orders;

SELECT * FROM order_items;



-- OPTIONAL EXTENSION TASKS

-- 1. Find customers who have never placed an order using LEFT JOIN.

select c.customer_id, c.customer_name, c.email, c.phone
from customers c
Left Join orders o on c.customer_id = o.customer_id
where o.order_id is null;

select * from customers;


-- 2.Rank restaurants by delivered order value using a window function

SELECT restaurant_id, restaurant_name, total_delivered_value,
RANK() 
OVER (ORDER BY total_delivered_value DESC) AS restaurant_rank
FROM ( SELECT r.restaurant_id, r.restaurant_name, SUM(o.total_amount) AS total_delivered_value
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
WHERE o.order_status = 'Delivered'
GROUP BY r.restaurant_id, r.restaurant_name) AS restaurant_sales;


 -- 3.Find the most frequently ordered item in each restaurant
 
 WITH item_orders AS (
SELECT r.restaurant_id, r.restaurant_name, m.item_name, SUM(oi.quantity) AS total_quantity,
RANK()
OVER (PARTITION BY r.restaurant_id ORDER BY SUM(oi.quantity) DESC) AS item_rank
FROM restaurants r
JOIN menu_items m ON r.restaurant_id = m.restaurant_id
JOIN order_items oi ON m.item_id = oi.item_id
GROUP BY r.restaurant_id, r.restaurant_name, m.item_name)
SELECT * FROM item_orders
WHERE item_rank = 1;



-- 4. Create a monthly sales summary using YEAR() and MONTH()

SELECT YEAR(order_datetime) AS sales_year,MONTH(order_datetime) AS sales_month,
COUNT(order_id) AS total_orders, SUM(total_amount) AS monthly_sales
FROM orders
WHERE order_status = 'Delivered'
GROUP BY YEAR(order_datetime),MONTH(order_datetime)
ORDER BY sales_year, sales_month;

SELECT * FROM orders;


-- 5.Compare paid amount with order total and identify mismatches

SELECT o.order_id, o.total_amount, p.amount_paid, (o.total_amount - p.amount_paid) AS difference
FROM orders o
JOIN payments p ON o.order_id = p.order_id
WHERE o.total_amount <> p.amount_paid;

DESCRIBE payments;





