CREATE TABLE book (
book_id int,
title varchar(20),
publisher_name varchar(20),
pub_year varchar(10),
PRIMARY KEY (book_id)
);

CREATE TABLE book_authors (
book_id int,
author_name varchar(20),
FOREIGN KEY(book_id) REFERENCES book(book_id),
PRIMARY KEY(book_id, author_name)
);

CREATE TABLE publisher (
publisher_name varchar(20),
address varchar(20),
phone varchar(10),
PRIMARY KEY(publisher_name)
);

CREATE TABLE book_copies (
book_id int,
branch_id int,
no_of_copies int,
PRIMARY KEY (book_id, branch_id),
FOREIGN KEY(book_id) REFERENCES book(book_id),
FOREIGN KEY(branch_id) REFERENCES library_branch(branch_id)
);

CREATE TABLE book_lending (
book_id int,
branch_id int,
card_no int,
date_out date,
due_date date,
PRIMARY KEY(book_id, branch_id, card_no),
FOREIGN KEY(book_id) REFERENCES book(book_id),
FOREIGN KEY(branch_id) REFERENCES library_branch(branch_id)
);

CREATE TABLE library_branch (
branch_id int,
branch_name varchar(20),
address varchar(30),
PRIMARY KEY(branch_id)
);

INSERT INTO publisher VALUES ("mcgraw-hill", "bangalore", "9989076587");
INSERT INTO publisher VALUES ("pearson", "new delhi", "9889076565");
INSERT INTO publisher VALUES ("random house", "hyderabad", "7455679345");
INSERT INTO publisher VALUES ("hachette livre", "chennai", "8970862340");
INSERT INTO publisher VALUES ("grupo planeta", "bangalore", "7756120238");

INSERT INTO book VALUES (1, "DBMS", "mcgraw-hill", "JAN-2017");
INSERT INTO book VALUES (2, "ADBMS", "mcgraw-hill", "JUN-2016");
INSERT INTO book VALUES (3, "CN", "pearson", "SEP-2016");
INSERT INTO book VALUES (4, "CG", "grupo planeta", "SEP-2015");
INSERT INTO book VALUES (5, "OS", "pearson", "MAY-2016");

INSERT INTO book_authors VALUES(1, "NAVATHE");
INSERT INTO book_authors VALUES(2, "NAVATHE");
INSERT INTO book_authors VALUES(3, "TANENBAUM");
INSERT INTO book_authors VALUES(4, "EDWARD ANGEL");
INSERT INTO book_authors VALUES(5, "GALVIN");

INSERT INTO library_branch VALUES (10, "RR Nagar", "BANGALORE");
INSERT INTO library_branch VALUES (11, "RNSIT", "BANGALORE");
INSERT INTO library_branch VALUES (12, "Rajaji Nagar", "BANGALORE");
INSERT INTO library_branch VALUES (13, "NITTE", "MANGALORE");
INSERT INTO library_branch VALUES (14, "Manipal", "UDUPI");

INSERT INTO book_copies VALUES (1, 10, 10);
INSERT INTO book_copies VALUES (1, 11, 5);
INSERT INTO book_copies VALUES (2, 12, 2);
INSERT INTO book_copies VALUES (2, 13, 5);
INSERT INTO book_copies VALUES (3, 14, 7);
INSERT INTO book_copies VALUES (5, 10, 1);
INSERT INTO book_copies VALUES (4, 11, 3);

INSERT INTO book_lending VALUES (1, 10, 101, "17-01-01", "17-06-01");
INSERT INTO book_lending VALUES (3, 14, 101, "17-01-11", "17-03-11");
INSERT INTO book_lending VALUES (2, 13, 101, "17-02-21", "17-04-21");
INSERT INTO book_lending VALUES (4, 11, 101, "17-03-15", "17-07-15");
INSERT INTO book_lending VALUES (1, 11, 104, "17-04-12", "17-05-12");

-- QUERY 1
SELECT b.book_id, b.title, b.publisher_name, ba.author_name, bc.no_of_copies
FROM book b, book_authors ba, book_copies bc
WHERE b.book_id = bc.book_id
AND b.book_id = ba.book_id;

-- QUERY 2
SELECT bl.card_no
FROM book_lending bl
WHERE date_out BETWEEN "17-01-01" AND "17-06-01"
HAVING COUNT(bl.card_no) > 3;

-- QUERY 3
DELETE FROM book
WHERE book_id = 5;
SELECT * FROM book;

-- QUERY 4
CREATE VIEW VIEW_BY_YEAR_OF_PUB AS
SELECT pub_year
FROM book;
SELECT * FROM VIEW_BY_YEAR_OF_PUB;

-- QUERY 5
CREATE VIEW available_books AS
SELECT b.book_id, b.title, bc.no_of_copies
FROM book b, book_copies bc, library_branch l
WHERE b.book_id = bc.book_id
AND bc.branch_id = l.branch_id;
SELECT * FROM available_books;
