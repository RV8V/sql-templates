-- Return a table with one column (mod) which is the output of number1 modulus number2.
create table decimals(number1 int, number2 int);
insert into decimals values(14, 5), (23, 6);
select distinct mod(number1, number2) as mod from decimals;
select d.number1 % d.number2 m from decimals d;

--need to get a list of names and ages of users from the users table, who are 18 years old or older.
create table if not exists users(
    name character varying(127) not null,
    age integer not null check(age >= 18)
);
insert into users values('a', 23), ('b', 34);
select * from users;
select name, age from users where age between 18 and 99;
select name, age from users group by age, name having min(age) > 18;

/*
                  SQL
                  /\
                 //\\
                ///\\\
               ////\\\\
              /////\\\\\
             //////\\\\\\
            ///////\\\\\\\
           ////////\\\\\\\\
          /////////\\\\\\\\\
         //////////\\\\\\\\\\
        ///////////\\\\\\\\\\\
      /////////////\\\\\\\\\\\\\
     //////////////\\\\\\\\\\\\\\
    ///////////////\\\\\\\\\\\\\\\
  /////////////////\\\\\\\\\\\\\\\\\
 //////////////////\\\\\\\\\\\\\\\\\\

*/

-- order employees by descendent
create table companies(id int, age int, employees int);
insert into companies values
    (1, 2, 2), (2, 3, 2), (3, 1, 1);
select id, age, employees from companies order by 1 desc;
select id, age, sum(employees)::float as sum from companies group by 1, 2 order by sum desc;
select cast(42 as float8);
select id, age, cast(employees as float) as result from companies order by result desc;

-- square root and log

/* Given the following table 'decimals':

** decimals table schema **

id
number1
number2
Return a table with two columns (root, log) where
the values in root are the square root of those
provided in number1 and the values in log are
changed to a base 10 logarithm from those in number2.*/

create table root_log(n1 int, n2 int);
insert into root_log values(4, 4), (9, 9);
select sqrt(n1) as root, log(n2) as log from root_log;
select |/ n1 as root, log(n2) as log from root_log;
select n1 ^ .5 as root, log(n2) as log from root_log;
select power(number1, 0.5) as root, (log(number2::float))::int as log from decimals;
select SQRT(n1) as root, log(cast(n2 as double precision)) as log from root_log;
select SQRT(n1) as root, log(n2::double precision) as log from root_log;

-- round up and down

/*  SQL
Given the following table 'decimals':

** decimals table schema **

id
number1
number2

--FLOOR(): DOWN
--CEIL(): UP

Return a table with two columns (number1, number2),
the value in number1 should be rounded down and
the value in number2 should be rounded up.*/

SELECT FLOOR(number1) AS number1, CEIL(number2) AS number2 from decimals;
UPDATE decimals SET number1 = FLOOR(number1), number2 = CEIL(number2);
SELECT number1, number2 FROM decimals;
SELECT
    CAST(CAST(FLOOR(number1) as integer) as float) as number1,
    CAST(CAST(FLOOR(number1) as integer) as float) as number1
FROM decimals;
SELECT
    FLOOR(number1)::integer::float as number1,
    FLOOR(number1)::integer::float as number2
FROM decimals;

-- Easy SQL: Convert to Hexadecimal

-- CREATE FUNCTION num_to_hex(
-- input_num int)
-- RETURNS varchar(5) as
-- Begin
--   CASE
--     WHEN input_num = 10 then 'A'
--     WHEN input_num = 11 then 'B'
--     WHEN input_num = 12 then 'C'
--     WHEN input_num = 13 then 'D'
--     WHEN input_num = 14 then 'E'
--     WHEN input_num = 15 then 'F'
--     else cast( input_num as varchar(5))
--   END
--   Return
-- END

SELECT to_hex(legs) legs, to_hex(arms) arms FROM monsters;
SELECT
    CAST(TO_HEX(CAST(legs as bigint)) as VARCHAR(20)) as legs,
    CAST(TO_HEX(CAST(arms as bigint)) as VARCHAR(20)) as arms,
FROM monsters;
SELECT
    TO_HEX(legs::bigint)::VARCHAR(20) legs,
    TO_HEX(arms::bigint)::VARCHAR(20) arms,
FROM monsters;

-- lower case

/*Given a demographics table in the following format:

** demographics table schema **

id
name
birthday
race
you need to return the same table where all letters are lowercase in the race column.*/

