-- select the paid and unpaid order from the order table
select paid, count(*)  FROM orders 
group BY paid;

-- Select the data from user and order and join both table check if it is paid or not

select first_name, last_name, paid 
FROM users 
JOIN orders on users.id = orders.user_id;

--
select * 
From products 
order by price 
LIMIT 20
OFFSET 20;

-- 
select name FROM phones order by price DESC LIMIT 2 OFFSET 1;

-- GET THE MOST EXPENSIVE ITEM AND WICH HAS LESS WEIGHT
(
SELECT * 
FROM products 
ORDER BY price DESC 
LIMIT 4
) UNION (
SELECT * FROM 
products 
ORDER BY price / weight DESC 
LIMIT 4
);

-- FIND THE COMMON ROW BETWEEN BOTH ROW S
(
SELECT * 
FROM products 
ORDER BY price DESC 
LIMIT 4
) INTERSECT (
SELECT * FROM 
products 
ORDER BY price / weight DESC 
LIMIT 4
);

-- 
(select * 
from products 
ORDER BY price desc 
LIMIT 4)
EXCEPT 
(SELECT  * from 
products 
ORDER BY price / weight DESC 
LIMIT 4);


select manufacturer from phones where price < 170
UNION 
select manufacturer from phones group by manufacturer 
having count(*) > 2;


select name, price
FROM products 
WHERE price > (
select max(price) FROM products  WHERE department = 'Toys'
)

SELECT product_id, COUNT(*)
FROM orders
GROUP BY product_id;

--- select max price and then make price_ratio
select name, price, price/ (select max(price) from phones)
as price_ratio from phones;


select first_name
FROM users 
JOIN orders 
on orders.user_id = users.id 
WHERE orders.product_id = 3


select id FROM orders  
WHERE product_id in
(select id
FROM products
WHERE price / weight > 50);


select name, price 
FROM products
WHERE price > (select AVG(price) FROM products where department = 'Toys')


SELECT name, price 
FROM products 
WHERE price > (select price FROM products WHERE name = 'Practical Fresh Shirt');

select name, department FROM products WHERE department not in 
(select department FROM products WHERE price < 100)

select name, department, price FROM products WHERE price > ALL (
select price FROM products WHERE department = 'Industrial'
)

select name, department, price FROM products WHERE price > SOME (
select price FROM products WHERE department = 'Industrial')

select name, price FROM products WHERE price > (
select Max(price) FROM products WHERE weight > 20
)

select name, department FROM products WHERE department NOT IN(
SELECT department FROM products WHERE price < 100)
-- select * FROM products;

--- write a query any phone made by samsung and price is greater then it
select name FROM products WHERE price > ALL(
select price FROM products WHERE department = 'Toys')

-- Show the name deparment and price of the most expensive product in each department 
select name, department, price FROM products as p1 WHERE price  = (
select max(price) FROM products as p2 WHERE p1.department = p2.department)

-- Without using join or group by print the number of order for each product 
select first_name FROM users
join(select user_id FROM orders where product_id = 3) as  
o on o.user_id = users.id;

-- Same query as above 
select first_name from users join users on orders.user_id = users.id 
where orders.product_id = 3

-- Unique department from products 
select count( DISTINCT department) FROM products

-- select Gretest then 30 
SELECT name, weight, GREATEST (30, 2 * weight) from products;

-- Least 
select name, price , LEAST (price * 0.5, 400) from products;

-- case 
select name, price ,
CASE
WHEN price > 600 then 'high'
ELSE 'cheap' 
END from products 

-- Interval 
SELECT ('1 day':: INTERVAL)
SELECT ('1 D 20 H 30':: INTERVAL)
-- WITH TIME ZONE 
select ('Nov 20 1980 1:23 AM EST':: TIMESTAMP WITH TIMEZONE)