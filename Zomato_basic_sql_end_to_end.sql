-- Creating new Tables for our project and adding values to it.

Drop table if exists Z_Goldusers_signup;		-- Drop table if it already exists.
CREATE TABLE Z_Goldusers_signup(Userid integer,Gold_signup_date date); -- Create a table with table name, column name and column type.

INSERT INTO Z_Goldusers_signup(Userid,Gold_signup_date)  -- Insert values in the created table.
 VALUES (1,'09-22-2017'),
(3,'04-21-2017');



Drop table if exists Z_Users;
CREATE TABLE Z_Users(Userid integer,Signup_date date); 

INSERT INTO Z_Users(Userid,Signup_date) 
 VALUES (1,'09-02-2014'),
(2,'01-15-2015'),
(3,'04-11-2014');



Drop table if exists Z_Sales;
CREATE TABLE Z_Sales(Userid integer,Created_date date,Product_id integer); 

INSERT INTO Z_Sales(Userid,Created_date,Product_id) 
 VALUES (1,'04-19-2017',2),
(3,'12-18-2019',1),
(2,'07-20-2020',3),
(1,'10-23-2019',2),
(1,'03-19-2018',3),
(3,'12-20-2016',2),
(1,'11-09-2016',1),
(1,'05-20-2016',3),
(2,'09-24-2017',1),
(1,'03-11-2017',2),
(1,'03-11-2016',1),
(3,'11-10-2016',1),
(3,'12-07-2017',2),
(3,'12-15-2016',2),
(2,'11-08-2017',2),
(2,'09-10-2018',3);




Drop table if exists Z_Product;
CREATE TABLE Z_Product(Product_id integer,Product_name text,Price integer); 

INSERT INTO Z_Product(Product_id,Product_name,price) 
 VALUES
(1,'p1',980),
(2,'p2',870),
(3,'p3',330);




select * from Z_Sales;
select * from Z_Product;
select * from Z_Goldusers_signup;
select * from Z_Users;


-- What is total amount each customer spent on Zomato ?
Select s.Userid,sum(p.price) as Total_Spent_amount from Z_Sales s
Left JOIN Z_Product p
ON s.product_id = p.product_id
group by  s.userid

-- What is total amount each customer spent Product wise on Zomato ?
Select s.Userid, s.Product_id,sum(p.price) as Total_Spent_amount from Z_Sales s
Left JOIN Z_Product p
ON s.product_id = p.product_id
group by  s.userid,s.Product_id
Order by  s.userid

-- How many days has each customer visited Zomato ?
Select s.Userid,COUNT(distinct s.Created_date) as Number_of_days_visited from Z_Sales s
Left JOIN Z_Product p
ON s.product_id = p.product_id
group by  s.userid
Order by  s.userid

-- What is the first product purchased by each customer ?
with First_product as
	(
	Select * , Rank()over(partition by userid order by Created_date) as First_product
	from Z_Sales
	)
Select Userid, Created_date,Product_id 
from First_product 
where First_product = 1

-- What is the most purchased item and how many times was it purchased by all customers?
Select top 1 Product_id,count(Product_id) Total_times_purchased
from Z_Sales
group by Product_id
Order by Total_times_purchased Desc

-- WHich is the most favourite product for each customer ?
with Favourite as
(Select userid, Product_id,count(product_id) product_count, rank()over(partition by userid order by count(product_id) desc) Rnk
from Z_Sales
group by userid,product_id
)
select Userid, Product_id
from Favourite
where Rnk = 1





