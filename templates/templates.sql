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
