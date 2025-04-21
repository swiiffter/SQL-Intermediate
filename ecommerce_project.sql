
-- Database structure for a simple e-commerce system

-- Create tables

CREATE TABLE categories (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE order_items (
    id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Insert sample data

INSERT INTO categories VALUES (1, 'Electronics'), (2, 'Books'), (3, 'Clothing');

INSERT INTO products VALUES 
(1, 'Smartphone', 699.99, 1),
(2, 'Laptop', 1099.99, 1),
(3, 'Fiction Book', 19.99, 2),
(4, 'T-Shirt', 9.99, 3);

INSERT INTO customers VALUES 
(1, 'Alice Popescu', 'alice@gmail.com', 'Bucharest'),
(2, 'Bogdan Ionescu', 'bogdan@yahoo.com', 'Cluj'),
(3, 'Cristina Matei', 'cristina@outlook.com', 'Iasi');

INSERT INTO orders VALUES 
(1, 1, '2024-04-01', 719.98),
(2, 2, '2024-04-02', 1099.99),
(3, 3, '2024-04-03', 29.98);

INSERT INTO order_items VALUES 
(1, 1, 1, 1, 699.99),
(2, 1, 3, 1, 19.99),
(3, 2, 2, 1, 1099.99),
(4, 3, 3, 1, 19.99),
(5, 3, 4, 1, 9.99);

-- Sample queries demonstrating SQL concepts

-- SELECT + WHERE + LIKE + IN
SELECT name, email 
FROM customers 
WHERE city IN ('Cluj', 'Iasi') AND email LIKE '%.com';

-- BETWEEN + ORDER BY
SELECT name, price 
FROM products 
WHERE price BETWEEN 10 AND 1000 
ORDER BY price DESC;

-- AS + GROUP BY + HAVING
SELECT 
    c.name AS customer_name, 
    COUNT(o.id) AS order_count, 
    SUM(o.total) AS total_spent
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.name
HAVING SUM(o.total) > 500;

-- INNER JOIN
SELECT o.id, c.name, o.order_date 
FROM orders o
INNER JOIN customers c ON o.customer_id = c.id;

-- LEFT JOIN
SELECT c.name, o.id AS order_id 
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id;

-- RIGHT JOIN
SELECT o.id, c.name 
FROM orders o
RIGHT JOIN customers c ON o.customer_id = c.id;

-- FULL JOIN (PostgreSQL only)
-- SELECT c.name, o.id AS order_id
-- FROM customers c
-- FULL OUTER JOIN orders o ON c.id = o.customer_id;

-- Multi-table JOIN
SELECT 
    o.id AS order_id, 
    c.name AS customer_name, 
    p.name AS product_name, 
    oi.quantity, 
    oi.price
FROM order_items oi
JOIN orders o ON oi.order_id = o.id
JOIN products p ON oi.product_id = p.id
JOIN customers c ON o.customer_id = c.id;
