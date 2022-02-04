-- Created by Ingrid Ionita :)

CREATE DATABASE BTS_ALBUM_STORE;

USE BTS_ALBUM_STORE;

/** Just a note: this project was created very quickly and in not enough time so there might be
errors and mistakes here and there.**/

-- Creating the user related tables!

CREATE TABLE USER_ACCOUNT(
	username VARCHAR(45) UNIQUE NOT NULL,
	email_address VARCHAR(45) NOT NULL,
	passwords VARCHAR(45) NOT NULL,
CONSTRAINT
pk_username
PRIMARY KEY 
(username)
);


CREATE TABLE USERS(
	user_id INT NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	username VARCHAR(45) NOT NULL,
	mobile_phone VARCHAR(45) NULL,
CONSTRAINT
	pk_user_id
PRIMARY KEY (user_id),
CONSTRAINT
	fk_username
FOREIGN KEY (username) REFERENCES USER_ACCOUNT(username)
);


CREATE TABLE USER_ADDRESS(
	address_id INT NOT NULL,
	user_id INT NOT NULL,
	address_line_1 VARCHAR(45) NOT NULL,
	address_line_2 VARCHAR(45) NULL,
	postcode VARCHAR(45) NOT NULL,
	city VARCHAR(45) NOT NULL,
	country VARCHAR(45) NOT NULL,
CONSTRAINT
	pk_address_id 
PRIMARY KEY (address_id),
CONSTRAINT
	fk_user_id
FOREIGN KEY (user_id) REFERENCES USERS(user_id)
);


-- Creating the product related tables!


CREATE TABLE DISCOUNTS(
	discount_id INT NOT NULL,
	percent_off DECIMAL(2,2) NOT NULL,
	discount_name VARCHAR(45) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT
	pk_discount_id
PRIMARY KEY (discount_id));


CREATE TABLE PRODUCTS(
	product_id INT NOT NULL,
	product_type VARCHAR(45) NOT NULL,
	product_name VARCHAR(45) NOT NULL,
    price DECIMAL(4,2) NOT NULL,
    discount_id INT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT
	pk_product_id
PRIMARY KEY (product_id),
CONSTRAINT
	fk_discount_id
FOREIGN KEY (discount_id) REFERENCES DISCOUNTS(discount_id));


-- Creating the shopping session related tables!


CREATE TABLE ORDER_SESSION(
	session_id INT NOT NULL,
    user_id INT NOT NULL,
    session_money_total DECIMAL(4,2),
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT
	pk_session_id
PRIMARY KEY(session_id),
CONSTRAINT
	fk_user_id_2
FOREIGN KEY (user_id) REFERENCES USERS(user_id));


CREATE TABLE ORDER_BASKET(
	ob_id INT NOT NULL,
	session_id INT NOT NULL,
	product_id INT NOT NULL,
	items_amount INT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT
	fk_session_id
FOREIGN KEY (session_id) REFERENCES ORDER_SESSION(session_id),
CONSTRAINT
	fk_product_id
FOREIGN KEY (product_id) REFERENCES PRODUCTS(product_id));


-- Creating the order related tables!


CREATE TABLE ORDERS(
	order_id INT NOT NULL,
	user_id INT NOT NULL,
	payment_id INT NOT NULL,
    total_money DECIMAL(4,2),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT
	pk_order_id
PRIMARY KEY (order_id),
CONSTRAINT
	fk_user_id_3
FOREIGN KEY (user_id) REFERENCES USERS(user_id));


CREATE TABLE ORDER_PRODUCTS(
	op_id INT NOT NULL,
    order_id INT NOT NULL,
    session_id INT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT
	fk_order_id
FOREIGN KEY (order_id) REFERENCES ORDERS(order_id),
CONSTRAINT
	fk_session_id_2
FOREIGN KEY (session_id) REFERENCES ORDER_SESSION(session_id));

ALTER TABLE ORDER_PRODUCTS
ADD CONSTRAINT pk_op_id PRIMARY KEY(op_id);


-- Now to the payment method..


CREATE TABLE ORDER_PAYMENT(
	payment_id INT NOT NULL,
	op_id INT NOT NULL,
    total_to_pay DECIMAL(4,2),
    bank_name VARCHAR(50),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT
	pk_payment_id
PRIMARY KEY(payment_id),
CONSTRAINT
	fk_op_id
FOREIGN KEY (op_id) REFERENCES ORDER_PRODUCTS(op_id));


