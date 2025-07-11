USE PROJECT;
DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    Order_ID INT PRIMARY KEY,
    Order_Date DATE,
    Order_Time TIME
);
DROP TABLE IF EXISTS order_details;
CREATE TABLE order_details (
    Order_Details_ID INT PRIMARY KEY,
    Order_ID INT NOT NULL,
    Pizza_ID TEXT NOT NULL,
    Quantity INT NOT NULL
);
DROP TABLE IF EXISTS pizzas;

CREATE TABLE pizzas (
    Pizza_ID VARCHAR(50) PRIMARY KEY,
    Pizza_Type_ID VARCHAR(50) NOT NULL,
    Size VARCHAR(20) NOT NULL,
    Price DECIMAL(5,2) NOT NULL
);
DROP TABLE IF EXISTS pizza_types;

CREATE TABLE pizza_types (
    Pizza_Type_ID VARCHAR(50) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Category VARCHAR(20) NOT NULL,
    Ingredients TEXT NOT NULL
);
TRUNCATE TABLE orders;
SELECT*FROM order_details LIMIT 5;
SELECT*FROM pizzas LIMIT 5;
SELECT*FROM pizza_types LIMIT 5;

SELECT COUNT(order_id) AS total_orders
FROM orders;
SELECT SUM(quantity) AS total_pizzas_sold
FROM order_details;
SELECT ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id;
SELECT pt.name, SUM(od.quantity) AS total_sold
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_sold DESC
LIMIT 5;
SELECT pt.name, ROUND(SUM(od.quantity * p.price), 2) AS revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY revenue DESC
LIMIT 5;
SELECT pt.category, ROUND(SUM(od.quantity * p.price), 2) AS total_sales
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY total_sales DESC;
SELECT order_date, COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_date
ORDER BY order_date;
