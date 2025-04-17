use projects_DB

create table Staging_sales
(
Row_ID INT,
    Order_ID VARCHAR(20),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(50),
    Customer_ID VARCHAR(20),
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50),
    Country VARCHAR(50),
    City VARCHAR(100),
    State VARCHAR(100),
    Postal_Code VARCHAR(20),
    Region VARCHAR(50),
    Product_ID VARCHAR(20),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name VARCHAR(200),
    Sales FLOAT,
    Quantity INT,
    Discount FLOAT,
    Profit FLOAT
)

select * from dbo.Staging_sales

--CREATING STAR SCHEMA (WAREHOUSE TABLES):

CREATE TABLE customer_dimention 
(
	customer_key INT identity(1,1) primary key,
	customer_id VARCHAR(30) ,
	customer_Name varchar(50),
	segment varchar (50)
)

select * from customer_dimention

create table product_dimention 
(
	product_key int identity(1,1) primary key,
	product_id varchar(30),
	product_name varchar(200),
	category varchar(50),
	sub_category varchar(50)
)

select * from product_dimention

create table region_dimention
(
	region_key int identity(1,1) primary key,
	country varchar(50),
	state varchar(50),
	city varchar(50),
	region varchar(50)
)
select * from region_dimention

create table Date_dimension 
(
	date_key int primary key,
	full_date Date,
    year INT,
    month INT,
    day INT,
    day_name VARCHAR(20)
)
select * from Date_dimension

create table fact_sales 
(
sales_key int identity(1,1) primary key,
order_id varchar(30),
order_date date,
ship_date Date,
ship_mode varchar(30),
customer_key int,
product_key int,
region_key int,
date_key int,
sales float,
quantity int,
discount float,
profit float
foreign key (customer_key) references customer_dimention (customer_key),
foreign key (product_key) references product_dimention (product_key),
foreign key (region_key) references region_dimention(region_key),
foreign key (date_key) references Date_dimension(date_key)
)

select * from fact_sales

-- POPULATE DIMENSIONS FROM STAGING TABLE:
-- INSERTING DATA INTO CUSTOMER_DIMENSION TABLE FROM STAGING_SALES:
insert into customer_dimention (customer_id,customer_Name,segment)
select distinct Customer_ID,Customer_name,segment
from Staging_sales


-- INSERTING DATA INTO product_dimention TABLE FROM STAGING_SALES:
INSERT INTO product_dimention(product_id,product_name,category,sub_category)
SELECT DISTINCT Product_ID,Product_Name,Category,Sub_Category
FROM Staging_sales

-- INSERTING DATA INTO REGION_DIMENTION TABLE FROM STAGING_SALES:
insert into region_dimention (country,state,city,region)
select distinct Country,State,City,Region
from Staging_sales

-- INSERTING DATA INTO Date_dimension TABLE FROM STAGING_SALES:
insert into Date_dimension(date_key,full_date,year,month,day,day_name)
select distinct 
 CAST(FORMAT(Order_Date, 'yyyyMMdd') AS INT) AS date_key,
    Order_Date,
    YEAR(Order_Date),
    MONTH(Order_Date),
    DAY(Order_Date),
    DATENAME(WEEKDAY, Order_Date)
from Staging_sales

-- INSERTING DATA INTO FACT_SALES TABLE FROM STAGING_SALES:
INSERT INTO fact_sales 
(order_id,order_date,ship_date,ship_mode,customer_key,product_key,
region_key,date_key,sales,quantity,discount,profit)
SELECT

	s.Order_ID,
	s.Order_Date,
	s.Ship_Date,
	s.Ship_Mode,
	c.customer_key,
	p.product_key,
	r.region_key,
	cast(format(s.Order_Date,'yyyyMMdd') as INT) AS date_key,
	s.Sales,
	s.Quantity,
	s.Discount,
	s.Profit
from Staging_sales as s
	JOIN customer_dimention as c
	ON s.Customer_ID =c.customer_id
	JOIN product_dimention as p
	ON s.Product_ID = p.product_id
	JOIN region_dimention as r
	ON s.Country = r.country AND s.State = r.state AND s.City = r.city
	AND s.Region = r.region

select * from fact_sales
select MAX(LEN(Ship_Mode))as length from Staging_sales