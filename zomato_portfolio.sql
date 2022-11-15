DROP TABLE IF EXISTS goldusers_signup;
CREATE TABLE goldusers_signup(user_id INT,gold_signup_date DATE); 
INSERT INTO goldusers_signup(user_id,gold_signup_date) 
 VALUES (1,'2017-09-22'),
(3,'2017-04-21');

DROP TABLE IF EXISTS users;
CREATE TABLE users(user_id INT,signup_date DATE); 
INSERT INTO users(user_id,signup_date) 
 VALUES (1,'2014-09-02'),
(2,'2015-01-15'),
(3,'2014-04-11');

DROP TABLE IF EXISTS sales;
CREATE TABLE sales(user_id INT,created_date DATE,product_id INT); 
INSERT INTO sales(user_id,created_date,product_id) 
 VALUES (1,'2017-04-19',2),
(3,'2019-12-18',1),
(2,'2020-7-20',3),
(1,'2019-10-23',2),
(1,'2018-3-19',3),
(3,'2016-12-20',2),
(1,'2016-11-9',1),
(1,'2016-5-20',3),
(2,'2017-9-24',1),
(1,'2017-3-11',2),
(1,'2016-3-11',1),
(3,'2016-11-10',1),
(3,'2017-12-7',2),
(3,'2016-12-15',2),
(2,'2017-11-8',2),
(2,'2018-9-10',3);

DROP TABLE IF EXISTS product;
CREATE TABLE product(product_id INT,product_name TEXT,price INT); 
INSERT INTO product(product_id,product_name,price) 
 VALUES
(1,'p1',980),
(2,'p2',870),
(3,'p3',330);

SELECT * FROM goldusers_signup;
SELECT * FROM product;
SELECT * FROM sales;
SELECT * FROM users;




-- What is the total amount each customer spent on zomato?
SELECT sales.user_id,SUM(product.price) 
FROM sales
JOIN product
ON sales.product_id = product.product_id GROUP BY user_id;



-- How many days has each customer visited zomato?
SELECT user_id,COUNT(created_date) FROM sales GROUP BY user_id;



-- What was the first product purchased by each customer?
SELECT * FROM ( SELECT *, rank() over(partition by sales.user_id order by created_date) rnk FROM sales ) a WHERE rnk=1;



-- What is the most purchased item on the menu and how many times it has been purchased by all customers?
SELECT user_id,COUNT(user_id) FROM sales WHERE product_id=2 GROUP BY user_id ORDER BY user_id ASC;




-- Which item was the most popular for each customer?
SELECT * FROM (SELECT *, RANK() OVER(PARTITION BY user_id ORDER BY cnt DESC) rnk 
FROM ( SELECT user_id,product_id,COUNT(product_id) cnt FROM sales GROUP BY user_id,product_id)a)b WHERE rnk = 1;
