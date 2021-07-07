CREATE TABLE salesman ( 
	salesman_id INT,
    name VARCHAR(20),
    city VARCHAR(20),
    commission VARCHAR(8),
    PRIMARY KEY (salesman_id)
    );
    
CREATE TABLE customer (
	customer_id INT,
    cust_name VARCHAR(20),
    city VARCHAR(20),
    grade INT,
    salesman_id INT,
    PRIMARY KEY(customer_id),
    FOREIGN KEY(salesman_id) REFERENCES salesman(salesman_id)
    );
    
CREATE TABLE orders(
	ord_no INT,
    purchase_amt INT,
    ord_date DATE,
    customer_id INT,
    salesman_id INT,
    PRIMARY KEY(ord_no),
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY(salesman_id) REFERENCES salesman(salesman_id) ON DELETE CASCADE
    );
    
INSERT INTO salesman VALUES (1000, 'John', 'Bangalore', '25%');
INSERT INTO salesman VALUES (2000, 'Ravi', 'Bangalore', '20%');
INSERT INTO salesman VALUES (3000, 'Kumar', 'Mysore', '15%');
INSERT INTO salesman VALUES (4000, 'Smith', 'Delhi', '30%');
INSERT INTO salesman VALUES (5000, 'Harsha', 'Hyderabad', '15%');

INSERT INTO customer VALUES(10, 'Preethi', 'Bangalore', 100, 1000);
INSERT INTO customer VALUES(11, 'Vivek', 'Mangalore', 300, 1000);
INSERT INTO customer VALUES(12, 'Bhaskar', 'Chennai', 400, 2000);
INSERT INTO customer VALUES(13, 'Chetan', 'Bangalore', 200, 2000);
INSERT INTO customer VALUES(14, 'Mamatha', 'Bangalore', 400, 3000);

INSERT INTO orders VALUES (50, 5000, '2017-05-04', 10, 1000);
INSERT INTO orders VALUES (51, 450, '2017-01-20', 10, 2000);
INSERT INTO orders VALUES (52, 1000, '2017-02-24', 13, 2000);
INSERT INTO orders VALUES (53, 3500, '2017-04-13', 14, 3000);
INSERT INTO orders VALUES (54, 550, '2017-03-09', 12, 2000);

SELECT * FROM salesman;
SELECT * FROM customer;
SELECT * FROM orders;

-- QUERY 1
SELECT COUNT(c.customer_id)
FROM customer c
WHERE c.grade > (
SELECT AVG(c1.grade)
FROM customer c1
WHERE c1.city = 'Bangalore'
);

-- QUERY 2
SELECT DISTINCT s.salesman_id, s.name
FROM salesman s
WHERE 1 < (
SELECT COUNT(*)
FROM customer c
WHERE c.salesman_id = s.salesman_id
GROUP BY c.salesman_id
);

-- QUERY 3
SELECT s.name, s.salesman_id, 'EXISTS' AS customer_exists_or_not
FROM salesman s, customer c
WHERE s.city = c.city
UNION
SELECT s.name, s.salesman_id, 'DOES NOT EXIST' AS customer_exists_or_not
FROM salesman s, customer c
WHERE s.city NOT IN (
SELECT c1.city
FROM salesman s1, customer c1
WHERE s1.city = c1.city
);

-- QUERY 4
CREATE VIEW salesman_of_the_day AS
SELECT s.salesman_id, s.name, o.purchase_amt
FROM salesman s, orders o, customer c
WHERE s.salesman_id = o.salesman_id
AND c.customer_id = o.customer_id
HAVING o.purchase_amt = MAX(o.purchase_amt);

SELECT * FROM salesman_of_the_day;

-- QUERY 5
DELETE FROM orders
WHERE salesman_id = 1000;
