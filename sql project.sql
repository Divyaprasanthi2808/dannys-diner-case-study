CREATE SCHEMA dannys_diner;
SET search_path = dannys_diner;

CREATE TABLE sales (
  "customer_id" VARCHAR(1),
  "order_date" DATE,
  "product_id" INTEGER
);

INSERT INTO sales
  ("customer_id", "order_date", "product_id")
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
 

CREATE TABLE menu (
  "product_id" INTEGER,
  "product_name" VARCHAR(5),
  "price" INTEGER
);

INSERT INTO menu
  ("product_id", "product_name", "price")
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  

CREATE TABLE members (
  "customer_id" VARCHAR(1),
  "join_date" DATE
);

INSERT INTO members
  ("customer_id", "join_date")
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');

--What is the total amount each customer spent at the restaurant?
select sales.customer_id,sum(price) from sales
join menu on sales.product_id=menu.product_id
group by sales.customer_id
order by sales.customer_id;

--How many days has each customer visited the restaurant?
select customer_id,count(distinct(order_date)) from sales
group by customer_id;

--What was the first item from the menu purchased by each customer?
select customer_id,product_name,order_date from sales 
join menu on sales.product_id = menu.product_id
where order_date = (select min(order_date) from sales)
order by customer_id

--What is the most purchased item on the menu and how many times was it purchased by all customers?
select menu.product_name,count(sales.product_id) from sales
join menu on sales.product_id = menu.product_id
group by menu.product_name
order by count(sales.product_id) desc
limit 1


--Which item was the most popular for each customer?
WITH popular AS (
    SELECT 
        customer_id, 
        MAX(purchase_count) AS max_purchase_count
    FROM (
        SELECT 
            customer_id, 
            menu.product_name, 
            COUNT(sales.product_id) AS purchase_count
        FROM 
            sales
        JOIN 
            menu ON menu.product_id = sales.product_id
        GROUP BY 
            customer_id, menu.product_name
        ORDER BY 
            customer_id, purchase_count DESC
    ) AS subquery
    GROUP BY customer_id
)
select sales.customer_id, menu.product_name, count(sales.product_id) as purchase_count from sales
join menu on menu.product_id = sales.product_id
join popular on sales.customer_id=popular.customer_id
group by sales.customer_id,menu.product_name,popular.max_purchase_count
having count(sales.product_id)=popular.max_purchase_count
order by sales.customer_id,popular.max_purchase_count

--Which item was purchased first by the customer after they became a member?
select sales.customer_id,product_name,order_date,join_date from sales
join members on sales.customer_id=members.customer_id
join menu on sales.product_id = menu.product_id
where sales.order_date >= members.join_date 
and sales.order_date = (select min(order_date) from sales s 
join members m on s.customer_id = sales.customer_id 
where  order_date >= members.join_date )
order by sales.customer_id;

--What is the total items and amount spent for each member before they became a member?
select sales.customer_id,count(sales.customer_id) as total_items,sum(price) from sales
join members on sales.customer_id=members.customer_id
join menu on sales.product_id = menu.product_id
where sales.order_date < members.join_date
group by sales.customer_id
order by sales.customer_id;

--If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
select customer_id,sum(
case when product_name = 'sushi' then price*20
	 else price*10
end ) as total_points from sales s
join menu m on s.product_id = m.product_id
group by customer_id
order by customer_id

--In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not 
--just sushi - how many points do customer A and B have at the end of January?
select s.customer_id,sum(
case when s.order_date between mem.join_date and (mem.join_date + interval '6 day') then
		price*20
	 when product_name = 'sushi'then 
	 	price*20
	 else 
	 	price*10
end ) as total_points from sales s
join menu m on s.product_id = m.product_id
join members mem on s.customer_id = mem.customer_id
where order_date <= '2022-01-31'
group by s.customer_id
order by s.customer_id;

--Bonus Questions
with temptable as (select s.customer_id,order_date,product_name,price,
case 
	when  mem.customer_id is not null and s.order_date >= mem.join_date then
		'Y'
	else
		'N'	
end as member
from sales s
left join members mem on mem.customer_id = s.customer_id
join menu m on s.product_id = m.product_id
)
select customer_id,order_date,product_name,price,member ,
case 
	when member = 'N' then NULL
	else 
	dense_rank() over(partition by customer_id order by order_date )
end as ranking
from temptable
order by customer_id,order_date;