-- Now I need to add the payment_id foreign key into orders table.

ALTER TABLE ORDERS
ADD CONSTRAINT fk_payment_id FOREIGN KEY (payment_id) REFERENCES ORDER_PAYMENT(payment_id);

-- Everything is linked up, so now I will have to add the data inside the tables. 

INSERT INTO USER_ACCOUNT
	(username, email_address, passwords)
VALUES
('Koya', 'jhbfhdfbf7748', 'namjoonk@outlook.co.uk'),
('RJ', 'dhbhbvd767', 'worldwidehandsome@gmail.com'),
('Cooky', '7575fudfb', 'bamiscute0109@gmail.co.uk'),
('Chimmy', '87ybhdb', 'walkinthepark@yahoo.co.uk'),
('Tata', 'fjhbgv86', 'pandaexpresslover@yahoo.com'),
('Mang', 'raea88t', 'hobiworld1802@gmail.com'),
('Shooky', 'hjdbgdbfb895', 'augustd2@outlook.com');


INSERT INTO USERS 
	(user_id, first_name, last_name, username, mobile_phone)
VALUES
(1, 'Najoon', 'Kim', 'Koya', '078 4261 0289'),
(2, 'Seokjin', 'Kim', 'RJ', '070 8189 8539'),
(3, 'Jungkook', 'Jeon', 'Cooky', '079 7051 6156'),
(4, 'Jimin',	'Park', 'Chimmy', '078 4773 0156'),
(5, 'Taehyung',	'Kim', 'Tata', '078 4241 5413'),
(6, 'Hoseok', 'Jung', 'Mang', '078 3612 0660'),
(7, 'Yoongi', 'Min', 'Shooky', '079 5903 5216');


INSERT INTO USER_ADDRESS
	(address_id, user_id, address_line_1, address_line_2, postcode, city, country)
VALUES
(12, 1, N'79 Uxbridge Road', NULL, N'BN18 9NF', N'Slindon', N'Ireland'),
(13, 2, N'67 York Road', ' ', N'KT22 7BU', N'Oxshott', N'Northern Ireland'),
(14, 3, N'89 South Street', NULL, N'KY15 6LR', N'Moonzie', N'Scotland'),
(15, 4, N'140 Graham Road', ' ', N'NE61 2DU', N'Chevington', N'Ireland'),
(16, 5, N'128 Seafield Street', ' ', N'LL65 4HG', N'Llechcynfarwy', N'Wales'),
(17, 6, N'25 Great Western Road', NULL, N'PE12 9LL', N'Long Sutton', N'England'),
(18, 7, N'76 Bishopgate Street',	NULL, N'TN33 5BE', N'London', N'England');


-- The next set of values will be for the products the online store is offering!

INSERT INTO DISCOUNTS
	(discount_id, percent_off, discount_name)
VALUES
	(560, 0.70, 'Black Friday'),
	(561, 0.50, 'Christmas'),
	(562, 0.15, 'Easter Holidays'),
	(563, 0.25, 'Valentines Day'),
	(564, 0.10, 'Student'),
	(565, 0.10, 'NHS');
    
    
INSERT INTO PRODUCTS
	(product_id, product_type, product_name, price, discount_id)
VALUES
(150, 'Album', N'Love Yourself: Answer', 34.99, 560),
(151, 'Album', N'Map Of The Soul: 7', 29.99, 560),
(152, 'Album', N'BE', 59.99, 560),
(153, 'Album', N'Wings', 34.99, 560),
(154, 'Album', N'Face Yourself', 6.99, 560),
(155, 'Album', N'Skool Luv Affair', 29.99, 564),
(156, 'Album', N'2 Cool 4 Skool', 29.99, 564),
(15, 'Album', N'O!RUL8,2?', 29.99, 564),
(158, 'Album', N'Love Yourself: Tear', 29.99, 564),
(159, 'Album', N'Love Yourself: Her', 29.99, 564),
(160, 'Album', N'Dark & Wild', 34.99, 560),
(161, 'Album', N'HYYH: Young Forever', 39.99, 560),
(162, 'Album', N'You Never Walk Alone', 37.99, 560),
(163, 'Album', N'HYYH Pt 2.', 31.99, 560),
(164, 'Album', N'Butter', 24.99, 560);

SELECT * FROM PRODUCTS;

-- I made a mistake and inserted the value '15' instead of '157'

