CREATE TABLE student(
regno VARCHAR(20),
std_name VARCHAR(30),
major VARCHAR(20),
bdate DATE,
PRIMARY KEY (regno) 
);

CREATE TABLE course(
courseno INT,
cname VARCHAR(20),
dept VARCHAR(20),
PRIMARY KEY (courseno)
);
   
CREATE TABLE enroll(
regno VARCHAR(20),
courseno INT,
sem INT,
marks INT,
PRIMARY KEY (regno,courseno),
FOREIGN KEY (regno) REFERENCES student (regno),
FOREIGN KEY (courseno) REFERENCES course (courseno) 
);

CREATE TABLE text(
book_isbn INT,
book_title VARCHAR(30),
publisher VARCHAR(30),
author VARCHAR(30),
PRIMARY KEY (book_isbn) 
);

CREATE TABLE book_adoption(
courseno INT,
sem INT,
book_isbn INT,
PRIMARY KEY (courseno,book_isbn),
FOREIGN KEY (courseno) REFERENCES course (courseno),
FOREIGN KEY (book_isbn) REFERENCES text(book_isbn) 
);

INSERT INTO student VALUES('1PE11CS002','b','SR','19930924');
INSERT INTO student VALUES('1PE11CS003','c','SR','19931127');
INSERT INTO student VALUES('1PE11CS004','d','SR','19930413');
INSERT INTO student VALUES('1PE11CS005','e','JR','19940824');

INSERT INTO course VALUES(111,'OS','CSE');
INSERT INTO course VALUES(112,'EC','CSE');
INSERT INTO course VALUES(113,'SS','ISE');
INSERT INTO course VALUES(114,'DBMS','CSE');
INSERT INTO course VALUES(115,'SIGNALS','ECE');

INSERT INTO text VALUES(10,'DATABASE SYSTEMS','PEARSON','Schield');
INSERT INTO text VALUES(900,'OPERATING SYS','PEARSON','Leland');
INSERT INTO text VALUES(901,'CIRCUITS','HALL INDIA','Bob');
INSERT INTO text VALUES(902,'SYSTEM SOFTWARE','PETERSON','Jacob');
INSERT INTO text VALUES(903,'SCHEDULING','PEARSON','Patil');
INSERT INTO text VALUES(904,'DATABASE SYSTEMS','PEARSON','Jacob');
INSERT INTO text VALUES(905,'DATABASE MANAGER','PEARSON','Bob');
INSERT INTO text VALUES(906,'SIGNALS','HALL INDIA','Sumit');

INSERT INTO enroll VALUES('1PE11CS002',114,5,100);
INSERT INTO enroll VALUES('1PE11CS003',113,5,100);
INSERT INTO enroll VALUES('1PE11CS004',111,5,100);
INSERT INTO enroll VALUES('1PE11CS005',112,3,100);

INSERT INTO book_adoption VALUES(111,5,900);
INSERT INTO book_adoption VALUES(111,5,903);
INSERT INTO book_adoption VALUES(111,5,904);
INSERT INTO book_adoption VALUES(112,3,901);
INSERT INTO book_adoption VALUES(113,3,10);
INSERT INTO book_adoption VALUES(114,5,905);
INSERT INTO book_adoption VALUES(113,5,902);
INSERT INTO book_adoption VALUES(115,3,906);

-- QUERY 3
INSERT INTO text VALUES(907,'CRYPTOGRAPHY','HALL INDIA','Sumit');
INSERT INTO book_adoption VALUES(115,3,907);
SELECT * FROM text;
SELECT * FROM book_adoption;

-- QUERY 4
SELECT ba.courseno, t.book_isbn, t.book_title
FROM book_adoption ba, text t
WHERE ba.book_isbn = t.book_isbn
AND ba.courseno IN (
SELECT c.courseno
FROM course c
WHERE c.dept = 'CSE'
AND c.courseno IN(
SELECT ba1.courseno
FROM book_adoption ba1
GROUP BY ba1.courseno
HAVING COUNT(ba1.courseno) > 2
)
);

-- QUERY 5
SELECT DISTINCT c.dept 
FROM course c
WHERE c.dept IN (
SELECT c.dept
FROM course c,book_adoption b,text t
WHERE c.courseno=b.courseno
AND t.book_isbn=b.book_isbn
AND t.publisher='HALL INDIA'
)
AND c.dept NOT IN(
SELECT c.dept
FROM course c,book_adoption b,text t
WHERE c.courseno=b.courseno
AND t.book_isbn=b.book_isbn
AND t.publisher != 'HALL INDIA'
);

