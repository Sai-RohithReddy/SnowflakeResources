-- Constraints
-- Unique, Not null, Primary Key, Foreign Key, Check, Default

-- Snowflake doesn't enforce constraints except not null constraint.
-- So practice this on Online SQL Editors.
-- https://www.programiz.com/sql/online-compiler/

-----------------
drop table customers;
drop table orders;
drop table shippings;

----------------
CREATE TABLE customers
(   cust_id INTEGER,
    cust_name VARCHAR(30) NOT NULL,
    address VARCHAR(50),
    city_cd VARCHAR(3) references city(city_cd),
    acc_bal FLOAT check(acc_bal >= 1000),
    phone VARCHAR(20), 
    PRIMARY KEY (cust_id)    
);

CREATE TABLE orders
(    order_id INTEGER PRIMARY KEY,
     cust_id INTEGER references customers(cust_id),
     order_date DATE,
     total_price FLOAT check(total_price > 0),
     order_status VARCHAR(20) default 'New'
);

CREATE TABLE city
(    city_id INTEGER,
     city_cd VARCHAR(3) UNIQUE,
     city_name VARCHAR(20),
     PRIMARY KEY(city_id)
);

--------------
INSERT INTO customers values(101, 'Anurag', 'Flat 123\, abc colony','BAN', 4000,'9876543210');

-- Foreign key constraint failed, so first insert data into city table 
INSERT INTO city VALUES 
(1, 'BAN', 'Bangalore'),
(2, 'KOL', 'Kolkata'),
(3, 'HYD', 'Hyderabad'),
(4, 'CHN', 'Chennai'),
(5, 'MUM', 'Mumbai'),
(6, 'HYD', 'Hyderabad'), -- (6, 'PUN', 'Pune')
(6, 'DEL', 'Delhi'); -- (7, 'DEL', 'Delhi')

-- After fixing unique constraint violations
INSERT INTO city VALUES 
(1, 'BAN', 'Bangalore'),
(2, 'KOL', 'Kolkata'),
(3, 'HYD', 'Hyderabad'),
(4, 'CHN', 'Chennai'),
(5, 'MUM', 'Mumbai'),
(6, 'PUN', 'PUNE'),
(7, 'DEL', 'Delhi');

------------------------
-- Now, insert data into customers table 
INSERT INTO customers values
(101, 'Anurag', 'Flat 123, abc colony','BAN', 4000,'9876543210'),
(102, 'Balram', 'Flat 456, def colony','DEL', 15000,'9876598765'),
(103, 'Komal', 'Flat 789, ghi colony','MUM', 8500,'9876501234'),
(104, 'Priyanka', 'Flat 102, jkl colony','VIZ', 1000,'9876556789'),
(105, Null, 'Flat 203, mno colony','KOL', 600,'9988776655'),
(106, 'Nitin', 'Flat 40, pqr colony','PUN', 7000,'9998887776');

-- After fixing check, not null constraints violations 
INSERT INTO customers values
(101, 'Anurag', 'Flat 123, abc colony','BAN', 4000,'9876543210'),
(102, 'Balram', 'Flat 456, def colony','DEL', 15000,'9876598765'),
(103, 'Komal', 'Flat 789, ghi colony','MUM', 8500,'9876501234'),
(104, 'Priyanka', 'Flat 102, jkl colony','HYD', 1000,'9876556789'),
(105, 'Reshma', 'Flat 203, mno colony','KOL', 6000,'9988776655'),
(106, 'Nitin', 'Flat 40, pqr colony','PUN', 7000,'9998887776');

-------------------------
-- Now, insert data into orders table
INSERT INTO orders VALUES
(10011, 102, '2023-06-13', 2450.50, 'Shipped'),
(10012, 105, '2023-06-08', 4300, 'Out For Delivery'),
(10013, 108, '2023-06-15', 12750.90, 'Shipped');

-- after fixing foreign key constraint violation 
INSERT INTO orders VALUES
(10011, 102, '2023-06-13', 2450.50, 'Shipped'),
(10012, 105, '2023-06-08', 4300, 'Out For Delivery'),
(10013, 103, '2023-06-15', 12750.90, 'Shipped');

-- how default constraint works..
INSERT INTO orders(order_id, cust_id) values(10014, 101);

INSERT INTO orders(order_id, cust_id, total_price) values(10015, 104, 0);

-- after fixing check constraint
INSERT INTO orders(order_id, cust_id, total_price) values(10015, 104, 100);

---------------------
-- try deleting data from tables 
DELETE FROM city;
DELETE FROM customers;
-- we can't delete because of foreign key constraints ..

DELETE FROM orders; 
-- we can delete because we are not referencing orders table any where..

DELETE FROM customers;
DELETE FROM city;