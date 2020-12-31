CREATE TABLE film(id INT, title VARCHAR(20), length INT);
INSERT INTO film VALUES
    (1, 'first',   20, 1, 'P'),
    (2, 'second',  40, 5, 'O'),
    (3, 'thrird',  60, 2, 'S'),
    (4, 'fourth',  40, 6, 'T'),
    (5, 'fifth',   40, 0, 'G'),
    (6, 'sixth',   40, 4, 'R'),
    (7, 'seventh', 40, 7, 'E'),
    (8, 'eighth',  40, 8, 'S');
SELECT * FROM film;

SELECT title,
       length,
       CASE
           WHEN length> 0
                AND length <= 50 THEN 'Short'
           WHEN length > 50
                AND length <= 120 THEN 'Medium'
           WHEN length> 120 THEN 'Long'
       END duration
FROM film
ORDER BY title;

SELECT
	SUM (CASE
               WHEN rental_rate = 0.99 THEN 1
	       ELSE 0
	      END
	) AS "Economy",
	SUM (
		CASE
		WHEN rental_rate = 2.99 THEN 1
		ELSE 0
		END
	) AS "Mass",
	SUM (
		CASE
		WHEN rental_rate = 4.99 THEN 1
		ELSE 0
		END
	) AS "Premium"
FROM
	film;

SELECT title,
       rating,
       CASE rating
           WHEN 'P' THEN 'General Audiences'
           WHEN 'O' THEN 'Parental Guidance Suggested'
           WHEN 'S-13' THEN 'Parents Strongly Cautioned'
           WHEN 'T' THEN 'Restricted'
           WHEN 'G-17' THEN 'Adults Only'
           WHEN 'R' THEN 'New and Old Audiences'
           WHEN 'E-11' THEN 'Pargetter Only'
           WHEN 'S' THEN 'Genevois'
       END rating_description
FROM film
ORDER BY title;

SELECT
    ROUND(AVG(length), 2) avg_length
FROM
    film
GROUP BY
    rating
ORDER BY
    avg_length DESC;

SELECT
    film_id,
    title,
    length
FROM
    film
WHERE
    length > ALL (
            SELECT
                ROUND(AVG (length),2)
            FROM
                film
            GROUP BY
                rating
    )
ORDER BY
    length;

SELECT
       SUM(CASE rating
             WHEN 'P' THEN 1
		     ELSE 0
		   END) "General Audiences",
       SUM(CASE rating
             WHEN 'O' THEN 1
		     ELSE 0
		   END) "Parental Guidance Suggested",
       SUM(CASE rating
             WHEN 'S-13' THEN 1
		     ELSE 0
		   END) "Parents Strongly Cautioned",
       SUM(CASE rating
             WHEN 'T' THEN 1
		     ELSE 0
		   END) "Restricted",
       SUM(CASE rating
             WHEN 'G-17' THEN 1
		     ELSE 0
		   END) "Adults Only"
       SUM(CASE rating
             WHEN 'R' THEN 1
		     ELSE 0
		   END) "New and Old Audiences",
       SUM(CASE rating
             WHEN 'E-11' THEN 1
		     ELSE 0
		   END) "Pargetter Only",
       SUM(CASE rating
             WHEN 'S-17' THEN 1
		     ELSE 0
		   END) "Genevois"
FROM film;

CREATE TABLE person(id INT, first_name VARCHAR(98), last_name VARCHAR(344));

SELECT
	concat_ws (
		', ',
		LOWER (last_name),
		LOWER (first_name)
	) as name
FROM
	customer
ORDER BY last_name;

SELECT
	CONCAT (
		UPPER (first_name),
		UPPER (last_name)
	) as full_name
FROM
	staff;

SELECT
	INITCAP(
		CONCAT (first_name, ' ', last_name)
	) AS full_name
FROM
	person
ORDER BY
	first_name;

SELECT name,
      CASE WHEN age < 30 THEN age * 10
           WHEN age = 23 THEN age * 90
           ELSE age
      END result
      FROM users;

SELECT title, amount, price, ROUND(
      CASE WHEN amount < 4 THEN price * 0.5
           WHEN amount < 11 THEN price * 0.7
           ELSE price * 0.9
      END) sale, CASE WHEN amount < 4 THEN 'discont is 50%'
                      WHEN amount < 11 THEN 'discont is 70%'
                      ELSE 'discont is 80%'
                 END your_discont
                 FROM book;

