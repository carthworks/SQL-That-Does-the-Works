-- Sample database for "SQL That Does the Work" (PostgreSQL)
DROP TABLE IF EXISTS order_items, orders, products, customers, employees, signups_raw;
CREATE TABLE customers (id INT PRIMARY KEY, name TEXT NOT NULL, email TEXT, city TEXT, signup_date DATE NOT NULL);
CREATE TABLE products (id INT PRIMARY KEY, name TEXT NOT NULL, category TEXT NOT NULL, price NUMERIC(10,2) NOT NULL);
CREATE TABLE orders (id INT PRIMARY KEY, customer_id INT REFERENCES customers(id), order_date DATE NOT NULL, status TEXT NOT NULL, amount NUMERIC(10,2));
CREATE TABLE order_items (order_id INT REFERENCES orders(id), product_id INT REFERENCES products(id), qty INT NOT NULL, PRIMARY KEY (order_id, product_id));
CREATE TABLE employees (id INT PRIMARY KEY, name TEXT NOT NULL, dept TEXT NOT NULL, salary INT NOT NULL, manager_id INT REFERENCES employees(id));
CREATE TABLE signups_raw (id INT PRIMARY KEY, email TEXT NOT NULL, source TEXT, created_at TIMESTAMP NOT NULL);
INSERT INTO customers VALUES
(1,'Asha Rao','asha@example.com','Chennai','2025-01-12'),
(2,'Ben Thomas','ben@example.com','Bengaluru','2025-01-20'),
(3,'Chitra Nair',NULL,'Chennai','2025-02-03'),
(4,'Dev Patel','dev@example.com','Mumbai','2025-02-17'),
(5,'Esha Khan','esha@example.com','Bengaluru','2025-03-05'),
(6,'Farid Ali','farid@example.com',NULL,'2025-03-09'),
(7,'Gita Menon','gita@example.com','Chennai','2025-04-21');
INSERT INTO products VALUES
(1,'Mechanical Keyboard','Peripherals',4500),(2,'Wireless Mouse','Peripherals',1200),
(3,'27in Monitor','Displays',18000),(4,'USB-C Dock','Accessories',6500),
(5,'Laptop Stand','Accessories',1800),(6,'Webcam','Peripherals',3200);
INSERT INTO orders (id,customer_id,order_date,status) VALUES
(101,1,'2025-01-15','completed'),(102,2,'2025-01-28','completed'),(103,1,'2025-02-10','completed'),
(104,3,'2025-02-14','cancelled'),(105,4,'2025-02-25','completed'),(106,2,'2025-03-03','completed'),
(107,5,'2025-03-11','completed'),(108,NULL,'2025-03-18','completed'),(109,1,'2025-03-30','completed'),
(110,3,'2025-04-02','completed'),(111,4,'2025-04-09','pending'),(112,6,'2025-04-15','completed'),
(113,5,'2025-04-28','completed'),(114,2,'2025-05-06','completed'),(115,1,'2025-07-04','completed');
INSERT INTO order_items VALUES
(101,1,1),(101,2,1),(102,3,1),(103,5,2),(104,2,1),(105,4,1),(105,5,1),(106,2,2),(107,3,1),(107,1,1),
(108,5,1),(109,4,1),(110,1,1),(111,3,1),(112,2,1),(112,5,1),(113,4,2),(114,5,1),(115,3,1);
UPDATE orders o SET amount = (SELECT SUM(i.qty*p.price) FROM order_items i JOIN products p ON p.id=i.product_id WHERE i.order_id=o.id);
INSERT INTO employees VALUES
(1,'Meera Iyer','Engineering',240000,NULL),(2,'Arjun Das','Engineering',180000,1),(3,'Neha Joshi','Engineering',180000,1),
(4,'Ravi Kumar','Engineering',120000,2),(5,'Sana Sheikh','Sales',150000,1),(6,'Tom Mathew','Sales',95000,5),
(7,'Uma Pillai','Sales',160000,5),(8,'Vikram Shah','Support',80000,5);
INSERT INTO signups_raw VALUES
(1,'asha@example.com','web','2025-01-12 09:00'),(2,'ASHA@example.com ','mobile','2025-01-14 18:30'),
(3,'ben@example.com','web','2025-01-20 11:15'),(4,'dev@example.com','ads','2025-02-17 08:05'),
(5,'dev@example.com','web','2025-02-17 08:06'),(6,'esha@example.com','mobile','2025-03-05 20:40');