/* CREATE TABLE peopleTableSchema
(
  id int PRIMARY KEY IDENTITY(1, 1),
  name nvarchar(100),
  birthday date,
  race nvarchar(50)
)

INSERT INTO peopleTableSchema VALUES
(
  ('Ivan', '20010101', 'a'),
  ('Igor', '20010202', 'b')
)*/

SELECT *, LOWER(race) AS race FROM demographics;
UPDATE demographics SET race = LOWER(race);
SELECT * FROM demographics;
SELECT id,
       name,
       birthday birthday,
       LOWER(race) race
       FROM demographics;

-- Collect Tuition (SQL for Beginners #4)
SELECT * FROM students WHERE NOT tuition_received;
SELECT * FROM students WHERE tuition_received = false;
SELECT * FROM students WHERE NOT tuition_received = true;
SELECT * FROM students WHERE tuition_received <> true OR tuition_received IS NULL;
SELECT * FROM students WHERE tuition_received != true;
SELECT * FROM students WHERE tuition_received IS false;
SELECT * FROM students WHERE tuition_received IS NOT true;
SELECT * FROM students WHERE tuition_received IN(false, f);
SELECT * FROM students WHERE tuition_received NOT IN(true, t);

-- Register for the Party (SQL for Beginners #3)
SELECT name, age, CASE WHEN age > 17 THEN 1 = 1 ELSE 1 = 0 END atte FROM party;

-- On the Canadian Border (SQL for Beginners #2)
SELECT * FROM travelers WHERE NOT country IN('USA', 'Canada');
SELECT * FROM travelers WHERE country NOT IN('USA', 'Canada');
--  NOT IN = <> ALL.
SELECT country FROM travelers WHERE country <> ALL(ARRAY['Canada', 'USA']);
-- ~A = A ^ ~0  (XOR by 1's inverts all the bits)
SELECT * FROM travelers WHERE country !~ 'Canada|Mexico|USA';
SELECT * FROM travelers
         EXCEPT SELECT * FROM travelers WHERE country = 'USA'
         EXCEPT SELECT * FROM travelers WHERE country = 'Mexico'
         EXCEPT SELECT * FROM travelers WHERE country = 'Canada';
SELECT * FROM travelers WHERE NOT country SIMILAR TO 'USA|Canada|Mexico';
SELECT * FROM travelers WHERE country NOT SIMILAR TO 'USA|Canada|Mexico';
SELECT * FROM travelers WHERE country NOT LIKE all(array['%Canada%', '%USA%']);
SELECT * FROM travelers WHERE NOT (country = ANY(ARRAY['Canada', 'Mexico', 'USA']));

-- distinct

/* displaying a column of the age columns's values from the people table and using
DISTINCT to get the unique values from within that column */

SELECT DISTINCT(age) AS age FROM people;
SELECT DISTINCT age age FROM people;

-- min and max

/* Descripcion: For this challenge you need to create a simple MIN / MAX
             statement that will return the Minimum and Maximum ages
             out of all the people.*/

/* using a MIN() function here for a column called age_min with the smallest age
from the people table and a MAX() function here for a column called age_max with
the largest age from the people table  */

SELECT
      (SELECT min(age) FROM people) AS age_min,
      (SELECT max(age) FROM people) AS age_max;
SELECT table1.age_min, table2.age_max FROM
      (SELECT age AS age_min FROM people ORDER BY age ASC LIMIT 1) AS table1,
      (SELECT age AS age_max FROM people ORDER BY age DESC LIMIT 1) AS table2;
SELECT age AS min_age, (SELECT age FROM users ORDER BY age DESC LIMIT 1) AS max_age FROM users ORDER BY age LIMIT 1;
-- SELECT age from people WHERE age IN (MIN(age), MAX(age)) -- Not allowed
SELECT
      (SELECT age FROM people GROUP BY age ORDER BY age OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY) AS age_min,
      (SELECT age FROM people ORDER BY age DESC FETCH NEXT 1 ROWS ONLY) AS age_max;
SELECT age_max, age_min FROM (SELECT MAX(age) AS age_max, MIN(age) AS age_min FROM people) alias_here;

-- sum
SELECT (SELECT SUM(age) age_sum FROM users);
SELECT t.age_sum FROM (SELECT SUM(age) AS age_sum FROM users) AS t;
CREATE TABLE age_result(age_sum SMALLINT);
INSERT INTO age_result(age_sum) SELECT SUM(age) FROM people;
SELECT age_sum FROM age_result;