SELECT DISTINCT author FROM book ;
SELECT author FROM book GROUP BY author;

SELECT author,
       MIN(price) AS min_price,
       MAX(price) AS max_price
FROM book
     WHERE author <> 'new author'
     GROUP BY author
     HAVING (SUM(price * amount) > 5000 AND SUM(amount) > 10)
     ORDER BY min_price DESC;

SELECT * FROM book WHERE price = (SELECT MIN(price) FROM book);
SELECT * FROM book WHERE ABS(amount - (SELECT AVG(amount) FROM book)) > 3;
SELECT *,
        FLOOR((SELECT AVG(amount) FROM book)) AS floor_avg_amount FROM book WHERE ABS(amount - AVG(amount)) > 3;
SELECT * FROM book WHERE author IN (SELECT author FROM book GROUP BY author HAVING SUM(amount) >= 12);
SELECT * FROM book WHERE author = ANY(SELECT author FROM book GROUP BY author HAVING SUM(amount) >= 12);

INSERT INTO book(title, author, price, amount)
       SELECT title, author, price, amount FROM supply WHERE title NOT IN
              (SELECT title FROM book);
UPDATE book, supply SET book.amount = book.amount + supply.amount WHERE book.title = supply.title AND book.author = supply.author;
DELETE FROM supply WHERE title IN(SELECT title FROM book);

CREATE TABLE ordering AS SELECT title, author, 5 AS amount FROM book WHERE amount < 4;
SELECT * FROM ordering;
CREATE TABLE IF NOT EXISTS ordering AS SELECT title, author,
       (SELECT ROUND(AVG(amount)) FROM book) AS amount WHERE amount < 4;

SELECT f.name, f.number_plate, f.violation,
       CASE WHEN f.sum_fine = tv.sum_fine THEN 'standart fine'
            WHEN f.sum_fine < tv.sum_fine THEN 'less fine'
            ELSE 'fine is more than standart'
        END description
        FROM fine f, traffic_violation tv WHERE tv.violation = f.violation AND f.sum_fine IS NOT NULL;

UPDATE fine, (SELECT ...) query_in
       SET ...
       WHERE ...;

CREATE TABLE query_in ...;
UPDATE fine, query_in ...
       SET ...
       WHERE ...;

UPDATE table_name ...
       JOIN table2 ON ...
       ...
       SET ...
       WHERE ...;

CREATE TABLE author(id INT, author_name VARCHAR(255));
CREATE TABLE genre(id INT, genre_name VARCHAR(255));
ALTER TABLE author ADD PRIMARY KEY(id);
ALTER TABLE genre ADD PRIMARY KEY(id);
CREATE TABLE book(id INT PRIMARY KEY, title VARCHAR(255), genre_id INT REFERENCES genre, author_id INT REFERENCES author, price INT, amount INT);
SELECT title, author_name, genre_name FROM author
       INNER JOIN book ON author.id = book.author_id
       INNER JOIN genre ON genre.id = book.genre_id WHERE book.amount > 8;
SELECT author_name, title FROM author LEFT OUTER JOIN book ON book.author_id = author.id ORDER BY author_name;
SELECT author_name, genre_name FROM author CROSS JOIN genre;
SELECT author_name, genre_name FROM author, genre;
SELECT title, author_name, genre_name, price, amount FROM author
       INNER JOIN book ON book.author_id = author.id
       INNER JOIN genre ON genre.id = book.genre_id WHERE price BETWEEN 500 AND 700;
SELECT author_name, SUM(amount) AS general_amount FROM author
       INNER JOIN book ON author.id = book.author_id GROUP BY author_name HAVING SUM(amount) =
                       (SELECT MAX(general_amount) AS max_sum_amount FROM
                              (SELECT author_id, SUM(amount) AS sum_amount FROM book GROUP BY author_id) query_in);
SELECT title, author_name author.author_id FROM author
       INNER JOIN book ON author.author_id = book.author_id;
SELECT title, author_name, author_id FROM author
       INNER JOIN book USING(author_id);
UPDATE book SET genre_id = (SELECT genre_id
                            FROM genre
                            WHERE genre_name = 'new one')
            WHERE book_id = 9;                
