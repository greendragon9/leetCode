/*

CREATE TABLE Orders (
order_id number(2),
customer_id number(2),
product_id number(2),
order_date date,
quantity number(3)
)


INSERT INTO orders VALUES (1,1,10,DATE'2020-06-10',1);
INSERT INTO orders VALUES (2,1,20,DATE'2020-07-01',1);
INSERT INTO orders VALUES (3,1,30,DATE'2020-07-08',2);
INSERT INTO orders VALUES (4,2,10,DATE'2020-06-15',2);
INSERT INTO orders VALUES (5,2,40,DATE'2020-07-01',10);
INSERT INTO orders VALUES (6,3,20,DATE'2020-06-24',2);
INSERT INTO orders VALUES (7,3,30,DATE'2020-06-25',2);
INSERT INTO orders VALUES (9,3,30,DATE'2020-05-08',3);


CREATE TABLE CUSTOMERS (
customer_id number(2) CONSTRAINT customer_cust_id_pk PRIMARY KEY,
name varchar2(20),
country varchar2(20)
)

INSERT INTO Customers VALUES (1,'Wiston', 'USA');
INSERT INTO Customers VALUES (2,'Jonathan', 'Peru');
INSERT INTO Customers VALUES (3,'Moustafa', 'Egypt');


CREATE TABLE Product (
product_id number(2),
description varchar2(20),
price number(6)
)

INSERT INTO Product VALUES (10,'LC Phone',300);
INSERT INTO Product VALUES (20,'LC T-Shirt',10);
INSERT INTO Product VALUES (30,'LC Book',45);
INSERT INTO Product VALUES (40,'LC Keychain',2);

*/


SELECT C.customer_id as customer_id, CUST.name as name
FROM 
(SELECT customer_id, dense_rank() OVER (PARTITION BY CUSTOMER_ID ORDER BY MONTHLY_SUM DESC) AS RANKING
FROM 
(SELECT A.* from 
(SELECT customer_id, to_char(order_date,'Mon-yyyy')AS Month_purchase, sum(order_price) as Monthly_sum
FROM 
(SELECT customer_id, orders.product_id,order_date ,quantity*B.price as Order_price
FROM orders LEFT JOIN Product B
ON orders.product_id = B.product_id
) temp
GROUP BY customer_id, to_char(order_date,'Mon-yyyy')
order by customer_id, Monthly_sum desc
)A
WHERE (Monthly_sum >= 100 AND  Month_purchase like ('%Jun%') )
OR (Monthly_sum >= 100 AND MONTH_PURCHASE like ('%Jul%'))
)B
)C
LEFT JOIN Customers CUST
ON C.customer_id=CUST.customer_id
WHERE C.Ranking = 2