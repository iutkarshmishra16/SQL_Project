drop table if exists Books;
Create table Books(
Book_ID	serial primary key,
Title	varchar(100),
Author	varchar(100),
Genre	varchar(50),
Published_Year	int,
Price	numeric(10, 2),
Stock	int
);

drop table if exists Customers;
create table Customers(
Customer_ID	serial primary key,
Name	varchar(100),
Email	varchar(100),
Phone	varchar(20),
City	varchar(50),
Country	varchar(150)
);


drop table if exists Orders;
Create table Orders(
Order_ID	serial primary key,
Customer_ID	int,
Book_ID	int,
Order_Date	DATE,
Quantity	int,
Total_Amount	numeric(10, 2)
);

select * from books
select * from customers
select * from orders


--1) Retrieve all books in the "Fiction" genre:

select * from books
where genre = 'Fiction';

--2) Find books published after the year 1950:

select * from books 
where published_year > 1950;


--3) list all the customers from the Canada:

select * from customers
where country = 'Canada';

--4) show orders placed in november 2023:
 
 select * from orders 
 where order_date between '2023-11-01' and '2023-11-30';

--5) retrieve the total stock 0f books available:

select sum(stock) as total_stock 
from books;

--6) find the details of the most expensive book:

select * from books
order by(price) desc
limit 1;

--7) show all customers who order more than 1 quantity of a book:

select * from orders
where quantity > 1;


-- 8) retrieve all orders where the total amount exceeds $20:

select * from orders
where total_amount > 20;

--9) list all genres available in the books table:

select distinct genre
from books

--10) find the book with the lowest stock:

select * from books
order by stock 
limit 1;

--11) calculate the total revenue generated from all orders:

select sum(total_amount) as revenue from orders;

-- ADVANCE QUESTIONS:

--1) retrieve the total number of books sold for each genre:

 select * from orders;

 select b.genre, sum(o.quantity) as total_books_sold
 from orders o
 join books b on o.book_id = b.book_id
 group by b.genre;

--2) find the average price of books in the "Fantasy" genre:

 select avg(price) from books
 where genre = 'Fantasy';

--3) list customers who have placed at least 2 orders:

select o.customer_id , c.name , count(o.Order_id) as order_count
from orders o
join customers c on o.customer_id = c.customer_id
group by o.customer_id , c.name
having count(order_id) >= 2;

--4) find the most frequently ordered book:

select o.book_id , b.title, count (o.order_id) as order_count
from orders o
join books b  on o.book_id = b.book_id
group by o.book_id , b.title
order by order_count desc
limit 1;

--5) show the top 3 most expensive books of 'fantasy' genre:

select * from orders
where genre = 'Fantasy'
ORDER BY price desc limit 3;

--6) retrieve the total quantity of books sold for each author:

select  b.author, sum(quantity) as total_quantity
from orders o
join books b on o.book_id = b.book_id
group by b.author ;

--7) list the cities where customers who spent over $30 are located:

select  distinct c.city , o.total_amount
from customers c
join orders o on c.customer_id = o.customer_id
group by c.city , c.customer_id , o.total_amount
having o.total_amount > 30;

--8) find the customers who spent the most on orders:

select  c.name , c.customer_id , sum(o.total_amount) as total_spent
from customers c
join orders o on c.customer_id = o.customer_id
group by c.name , c.customer_id
order by total_spent desc limit 1;

--9) calculate the stock remaining after fulfilling all orders:

select b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity), 0) as order_quantity,
b.stock - COALESCE(SUM(o.quantity), 0) as Remaining_quantity
from books b
left join orders o on b.book_id = o.book_id
group by b.book_id;

