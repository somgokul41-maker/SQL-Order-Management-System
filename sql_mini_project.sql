show databases;
create database order_management_db;
use order_management_db;
create table customers(
customer_id int,
customer_name varchar(100),
email varchar(100),
city varchar(50),
state varchar(50),
join_date date
);
insert into customers values
(1, 'gokul', 'gokul@gmail.com','madurai', 'TN', '2025-01-10'),
(2, 'ramar', 'ramar@gmail.com','viruthunagar', 'TN', '2025-03-18'),
(3, 'yosuva', 'yosuva@gmail.com','viruthunagar', 'TN', '2025-02-07'),
(4, 'munees', 'munees@gmail.com','delhi', 'DL', '2025-08-20'),
(5, 'vicky', 'vicky@gmail.com','hyderabad', 'TS', '2025-05-15'),
(6, 'gokila', 'gokila@gmail.com','bangalore', 'KN', '2025-06-05'),
(7, 'vasuki', 'vasuki@gmail.com','madurai', 'TN', '2025-07-10'),
(8, 'maha', 'maha@gmail.com','bangalore', 'KN', '2025-09-11'),
(9, 'priya', 'priya@gmail.com','hyderabad', 'TS', '2025-01-18'),
(10, 'roshan', 'roshan@gmail.com','bangalore', 'KN', '2025-02-12');

create table products (
product_id int,
product_name varchar(100),
category varchar(50),
price int,
stock int,
supplier varchar(50)
);

insert into products values
(101, 'laptop', 'electronics', 60000, 20, 'dell'),
(102, 'keyboard', 'accessories', 2200, 60, 'hp'),
(103, 'mouse', 'accessories', 1000, 120, 'logi'),
(104, 'carger', 'accessories', 45000, 40, 'mi'),
(105, 'speaker', 'audio', 10000, 18, 'sony'),
(106, 'headset', 'accessories', 18000, 10, 'boat'),
(107, 'monitor', 'electronics', 15000, 45, 'dell'),
(108, 'printer', 'electronics', 9000, 15, 'canon'),
(109, 'mobile', 'electronics', 30000, 50, 'samsung'),
(110, 'tablet', 'electronics', 55000, 25, 'apple');

create table orders(
order_id int,
customer_id int,
status varchar(50),
total_amount int,
ship_city varchar(40)
);

insert into orders values
(201, 1, 'delivered', 10000, 'madurai'),
(202, 2, 'shipped', 55000, 'chennai'),
(203, 3, 'pending', 3000, 'trichy'),
(204, 4, 'cancelled', 40000, 'erode'),
(205, 5, 'pending', 5000, 'coimbatore'),
(206, 6, 'delivered', 18000, 'vellore'),
(207, 7, 'shipped', 48000, 'madurai'),
(208, 8, 'cancelled', 1000, 'trichy'),
(209, 9, 'delivered', 80000, 'erode'),
(210, 10, 'shipped', 15000, 'madurai');

create table order_items(
item_id int,
order_id int,
product_id int,
quantity int,
price int,
sub_total int
);

insert into order_items value
(1, 201, 101, 4, 2000, 8000),
(2, 202, 102, 1, 40000, 40000),
(3, 203, 103, 2, 500, 1000),
(4, 204, 104, 1, 10000, 10000),
(5, 205, 105, 3, 3000, 9000),
(6, 206, 106, 4, 20000, 80000),
(7, 207, 107, 1, 2300, 2300),
(8, 208, 108, 2, 2500, 5000),
(9, 209, 109, 1, 8000, 48000),
(10, 210, 110, 5, 2, 1000);

create table payments(
payment_id int,
order_id int,
method varchar(40),
amount int,
status varchar(40)
);

insert into payments value
(1, 201, 'upi', 10000, 'paid'),
(2, 202, 'cash', 55000, 'pending'),
(3, 203, 'card', 3000, 'refunded'),
(4, 204, 'cash', 40000, 'paid'),
(5, 205, 'upi', 5000, 'paid'),
(6, 206, 'card', 18000, 'refunded'),
(7, 207, 'card', 48000, 'pending'),
(8, 208, 'card', 1000, 'pending'),
(9, 209, 'cash', 80000, 'pending'),
(10, 210, 'cash', 15000, 'paid');


select * from customers;

select * from customers
where customer_name = 'gokul';

select * from customers
order by join_date asc;

select * from payments
order by amount desc
limit 5;

SELECT * FROM payments
WHERE method= 'card' 
AND amount > 1000;

SELECT * FROM payments
WHERE method= 'Cash' 
OR method = 'upi';

SELECT * FROM payments
WHERE NOT status = 'paid';

SELECT COUNT(*) AS total_products
FROM products;

select sum(price) as total_price
from products;


select avg (price) as total_price
from products;

select o.product_id,p.payment_id
from order_items o
inner join payments p
on o.order_id = p.order_id;


select p.category,o.quantity
from products p
left join order_items o
on p.price = o.price;


select p.category,o.quantity
from products p
right join order_items o
on p.price = o.price;


select p.category,o.quantity
from products p
left join order_items o
on p.price = o.price
union
select p.category,o.quantity
from products p
right join order_items o
on p.price = o.price;

select order_id,count(amount) as total_amount
from payments
group by order_id;

select product_name,sum(price) as total_price
from products
group by product_name
having sum(price)>20000;

select item_id,price
from order_items
where price >(
select avg (price)
from order_items
);


create view product_details as
select p.product_name,p.stock,o.quantity,o.price
from products p
join order_items o
on p.product_id =o.product_id;
select * from product_detail;

create index idx_product_price
on products (price);
select * from products
where price <30000;

delimiter $$
create procedure get_all_orders()
begin
select * from orders;
end $$
delimiter ;
call get_all_orders();
