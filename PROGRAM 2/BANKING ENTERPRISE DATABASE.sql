--Query 1
CREATE TABLE BRANCH (BRANCH_NAME VARCHAR(30), BRANCH_CITY VARCHAR(30), ASSETS REAL, PRIMARY KEY (BRANCH_NAME));
CREATE TABLE BANK_ACCOUNT (ACCNO INT, BRANCH_NAME VARCHAR(30), BALANCE REAL, PRIMARY KEY (ACCNO), FOREIGN KEY (BRANCH_NAME) REFERENCES BRANCH(BRANCH_NAME));
CREATE TABLE BANK_CUSTOMER (CUSTOMER_NAME VARCHAR(30), CUSTOMER_STREET VARCHAR(30), CUSTOMER_CITY VARCHAR(30), PRIMARY KEY(CUSTOMER_NAME));
CREATE TABLE DEPOSITER (CUSTOMER_NAME VARCHAR(30), ACCNO INT, PRIMARY KEY(CUSTOMER_NAME, ACCNO), FOREIGN KEY (CUSTOMER_NAME) REFERENCES BANK_CUSTOMER(CUSTOMER_NAME), FOREIGN KEY (ACCNO) REFERENCES BANK_ACCOUNT(ACCNO));
CREATE TABLE LOAN (LOAN_NUMBER INT, BRANCH_NAME VARCHAR(30), AMOUNT REAL, PRIMARY KEY (LOAN_NUMBER), FOREIGN KEY (BRANCH_NAME) REFERENCES BRANCH(BRANCH_NAME));

--Query 2
INSERT INTO BRANCH VALUES ('SBI_CHAMRAJPET', 'BANGALORE', 50000);
INSERT INTO BRANCH VALUES ('SBI_RESIDENCYROAD', 'BANGALORE', 10000);
INSERT INTO BRANCH VALUES ('SBI_SHIVAJIROAD', 'BOMBAY', 20000);
INSERT INTO BRANCH VALUES ('SBI_PARLIAMENTROAD', 'DELHI', 10000);
INSERT INTO BRANCH VALUES ('SBI_JANTARMANTAR', 'DELHI', 20000);

INSERT INTO BANK_ACCOUNT VALUES ( 1,'SBI_CHAMRAJPET', 2000);
INSERT INTO BANK_ACCOUNT VALUES ( 2,'SBI_RESIDENCYROAD', 5000);
INSERT INTO BANK_ACCOUNT VALUES ( 3,'SBI_SHIVAJIROAD', 6000);
INSERT INTO BANK_ACCOUNT VALUES ( 4,'SBI_PARLIAMENTROAD', 9000);
INSERT INTO BANK_ACCOUNT VALUES ( 5,'SBI_JANTARMANTAR', 8000);
INSERT INTO BANK_ACCOUNT VALUES ( 6,'SBI_SHIVAJIROAD', 4000);
INSERT INTO BANK_ACCOUNT VALUES ( 8,'SBI_RESIDENCYROAD', 4000);
INSERT INTO BANK_ACCOUNT VALUES ( 9,'SBI_PARLIAMENTROAD', 3000);
INSERT INTO BANK_ACCOUNT VALUES ( 10,'SBI_RESIDENCYROAD', 5000);
INSERT INTO BANK_ACCOUNT VALUES ( 11,'SBI_JANTARMANTAR', 2000);

INSERT INTO BANK_CUSTOMER VALUES ('AVINASH', 'BULL_TEMPLE_ROAD', 'BANGALORE');
INSERT INTO BANK_CUSTOMER VALUES ('DINESH', 'BANNERGATTA_ROAD', 'BANGALORE');
INSERT INTO BANK_CUSTOMER VALUES ('MOHAN', 'NATIONALCOLLEGE_ROAD', 'BANGALORE');
INSERT INTO BANK_CUSTOMER VALUES ('NIKHIL', 'AKBAR_ROAD', 'DELHI');
INSERT INTO BANK_CUSTOMER VALUES ('RAVI', 'PRITHVIRAJ_ROAD', 'DELHI');

INSERT INTO DEPOSITER VALUES('AVINASH', 1);
INSERT INTO DEPOSITER VALUES('DINESH', 2);
INSERT INTO DEPOSITER VALUES('NIKHIL', 4);
INSERT INTO DEPOSITER VALUES('RAVI', 5);
INSERT INTO DEPOSITER VALUES('AVINASH', 8);
INSERT INTO DEPOSITER VALUES('NIKHIL', 9);
INSERT INTO DEPOSITER VALUES('DINESH', 10);
INSERT INTO DEPOSITER VALUES('NIKHIL', 11);

INSERT INTO LOAN VALUES (1, 'SBI_CHAMRAJPET', 1000);
INSERT INTO LOAN VALUES (2, 'SBI_RESIDENCYROAD', 2000);
INSERT INTO LOAN VALUES (3, 'SBI_SHIVAJIROAD', 3000);
INSERT INTO LOAN VALUES (4, 'SBI_PARLIAMENTROAD', 4000);
INSERT INTO LOAN VALUES (5, 'SBI_JANTARMANTAR', 5000);

-Query 3
SELECT CUSTOMER_NAME, COUNT(CUSTOMER_NAME)
FROM DEPOSITER D, BANK_ACCOUNT B
WHERE D.ACCNO = B.ACCNO
AND B.BRANCH_NAME = 'SBI_RESIDENCYROAD'
GROUP BY CUSTOMER_NAME
HAVING COUNT(CUSTOMER_NAME) >= 2;

--Query 4
SELECT D.CUSTOMER_NAME 
FROM DEPOSITER D,BRANCH B,BANK_ACCOUNT A 
WHERE B.BRANCH_NAME=A.BRANCH_NAME
AND A.ACCNO=D.ACCNO
AND BRANCH_CITY='DELHI'
GROUP BY D.CUSTOMER_NAME 
 HAVING COUNT(DISTINCT B.BRANCH_NAME)=(
                SELECT COUNT(BRANCH_NAME)
                FROM BRANCH
                WHERE BRANCH_CITY='DELHI');

--Query 5
DELETE FROM BANK_ACCOUNT
WHERE BRANCH_NAME IN (
	SELECT BRANCH_NAME
    FROM BRANCH
    WHERE BRANCH_CITY = 'BOMBAY'
);
SELECT * FROM BANK_ACCOUNT;
