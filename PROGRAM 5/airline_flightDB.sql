CREATE TABLE flights(
	flno INT, 
    fl_from VARCHAR(20), 
    fl_to VARCHAR(20),
    distance INT,
    departs DATETIME,
    arrives DATETIME,
    price INT,
    PRIMARY KEY(flno)
);

CREATE TABLE aircraft (
	aid INT,
    aname VARCHAR(20),
    cruising_range INT,
    PRIMARY KEY(aid)
);

CREATE TABLE certified (
	eid INT,
    aid INT,
    PRIMARY KEY(eid, aid),
    FOREIGN KEY (eid) REFERENCES employees(eid),
    FOREIGN KEY(aid) REFERENCES aircraft(aid)
);

CREATE TABLE employees (
	eid INT,
    ename VARCHAR(20),
    salary INT,
    PRIMARY KEY(eid)
);

INSERT INTO flights VALUES (101, 'Bangalore', 'Delhi', 2500, '13-05-05 07.15.31.000000', '13-05-05 07.15.31.000000', 5000);
INSERT INTO flights VALUES (102, 'Bangalore', 'Lucknow', 3000, '05/05/13 07:15:31', '05/05/13 11:15:31', 6000);
INSERT INTO flights VALUES (103, 'Lucknow', 'Delhi', 500, '5/05/13 12:15:31', '05/05/13 17:15:31', 3000);
INSERT INTO flights VALUES (107, 'Bangalore', 'Frankfurt', 8000, '05/05/13 07:15:31', '05/05/13 22:15:31', 60000);
INSERT INTO flights VALUES (104, 'Bangalore', 'Frankfurt', 8500, '05/05/13 07:15:31', '05/05/13 23:15:31', 75000);
INSERT INTO flights VALUES (105, 'Kolkata', 'Delhi', 3400, '05/05/13 07:15:31', ' 05/05/13 09:15:31', 7000);

INSERT INTO aircraft VALUES (101, '747', 3000);
INSERT INTO aircraft VALUES (102, 'Boeing', 900);
INSERT INTO aircraft VALUES (103, '647', 800);
INSERT INTO aircraft VALUES (104, 'Dreamliner', 10000);
INSERT INTO aircraft VALUES (105, 'Boeing', 3500);
INSERT INTO aircraft VALUES (106, '707', 1500);
INSERT INTO aircraft VALUES (107, 'Dream', 12000);

INSERT INTO certified VALUES (701, 101);
INSERT INTO certified VALUES (701, 102);
INSERT INTO certified VALUES (701, 106);
INSERT INTO certified VALUES (701, 105);
INSERT INTO certified VALUES (702, 104);
INSERT INTO certified VALUES (703, 104);
INSERT INTO certified VALUES (704, 104);
INSERT INTO certified VALUES (702, 107);
INSERT INTO certified VALUES (703, 107);
INSERT INTO certified VALUES (704, 107);
INSERT INTO certified VALUES (702, 101);
INSERT INTO certified VALUES (702, 105);
INSERT INTO certified VALUES (704, 105);
INSERT INTO certified VALUES (705, 103);

INSERT INTO employees VALUES (701, 'A', 50000);
INSERT INTO employees VALUES (702, 'B', 100000);
INSERT INTO employees VALUES (703, 'C', 150000);
INSERT INTO employees VALUES (704, 'D', 90000);
INSERT INTO employees VALUES (705, 'E', 40000);
INSERT INTO employees VALUES (706, 'F', 60000);
INSERT INTO employees VALUES (707, 'G', 90000);

--QUERY 1
SELECT DISTINCT a.aname 
FROM aircraft a, certified c, employees e 
WHERE a.aid = c.aid 
AND c.eid = e.eid 
AND e.salary>80000;

--QUERY 2
SELECT c.eid, MAX(a.cruising_range)
FROM aircraft a, certified c, employees e
WHERE e.eid = c.eid
AND a.aid = c.aid
GROUP BY c.eid
HAVING COUNT(*) > 3;

--QUERY 3
SELECT e.ename
FROM employees e
WHERE e.salary < (
	SELECT MIN(f.price)
    FROM flights f
    WHERE f.fl_from = 'Bangalore'
    AND f.fl_to = 'Frankfurt'
);

--QUERY 4
SELECT a.aname, AVG(e.salary)
FROM aircraft a, certified c, employees e
WHERE a.cruising_range > 1000
AND a.aid = c.aid
AND e.eid = c.eid
GROUP BY a.aname;

--QUERY 5
SELECT DISTINCT e.ename
FROM employees e, aircraft a, certified c 
WHERE e.eid = c.eid
AND a.aid = c.aid
AND a.aname = 'Boeing';

--QUERY 6
SELECT a.aid
FROM aircraft a, flights f
WHERE a.cruising_range >= f.distance
AND f.fl_from = 'Bangalore'
AND f.fl_to = 'Delhi';
