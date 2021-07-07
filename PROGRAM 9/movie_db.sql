CREATE TABLE actor(
act_id INT, 
act_name VARCHAR(30), 
act_gender ENUM('M','F'), 
PRIMARY KEY(act_id));

CREATE TABLE director(
dir_id INT, 
dir_name VARCHAR(30), 
dir_phone VARCHAR(10), 
PRIMARY KEY(dir_id));

CREATE TABLE movies(
mov_id INT, 
mov_title VARCHAR(30), 
mov_year year, 
mov_lang VARCHAR(10), 
dir_id INT, 
PRIMARY KEY(mov_id), 
FOREIGN KEY(dir_id) REFERENCES director(dir_id) ON DELETE CASCADE);

CREATE TABLE moviecast(
act_id INT, 
mov_id INT, 
part VARCHAR(20), 
PRIMARY KEY(act_id, mov_id), 
FOREIGN KEY(act_id) REFERENCES actor(act_id) ON DELETE CASCADE, 
FOREIGN KEY(mov_id) REFERENCES movies(mov_id) ON DELETE CASCADE);

CREATE TABLE rating(
mov_id INT, 
rev_stars float, 
PRIMARY KEY(mov_id, rev_stars), 
FOREIGN KEY(mov_id) REFERENCES movies(mov_id) ON DELETE CASCADE);

INSERT INTO actor VALUES(100, "Leonardo DiCaprio", 'M');
INSERT INTO actor VALUES(101, "Tom Hanks", 'M');
INSERT INTO actor VALUES(102, "Tom Cruise", 'M');
INSERT INTO actor VALUES(103, "Margot Robbie", 'F');
INSERT INTO actor VALUES(104, "Jennifer Aniston", 'F');
INSERT INTO actor VALUES(105, "Gal Gadot", 'F');
SELECT * FROM actor;

INSERT INTO director VALUES(200, 'Steven Spielberg', '1649503470');
INSERT INTO director VALUES(201, 'Alfred Hitchcock', '7989467865');
INSERT INTO director VALUES(202, 'James Cameron', '5218281077');
INSERT INTO director VALUES(203, 'Kathryn Bigelow', '6157228013');
INSERT INTO director VALUES(204, 'Niki Caro', '8976600547');
INSERT INTO director VALUES(205, 'Sofia Coppola', '3949875040');
SELECT * FROM director;

INSERT INTO movies VALUES(300, 'Avatar', 2010, 'EN', 202);
INSERT INTO movies VALUES(301, 'Dial M For Murder', 1990, 'EN', 201);
INSERT INTO movies VALUES(302, 'Jurassic Park 1', 1999, 'EN', 200);
INSERT INTO movies VALUES(303, 'Jurassic Park 2', 2017, 'EN', 200);
INSERT INTO movies VALUES(304, 'Vertigo', 1986, 'EN', 201);
INSERT INTO movies VALUES(305, 'Zero Dark Thirty', 2012, 'EN', 200);
SELECT * FROM movies;

INSERT INTO moviecast VALUES(101, 300, 'actor');
INSERT INTO moviecast VALUES(105, 300, 'actress');
INSERT INTO moviecast VALUES(102, 301, 'actor');
INSERT INTO moviecast VALUES(103, 301, 'actress');
INSERT INTO moviecast VALUES(100, 302, 'actor');
INSERT INTO moviecast VALUES(104, 302, 'actress');
INSERT INTO moviecast VALUES(100, 303, 'actor');
INSERT INTO moviecast VALUES(104, 303, 'actress');
INSERT INTO moviecast VALUES(102, 304, 'actor');
INSERT INTO moviecast VALUES(105, 304, 'actress');
INSERT INTO moviecast VALUES(103, 305, 'actress');
SELECT * FROM moviecast;

INSERT INTO rating VALUES(300, 4.5);
INSERT INTO rating VALUES(301, 3);
INSERT INTO rating VALUES(302, 4);
INSERT INTO rating VALUES(303, 3.5);
INSERT INTO rating VALUES(304, 5);
INSERT INTO rating VALUES(305, 4);
SELECT * FROM rating;

-- QUERY 1
SELECT m.mov_title 
FROM movies m, director d 
WHERE m.dir_id=d.dir_id 
AND d.dir_name='Alfred Hitchcock';

-- QUERY 2
SELECT m.mov_title 
FROM movies m, moviecast mc 
WHERE m.mov_id=mc.mov_id
AND act_id IN (
SELECT act_id 
FROM moviecast 
GROUP BY act_id 
HAVING count(act_id) > 1) 
GROUP BY m.mov_title 
HAVING count(*) >= 2;

-- QUERY 3
SELECT a.act_name, m.mov_title, m.mov_year 
FROM actor a, movies m, moviecast mc 
WHERE a.act_id=mc.act_id 
AND mc.mov_id=m.mov_id 
AND m.mov_year NOT BETWEEN 2000 AND 2015;

-- QUERY 4
SELECT mov_title, MAX(rev_stars) 
FROM movies INNER JOIN rating USING (mov_id) 
GROUP BY mov_title 
HAVING MAX(rev_stars) > 0 
ORDER BY mov_title;

-- QUERY 5
UPDATE rating SET rev_stars = 5 
WHERE mov_id IN (
SELECT mov_id FROM movies 
WHERE dir_id IN (
SELECT dir_id FROM director 
WHERE dir_name='Steven Spielberg'));
SELECT * FROM rating;