UPDATE PRODUCTS
SET
	product_id = 157
WHERE
	product_name = N'O!RUL8,2?';
    
    
-- SELF-REMINDER: The remaining tables are: order_basket, order_payment, order_products, order_session, orders & shipment.


INSERT INTO ORDER_SESSION
	(session_id, user_id, session_money_total)
VALUES
	(111, 1, 29.99),
	(112, 2, 94.98),
	(113, 4, 24.99),
	(114, 3, 94.97),
	(115, 7, 86.97),
	(116, 6, 64.98),
	(117, 6, 36.87),
	(118, 5, 31.99),
	(119, 5, 99.97),
	(120, 3, 29.99),
	(121, 7, 24.99);
    
    
INSERT INTO ORDER_BASKET
	(ob_id, session_id, product_id, items_amount)
VALUES
	(300, 111, 156, 1),
	(302, 112, 151, 1),
	(303, 112, 152, 1),
	(304, 113, 164, 1),
	(306, 114, 158, 1),
	(307, 114, 159, 1),
	(308, 114, 160, 1),
	(309, 115, 151, 1),
	(310, 115, 163, 1),
	(311, 115, 164, 1),
	(312, 116, 162, 1),
	(313, 116, 151, 1),
	(314, 117, 157, 1),
	(315, 117, 150, 1),
	(316, 118, 163, 1),
	(318, 119, 155, 1),
	(319, 119, 157, 1),
	(320, 119, 152, 1),
	(321, 120, 157, 1),
	(322, 121, 164, 1);
    
    
INSERT INTO ORDER_PAYMENT
	(payment_id, op_id, total_to_pay, bank_name)
VALUES
	(900, 700, 29.99, 'Barclays'),
    (901, 701, 94.98, 'Barclays'),
    (902, 702, NULL, NULL),
    (903, 703, 94.97, 'Lloyds'),
    (904, 704, 86.97, 'HSBC'),
	(905, 705, NULL, NULL),
    (906, 706, 36.87, 'Barclays'),
    (907, 707, 31.99, 'NatWest'),
    (908, 708, 99.97, 'Natwest'),
    (909, 709, 29.99, 'Lloyds'),
	(910, 710, NULL, NULL);
    

INSERT INTO ORDERS
	(order_id, user_id, payment_id, total_money)
VALUES
	(400, 1, 900, 29.99),
    (401, 2, 901, 94.98),
    (402, 4, 902, NULL),
    (403, 3, 903, 94.97),
    (404, 7, 904, 86.97),
    (405, 6, 905, NULL),
    (406, 6, 906, 36.87),
    (407, 5, 907, 31.99),
    (408, 5, 908, 99.97),
    (409, 3, 909, 29.99),
    (410, 7, 910, NULL);
    
/** I had to do the ALTER TABLE really quickly to fix something because I was running out of
time; not the best practice though.. **/

ALTER TABLE ORDERS
DROP CONSTRAINT fk_payment_id;

ALTER TABLE ORDERS
ADD CONSTRAINT fk_payment_id FOREIGN KEY (payment_id) REFERENCES ORDER_PAYMENT(payment_id);

-- Continuing..

INSERT INTO ORDER_PRODUCTS
	(op_id, order_id, session_id)
VALUES
	(700, 400, 111),
    (701, 401, 112),
    (702, 402, 113),
    (703, 403, 114),
    (704, 404, 115),
    (705, 405, 116),
    (706, 406, 117),
    (707, 407, 118),
    (708, 408, 119),
    (709, 409, 120),
    (710, 410, 121);

/** I had to do the ALTER TABLE really quickly to fix something because I was running out of
time; not the best practice though.. **/

ALTER TABLE ORDER_PRODUCTS
DROP CONSTRAINT fk_order_id;

ALTER TABLE ORDER_PRODUCTS
ADD CONSTRAINT fk_order_id FOREIGN KEY (order_id) REFERENCES ORDERS(order_id);


/** Using  any  type  of  the  joins  create  a  view  that combines multiple tables in a logical way
This LEFT JOIN shows us how much money each user spent in our online shop. **/

SELECT USERS.user_id, ORDER_SESSION.session_money_total
FROM USERS
LEFT JOIN ORDER_SESSION ON USERS.user_id = ORDER_SESSION.user_id;

-- BASIC: This multiple column LEFT JOIN will show me how much the customers spent and where they are from!

