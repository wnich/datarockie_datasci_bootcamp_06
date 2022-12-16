-- Author: Wanicha Mueangcharoen
-- Restaurant Owners
-- 5 Tables
-- 1x Fact & 4x Dimension
-- Q:how to add foreign key
-- write SQL 3-5 queries analyze data
-- 1x subquery/ with

CREATE table orders (
  orderid INT primary key not NULL,
  orderdate Date,
  customerid INT NOT NULL,
  foodid INT NOT NULL,
  quantity INT,
  order_type TEXT,
  employeeid INT NOT NULL,
  
  foreign key (customerid) REFERENCES customers(customerid), 
  foreign key (foodid) REFERENCES foods(foodid),
  foreign key (employeeid) REFERENCES employees(employeeid)
);

INSERT into orders VALUES
	(1,'2022-01-05', 1, 4, 2, 'Eat-In', 1),
	(2,'2022-01-05', 1, 1, 1, 'Eat-In', 1),
  (3,'2022-01-06', 2, 5, 3, 'Delivery', 3),
  (4,'2022-01-07', 3, 1, 1, 'Eat-In', 2),
  (5,'2022-02-01', 4, 2, 1, 'Delivery', 2),
  (6,'2022-02-11', 5, 6, 1, 'To-Go', 1),
  (7,'2022-02-01', 1, 7, 1, 'Delivery', 4),
  (8,'2022-02-01', 6, 8, 5, 'Delivery', 3),
  (9,'2022-02-01', 7, 3, 2, 'Delivery', 3),
  (10,'2022-02-01', 3, 7, 3, 'Eat-In', 2);

--------------------------------

CREATE table transactions (
  paymentid INT primary key,
  paymentdate Date,
  customerid INT,
  orderid INT,
  amount REAL,
  paymentmethod TEXT
);
INSERT into transactions VALUES
	(1011,'2022-01-05', 1, 1,30.00, 'Cash'),
	(1012,'2022-01-05', 1, 2,23.00, 'Credit/Debit'),
  (1013,'2022-01-06', 2, 3, 33.00, 'PromptPay'),
  (1014,'2022-01-07', 3, 4, 23.00, 'PromptPay'),
  (1015,'2022-02-01', 4, 5, 17.00,'Cash'),
  
  (1016,'2022-01-05', 5, 6,12.30, 'Cash'),
	(1017,'2022-01-05', 1, 7,14.49, 'PromptPay'),
  (1018,'2022-01-06', 6, 8, 24.95, 'Cash'),
  (1019,'2022-01-07', 7, 9, 48.00, 'Cash'),
  (1020,'2022-02-01', 3, 10, 43.47,'Cash')
  ;
--------------------------------





CREATE table foods (
  foodid INT primary key,
  foodname TEXT,
  foodprice REAL
);
INSERT into foods VALUES
	(1,'Tom-Yum soup', 23),
	(2,'Pad-Thai', 17),
  (3,'Green Curry', 16),
  (4,'Orange Curry',15),
  (5,'Fish cakes',11),
  (6, 'Som-Tum-Thai', 12.30),
  (7,'Boat Noodle soup', 14.49),
  (8, 'Jasmin Rice',4.99);


--------------------------------
CREATE table customers (
  customerid INT primary key,
  customername TEXT,
  email TEXT,
  phonenumber INT,
  membership INT
);
INSERT into customers VALUES
	(1,'David Lee', 'd.lee@gmail.com', 2536781230, 11103487),
	(2,'Pattie Unk','unkki@gmail.com', 2098542353, 21945839),
  (3,'Katie Queens', 'queeusofunknown@hotmail.com', 2089541124, 20213539),
  (4,'Anne Seattle', 'anniepatth@gmail.com', 2538900911, 20983532),
  (5,'Robert Snow', NULL, NULL, NULL);
--------------------------------
CREATE table employees (
  employeeid INT primary key,
  employeename TEXT,
  employeerole TEXT
);
INSERT into employees VALUES
	(1,'Sarah Sui', 'Waitress'),
	(2,'Latte Yvok','Manager'),
  (3,'Jane Jefferson', 'Cashier'),
  (4,'Nick Nickorodia', 'Cashier'),
  (5,'Lydia Buzz', 'Chef');

select '                                    ';

-- sqlite command (SETTING)
.mode markdown
.header on 

SELECT * FROM orders;
select * from transactions;
select * from foods;
select * from customers;
select * from employees;

select '                            ';


-- # 3 Most Popular Dishes
select '3 Most Popular Dishes';
with sub as (
  select
        orderid,
        foodname,
        foodprice,
        quantity
  from orders as o
  join foods as f on o.foodid = f.foodid
)
  select
        foodname as name,
        sum(quantity) as qty,
        count(*) as "numbers of orders"
  from sub
  group by 1
  order by 2 DESC
  limit 3;
-- 


-- Popular payment method
select paymentmethod, count(*) from transactions
  group by paymentmethod;
--


-- Most Purchases
select 
    sub1.customername as name,
    count(*) as 'number of purchase'
  
from
  (select *
  from orders as od 
  join customers as cst 
    on od.customerid = cst.customerid 
) as sub1

group by 1
order by 2 desc
;
--
-- Revenue of each day
select paymentdate, sum(amount) as total_earning
from transactions
group by paymentdate ;
--