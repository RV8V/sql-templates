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

/*
Given the following table 'decimals':

** decimals table schema **

id
number1
number2
Return a table with two columns (root, log) where
the values in root are the square root of those
provided in number1 and the values in log are
changed to a base 10 logarithm from those in number2.
*/

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
the value in number2 should be rounded up.
*/

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