SELECT U.user_id, U.first_name, U.last_name, 
	OS.session_money_total AS money_spent,UA.country AS where_from_customers
FROM USERS u
LEFT JOIN ORDER_SESSION OS
ON U.user_id = OS.user_id
LEFT JOIN USER_ADDRESS UA
ON U.user_id = UA.user_id;


-- BASIC: In your database, create a stored function that can be applied to a query in your database.

DELIMITER $$

CREATE FUNCTION MARKETRarity(
	price DECIMAL (4,2)
)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
	DECLARE MARKETRarity VARCHAR(20);
    IF price > 50.00 THEN
		SET MARKETRarity = 'VERY RARE';
	ELSEIF (price <= 50.00 AND
		price >= 40.00) THEN
        SET MARKETRarity = 'RARE';
	ELSEIF (price < 40.00 AND
		price >= 30.00) THEN
        SET MARKETRarity = 'COMMON';
	ELSEIF price < 30.00 THEN
		SET MARKETRarity = 'VERY COMMON';
	END IF;
    
    RETURN (MARKETRarity);

END $$

DELIMITER ;

 -- Seeing the function.
 
SHOW FUNCTION STATUS
WHERE db = 'BTS_ALBUM_STORE';

 -- Seeing its results. We can use this data to market the items appropiately; a lot of fans are after rarer editions and albums!
 
SELECT * FROM PRODUCTS;

SELECT
	product_name,
    CARDRarity(price)
FROM 
	PRODUCTS
ORDER BY
	product_name;


/** BASIC: Prepare  an  example  query  with  a  subquery  to demonstrate  how  to  extract  data  from  your  database  for analysis. 
With this subquery I wanted to see how many products are affordable to our customers. We have a good range! **/

SELECT * FROM (SELECT product_name, product_id, price
FROM PRODUCTS
WHERE price BETWEEN 1.00 AND 30.00) AS affordable_products;


/** ADVACED: Prepare an example query with group by and having  to  demonstrate  how  to  extract  data.
With this query I am looking at my highest paying customers; we could create a VIP club for them to 
make them have a repeat purchase! **/

SELECT os.user_id, os.session_money_total FROM order_session os GROUP BY session_money_total;

SELECT user_id, order_id, total_money AS 'Highest Paying Customer'
FROM ORDERS
GROUP BY 2,1
HAVING total_money >= 50;

SELECT * FROM ORDERS;

/** Double checking that all my tables have the data I inputted (I had a minor issue 
where a table didn't have the data and I was struggling to understand why it won't
give me back data after having a query.**/


SELECT * FROM DISCOUNTS;
SELECT * FROM ORDER_BASKET;
SELECT * FROM ORDER_PAYMENT;
SELECT * FROM ORDER_PRODUCTS;
SELECT * FROM ORDER_SESSION;
SELECT * FROM ORDERS;
SELECT * FROM PRODUCTS;
SELECT * FROM USER_ACCOUNT;
SELECT * FROM USER_ADDRESS;
SELECT * FROM USERS;

/** ADVANCED: Create  a  view  that  uses  at  least  3-4  base 
tables; prepare and demonstrate a query that 
uses the view to produce a logically arranged 
result set for analysis. **/
/** This view is to see how much money our customers spent in our shop;
it would be useful to see how much is spent and items that are quite popular
so we always have them in stock and/or buy more to sell. **/


CREATE VIEW how_much_money_spent AS
SELECT U.user_id, U.first_name, U.last_name, 
	OS.session_money_total AS money_spent, UA.country AS where_from_customers
FROM USERS u
LEFT JOIN ORDER_SESSION OS
ON U.user_id = OS.user_id
LEFT JOIN USER_ADDRESS UA
ON U.user_id = UA.user_id;

SELECT * FROM how_much_money_spent;

-- Creating another view to see the products bringing in most of our revenue!

CREATE VIEW popular_products AS
SELECT OB.product_id, 
	P.product_name AS product_name, OS.session_money_total AS money_spending 
FROM ORDER_BASKET OB
LEFT JOIN ORDER_SESSION OS
ON OB.session_id = OS.session_id
LEFT JOIN PRODUCTS P
ON OB.product_id = P.product_id;

SELECT * FROM popular_products;

SELECT pp.product_id, pp.product_name, pp.money_spending FROM popular_products pp GROUP BY product_name HAVING money_spending >= 80.00;

-- Completed 02/12/2021!