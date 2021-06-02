CREATE TABLE suppliers (
	sid INT, 
    sname VARCHAR(20),
    address VARCHAR(30),
    PRIMARY KEY (sid)
);
    
CREATE TABLE parts (
	pid INT,
    pname VARCHAR(20),
    color VARCHAR(20),
    PRIMARY KEY (pid)
);
    
CREATE TABLE catalog (
    sid INT,
    pid INT,
    cost REAL,
    PRIMARY KEY(sid, pid),
    FOREIGN KEY (sid) REFERENCES suppliers(sid),
    FOREIGN KEY (pid) REFERENCES parts(pid)
);
    
INSERT INTO suppliers VALUES (10001, 'Acme Widget', 'Bangalore');
INSERT INTO suppliers VALUES (10002, 'Johns', 'Kolkata');
INSERT INTO suppliers VALUES (10003, 'Vimal', 'Mumbai');
INSERT INTO suppliers VALUES (10004, 'Reliance', 'Delhi');
    
INSERT INTO parts VALUES (20001, 'Book', 'Red');
INSERT INTO parts VALUES (20002, 'Pen', 'Red');
INSERT INTO parts VALUES (20003, 'Pencil', 'Green');
INSERT INTO parts VALUES (20004, 'Mobile', 'Green');
INSERT INTO parts VALUES (20005, 'Charger', 'Black');
    
INSERT INTO catalog VALUES (10001, 20001, 10);
INSERT INTO catalog VALUES (10001, 20002, 10);
INSERT INTO catalog VALUES (10001, 20003, 30);
INSERT INTO catalog VALUES (10001, 20004, 10);
INSERT INTO catalog VALUES (10001, 20005, 10);
INSERT INTO catalog VALUES (10002, 20001, 10);
INSERT INTO catalog VALUES (10002, 20002, 20);
INSERT INTO catalog VALUES (10003, 20003, 30);
INSERT INTO catalog VALUES (10004, 20003, 40);

SELECT * FROM suppliers;
SELECT * FROM parts;
SELECT * FROM catalog;

--QUERY 1
SELECT DISTINCT(pname)
FROM parts p, catalog c
WHERE p.pid = c.pid 
AND c.sid IS NOT NULL;

--QUERY 2
SELECT s.sname
FROM suppliers s
WHERE NOT EXISTS (
	SELECT p.pid
    FROM parts p
    WHERE NOT EXISTS (
		SELECT c.sid
        FROM catalog c
        WHERE c.sid = s.sid
        AND c.pid = p.pid
	)
);

--QUERY 3
SELECT s.sname
FROM suppliers s
WHERE NOT EXISTS (
	SELECT p.pid
    FROM parts p
    WHERE p.color = 'Red'
    AND NOT EXISTS (
		SELECT c.sid
        FROM catalog c 
        WHERE c.sid = s.sid
        AND c.pid = p.pid
	)
);

--QUERY 4
SELECT p.pname
FROM parts p, suppliers s, catalog c
WHERE c.sid = s.sid
AND p.pid = c.pid
AND s.sname = 'Acme Widget'
AND NOT EXISTS (
SELECT c1.pid
FROM catalog c1, suppliers s1
WHERE c1.pid = p.pid
AND c1.sid = s1.sid
AND s1.sname <> 'Acme Widget'
);

--QUERY 5
SELECT DISTINCT sid
FROM catalog c
WHERE c.cost > (
	SELECT AVG(c1.cost)
	FROM catalog c1
    WHERE c1.pid = c.pid
);

--QUERY 6
SELECT p.pid, s.sname
FROM parts p, suppliers s, catalog c
WHERE c.pid = p.pid
AND c.sid = s.sid
AND c.cost = (
	SELECT MAX(c1.cost)
	FROM catalog c1
	WHERE c1.pid = p.pid
    );
