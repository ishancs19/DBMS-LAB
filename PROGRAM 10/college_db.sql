CREATE TABLE student(
usn VARCHAR(30),
sname VARCHAR(30),
address VARCHAR(30),
phone REAL,
gender VARCHAR(30),
PRIMARY KEY(usn));
  
CREATE TABLE semsec(   
ssid VARCHAR(30), 
sem INT, 
sec VARCHAR(30),
PRIMARY KEY(ssid));
  
CREATE TABLE class(
usn VARCHAR(30),
ssid VARCHAR(30),
PRIMARY KEY(usn,ssid),
FOREIGN KEY(usn) REFERENCES student(usn),
FOREIGN KEY(ssid) REFERENCES semsec(ssid));
  
CREATE TABLE subject(
code VARCHAR(30),
title VARCHAR(30),
sem INT,
credits INT,
PRIMARY KEY(code)); 

CREATE TABLE marks(
usn VARCHAR(30),
code VARCHAR(30),
ssid varchar(30), 
test1 REAL, 
test2 REAL, 
test3 REAL, 
final REAL,
PRIMARY KEY(usn,code,ssid),
FOREIGN KEY(usn) REFERENCES student(usn),
FOREIGN KEY(code) REFERENCES subject(code),
FOREIGN KEY(ssid) REFERENCES semsec(ssid));

INSERT INTO student VALUES
('1RN13CS020','akshay','belagavi',8877881122,'m'),
('1RN13CS062','sandhya','bengaluru',7722829912,'f'),
('1RN13CS091','teesha','bengaluru',7712312312,'f'),
('1RN13CS066','supriya','mangaluru',8877881122,'f'),
('1RN14CS010','abhay','bengaluru',9900211201,'m'),
('1RN14CS032','bhaskar','bengaluru',9923211099,'m'),
('1RN14CS025','asmi','bengaluru',7894737377,'f'),
('1RN15CS011','ajay','tumkur',98545091341,'m'),
('1RN15CS029','chitra','davangere',7696772121,'f'),
('1RN15CS045','jeeva','bellary',9944850121,'m'),
('1RN15CS091','santosh','mangaluru',8812332201,'m'),
('1RN16CS045','ismail','kalburgi',9900232201,'m'),
('1RN16CS088','sameera','shimoga',9905542212,'f'),
('1RN16CS122','vinayaka','chikamagaluru',8800880011,'m');
SELECT * FROM student;

INSERT INTO semsec VALUES
('CSE8A',8,'A'),
('CSE8B',8,'B'),('CSE8C',8,'C'),
('CSE7A',7,'A'),('CSE7B',7,'B'),('CSE7C',7,'C'),
('CSE6A',6,'A'),('CSE6B',6,'B'),('CSE6C',6,'C'),
('CSE5A',5,'A'),('CSE5B',5,'B'),('CSE5C',5,'C'),
('CSE4A',4,'A'),('CSE4B',4,'B'),('CSE4C',4,'C'),
('CSE3A',3,'A'),('CSE3B',3,'B'),('CSE3C',3,'C'),
('CSE2A',2,'A'),('CSE2B',2,'B'),('CSE2C',2,'C'),
('CSE1A',1,'A'),('CSE1B',1,'B'),('CSE1C',1,'C');
SELECT * FROM semsec;

INSERT INTO class VALUES
('1RN13CS020','CSE8A'),
('1RN13CS062','CSE8A'),('1RN13CS066','CSE8B'),('1RN13CS091','CSE8C'),
('1RN14CS010','CSE7A'),('1RN14CS025','CSE7A'),('1RN14CS032','CSE7A'),
('1RN15CS011','CSE4A'),('1RN15CS029','CSE4A'),('1RN15CS045','CSE4B'),
('1RN15CS091','CSE4C'),('1RN16CS045','CSE3A'),('1RN16CS088','CSE3B'),
('1RN16CS122','CSE3C');
SELECT * FROM class;

INSERT INTO subject VALUES
('10CS81','ACA',8,4),
('10CS82','SSM',8,4),('10CS83','NM',8,4),
('10CS84','CC',8,4),('10CS85','PW',8,4),
('10CS71','OOAD',7,4),('10CS72','ECS',7,4),
('10CS73','PTW',7,4),('10CS74','DWDM',7,4),
('10CS75','JAVA',7,4),('10CS76','SAN',7,4),
('10CS51','ME',5,4),('10CS52','CN',5,4),
('10CS53','DBMS',5,4),('10CS54','ATC',5,4),
('10CS55','JAVA',5,3),('10CS56','AI',5,3),
('10CS41','M4',4,4),('10CS42','SE',4,4),
('10CS43','DAA',4,4),('10CS44','MPMC',4,4),
('10CS45','OOC',4,3),('10CS46','DC',4,3),
('10CS31','M3',3,4),('10CS32','ADE',3,4),
('10CS33','DSA',3,4),('10CS34','CO',3,4),
('10CS35','USP',3,3),('10CS36','DMS',3,3);
SELECT * FROM subject;

INSERT INTO marks(usn,code,ssid,test1,test2,test3) VALUES
('1RN13CS091','10CS81','CSE8C',15,16,18),
('1RN13CS091','10CS82','CSE8C',12,19,14),('1RN13CS091','10CS83','CSE8C',19,15,20),
('1RN13CS091','10CS84','CSE8C',20,16,19),('1RN13CS091','10CS85','CSE8C',15,15,12);
SELECT * FROM marks;

-- QUERY 1
SELECT S.*, SS.sem, SS.sec 
FROM student S, semsec SS, class C 
WHERE S.usn = C.usn 
AND SS.ssid = C.ssid 
AND SS.sem = 4 
AND SS.sec = 'C';

-- QUERY 2
SELECT SS.sem, SS.sec, S.gender, count(S.gender) AS COUNT
FROM student S, semsec SS, class C 
WHERE S.usn = C.usn AND SS.ssid = C.ssid 
GROUP BY SS.sem, SS.sec, S.gender 
ORDER BY sem;

-- QUERY 3
CREATE VIEW test1_marks AS 
SELECT test1, code
FROM marks 
WHERE usn = '1RN13CS091';
SELECT * FROM test1_marks;

-- QUERY 4
SELECT s.usn, sname, address, phone, gender,(CASE
WHEN m.final BETWEEN 17 AND 20 THEN 'outstanding'
WHEN m.final BETWEEN 12 AND 16 THEN 'average'
ELSE 'weak' END) AS CAT
FROM student S, marks m, subject sub
WHERE S.usn = m.usn 
AND sub.code = m.code 
AND sub.sem = 8;
