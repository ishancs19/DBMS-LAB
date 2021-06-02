CREATE TABLE student (
	snum int,
    sname varchar(20),
    major varchar(20),
    lvl varchar(2),
    age int,
    primary key(snum)
);

CREATE TABLE class (
	cname varchar(20),
    meetsat timestamp,
    room varchar(10),
    fid int,
    primary key(cname),
    foreign key(fid) references faculty(fid)
);

CREATE TABLE enrolled (
	snum int, 
    cname varchar(20),
    primary key(snum, cname),
    foreign key (snum) references student(snum),
    foreign key (cname) references class(cname)
);

CREATE TABLE faculty (
	fid int,
    fname varchar(20),
    deptid int,
    primary key(fid)
);

INSERT INTO student VALUES (1, 'John', 'CS', 'Sr', 19);
INSERT INTO student VALUES (2, 'Smith', 'CS', 'Jr', 20);
INSERT INTO student VALUES (3, 'Jacob', 'CV', 'Sr', 20);
INSERT INTO student VALUES (4, 'Tom', 'CS', 'Jr', 20);
INSERT INTO student VALUES (5, 'Rahul', 'CS', 'Jr', 20);
INSERT INTO student VALUES (6, 'Rita', 'CS', 'Sr', 21);

INSERT INTO faculty VALUES(11, 'Harish', 1000);
INSERT INTO faculty VALUES(12, 'MV', 1000);
INSERT INTO faculty VALUES(13, 'Mira', 1001);
INSERT INTO faculty VALUES(14, 'Shiva', 1002);
INSERT INTO faculty VALUES(15, 'Nupur', 1000);

INSERT INTO class VALUES ('Class1', '12/11/15 10:15:16.00000', 'R1', 14);
INSERT INTO class VALUES ('Class10', '12/11/15 10:15:16.00000', 'R128', 14);
INSERT INTO class VALUES ('Class2', '12/11/15 10:15:20.000000', 'R2', 12);
INSERT INTO class VALUES ('Class3', '12/11/15 10:15:25.000000', 'R3', 11);
INSERT INTO class VALUES ('Class4', '12/11/15 20:15:20.000000', 'R4', 14);
INSERT INTO class VALUES ('Class5', '12/11/15 20:15:20.000000', 'R3', 15);
INSERT INTO class VALUES ('Class6', '12/11/15 13:20:20.000000', 'R2', 14);
INSERT INTO class VALUES ('Class7', '12/11/15 10:10:10.000000', 'R3', 14);

INSERT INTO enrolled VALUES (1, 'Class1');
INSERT INTO enrolled VALUES (2, 'Class1');
INSERT INTO enrolled VALUES (3, 'Class3');
INSERT INTO enrolled VALUES (4, 'Class3');
INSERT INTO enrolled VALUES (5, 'Class4');

SELECT * FROM student;
SELECT * FROM faculty;
SELECT * FROM class;
SELECT * FROM enrolled;

--QUERY 1
SELECT s.sname
FROM student s, enrolled e, class c, faculty f
WHERE s.lvl = 'Jr'
AND s.snum = e.snum
AND c.cname = e.cname
AND c.fid = f.fid
AND f.fname = 'Shiva';

--QUERY 2
SELECT c.cname 
FROM class c
WHERE c.room = 'R128'
OR c.cname 
IN (
SELECT e.cname 
FROM enrolled e
GROUP BY e.cname
HAVING COUNT(e.cname) >= 2
);

--QUERY 3
SELECT s.sname
FROM student s
WHERE s.snum IN (
SELECT e1.snum
FROM enrolled e1, enrolled e2, class c1, class c2
WHERE e1.snum = e2.snum
AND e1.cname <> e2.cname
AND e1.cname = c1.cname
AND c1.meetsat = c2.meetsat
);

--QUERY 4
SELECT DISTINCT f.fname
FROM faculty f, class c
WHERE f.fid
IN (
SELECT fid
FROM class c
GROUP BY fid
HAVING COUNT(*) = (
SELECT COUNT(DISTINCT room)
FROM class
)
);

--QUERY 5
SELECT f.fname
FROM faculty f
WHERE 5 > (
SELECT COUNT(e.snum)
FROM class c, enrolled e
WHERE c.cname = e.cname
AND c.fid = f.fid
);

--QUERY 6
SELECT sname
FROM student
WHERE snum NOT IN (
SELECT e.snum 
FROM enrolled e
);

--QUERY 7
SELECT s.age, s.lvl
FROM student s
GROUP BY s.age, s.lvl
HAVING s.lvl IN (
	SELECT s1.lvl FROM student s1
	WHERE s1.age = s.age
	GROUP BY s1.lvl, s1.age
	HAVING COUNT(*) >= ALL (
		SELECT COUNT(*)
		FROM Student s2
		WHERE s1.age = s2.age
		GROUP BY s2.lvl, s2.age
    )
);
