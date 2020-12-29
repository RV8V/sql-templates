
---------------VIDEO #1---------------
Команды:
Обнавление индекса пакетов:
sudo apt-get update

Установка пакетов postgresql, contrib:
sudo apt-get install postgresql postgresql-contrib

Проверка установленной версии:
psql --version

Осуществим вход консоль с помощью учетной записи postgres:
sudo -i -u postgres
psql

Вход от имени учетной записи postgres:
sudo -u postgres psql
---------------VIDEO #1---------------


---------------VIDEO #2---------------
Создание удаление таблицы:
CREATE TABLE table_name(attribute_name type);
DROP TABLE table_name;

Установка значений(добавление данных) в таблицу:
INSERT INTO table_name(attribute_name1, attribute_name2)
VALUES (values1, values2);

Возвращает все данные таблицы:
SELECT*FROM table_name

Доп. команды:
\d - посмотреть все таблицы
\d table_name - посмотреть характеристики таблицы

Type of Data (ТИПЫ ДАННЫХ):
text (text от англ. текст)-большое количество текстовой информации
Числовой тип:
int (от англ integer- целое число)- это целое число, может быть знаковым или без знаковым.

Строковый тип:
char(m) (от англ. character - характек) - это текстовое поле постоянной длины. При сохранении сервер отсекает конечные пробелы, а при чтении дополняет строку до указанной длины пробелами справа, где m-количество символов.
varchar(m) ( от англ. character varing  характер изменения)- это строка символов с варьирующейся длинной, где m-количество символов.
text (text от англ. текст)-большое количество текстовой информации


mydb=# CREATE TABLE table_name(attribute_name type);

mydb=# create table users(login char(10), email varchar(10), age int);

mydb=# INSERT INTO users(login, email, age)
mydb-# VALUES('HITRUK', 'tf@mail.ru', 27),
mydb-# ('li', 'li@knr.com', 15),
mydb-# ('vasy', 'vasya@mail.ru', 35),
mydb-# ('lili', 'lili@rt.ru', 13);

mydb=# SELECT*FROM table_name
mydb=# SELECT attribute_name FROM table_name
mydb=# SELECT age, email  FROM users;

char vs varchar
---------------VIDEO #2---------------


---------------VIDEO #3---------------
attribute_name=column_name

Переименовать таблицу:
ALTER TABLE table_name RENAME TO new_table_name

Удаление, добавление колонок:
ALTER TABLE table_name ADD attribute_name type;
ALTER TABLE table_name DROP COLUMN attribute_name;

Переименовать имя колонки:
ALTER TABLE table_name RENAME COLUMN attribute_name
TO new_attribute_name;

Изменение типа данных:
ALTER TABLE table_name ALTER COLUMN column_name
TYPE date_of_type;

mydb=# alter table users rename to people;
mydb=# alter table people add comment text;
mydb=# alter table people drop column comment;
mydb=# alter table people rename column age to old;
mydb=# alter table people rename to users;
mydb=# alter table users rename column old to age;

mydb=# alter table users alter column login type varchar(15);
mydb=# select * from users where age < 20;
mydb=# select * from users where login = 'bye';
---------------VIDEO #3---------------


---------------VIDEO #4---------------
Тип данных(data type):

Числовой тип данных:
decimal(англ. десятичный) и numeric(числовой) являются идентичными по своим возможностям.

numeric(precision, scale)  (от англ. числовой) -позволяет хранить числа с очень большим количеством цифр, рекомен-
дуется для хранения денежных сумм и других величин, где важна точность.

Пример:
23.5141 имеет точность 6 и масштаб 4.

Примечание:
Точность должна быть положительной, а масштаб положительным или равным нулю.

Если масштаб значения, которое нужно сохранить, превышает объявленный масштаб столбца, си-
стема округлит его до заданного количества цифр после точки.

Помимо обычных чисел тип numeric позволяет сохранить специальное значение NaN, что означает
«not-a-number» (не число). Любая операция c NaN выдаёт в результате тоже NaN. Записывая это зна-
чение в виде константы в команде SQL, его нужно заключать в апострофы, например так: UPDATE
table SET x = 'NaN'. Регистр символов в строке NaN не важен.


Работа со строками таблицы:

Вставить, удалить значение в таблице:
INSERT INTO table_name(attribute_name1, attribute_name2,...)
VALUES(values1, values2,...);

DELETE FROM table_name
WHERE condition(условие);

Удалить все строки в таблице:
DELETE FROM table_name;


Изменить значение,
переименовать значения во ВСЕХ строках в таблицы:
UPDATE имя_таблицы
SET attribute_name1 = values1,
attribute_name2 = values2, ...

Изменить значение,
переименовать значения в ОДНОЙ строке таблицы:
UPDATE table_name SET attribute_name(где хотим именить значение)
WHERE attribute_name;

mydb=# alter table users rename to people;
mydb=# alter table people drop column login;
mydb=# alter table people drop column email;
mydb=# alter table people drop column age;
mydb=# \d people

mydb=# alter table people add column firstname varchar(100);
mydb=# alter table people add column lastname varchar(100);
mydb=# alter table people add column age int;
mydb=# alter table people add column comment text;
mydb=# alter table people add column weigth numeric(4, 1);
mydb=# \d people

mydb=# insert into people(firstname, lastname, age, comment, weigth)
values('sergey', 'bubko', 23, 'text', 80.8),
('andrey', 'li', 24, 'some text', 64.8),
('sergey', 'bubko', 23, 'text', 80.8),
('grey', 'li', 24, 'some text', 40);

mydb=# select sum (weigth) from people;
mydb=# delete from people where firstname = 'grey';

mydb=# create table two(name varchar(100), email varchar(100), age int, comment text, weigth numeric(4, 2));
mydb=# insert into two
mydb-# values('urly', 'you@mail.ru', 23, 'text', 68.788),
mydb-# ('bob', 'google@mail.com', 45, 'some text', 80.7766);
INSERT 0 2

mydb=# select * from two;
 name |      email      | age |  comment  | weigth
------+-----------------+-----+-----------+--------
 urly | you@mail.ru     |  23 | text      |  68.79
 bob  | google@mail.com |  45 | some text |  80.78
(2 rows)

mydb=# delete from two;
DELETE 2
mydb=# select * from two;
 name | email | age | comment | weigth
------+-------+-----+---------+--------
(0 rows)

mydb=# insert into two
values('urly', 'you@mail.ru', 23, 'text', 68.788),
('bob', 'google@mail.com', 45, 'some text', 80.7766);
INSERT 0 2

mydb=# update two set age = 23;
UPDATE 2
mydb=# select * from two;
 name |      email      | age |  comment  | weigth
------+-----------------+-----+-----------+--------
 urly | you@mail.ru     |  23 | text      |  68.79
 bob  | google@mail.com |  23 | some text |  80.78
(2 rows)

mydb=# update two set age = 30 where name = 'bob';
UPDATE 1
mydb=# select * from two;
 name |      email      | age |  comment  | weigth
------+-----------------+-----+-----------+--------
 urly | you@mail.ru     |  23 | text      |  68.79
 bob  | google@mail.com |  30 | some text |  80.78
(2 rows)
---------------VIDEO #4---------------

---------------VIDEO #5---------------
Тип данных SERIAL:
CREATE TABLE table_name (attribute_name serial);

SERIAL (англ. последовательный) - как и другие последовательные типы данных не являются настоящими типами, а представляют
собой просто удобное средство для создания столбцов с уникальными идентификаторами

Значение по умолчанию:
NULL - Это специальные значения, означающие «ничто» или отсутствие значения. Не совпадают со значением «нуль» или «пустая строка».
NULL-значение применяется в базах данных в качестве значения по умолчанию,

DEFAULT (англ. по умолчанию применительно к values)-команда явного присвоения значения.

CREATE TABLE table_name(attribute_name type DEFAULT values);

mydb=# create table doo(id serial, name varchar(100));
CREATE TABLE
mydb=# \d doo

mydb=# insert into doo(name)
values('bob'), ('john'), ('kenny');
INSERT 0 3
mydb=# select * from doo;
 id | name
----+-------
  1 | bob
  2 | john
  3 | kenny
(3 rows)

mydb=# insert into doo(name)
values('bob');
INSERT 0 1
mydb=# select * from doo;
 id | name
----+-------
  1 | bob
  2 | john
  3 | kenny
  4 | bob
(4 rows)

mydb=# delete from doo where id = 4;
DELETE 1
mydb=# select * from doo;
 id | name
----+-------
  1 | bob
  2 | john
  3 | kenny
(3 rows)

mydb=# \d doo_id_seq;
                     Sequence "public.doo_id_seq"
  Type   | Start | Minimum |  Maximum   | Increment | Cycles? | Cache
---------+-------+---------+------------+-----------+---------+-------
 integer |     1 |       1 | 2147483647 |         1 | no      |     1
Owned by: public.doo.id

mydb=# create table foo(id serial, name varchar(100), age int default 18);
CREATE TABLE
mydb=# insert into foo(name) values('gog'), ('maria'), ('gena');
INSERT 0 3
mydb=# select * from foo;
 id | name  | age
----+-------+-----
  1 | gog   |  18
  2 | maria |  18
  3 | gena  |  18
(3 rows)

mydb=# \d foo;
Table "public.foo"
Column |          Type          | Collation | Nullable |             Default
--------+------------------------+-----------+----------+---------------------------------
id     | integer                |           | not null | nextval('foo_id_seq'::regclass)
name   | character varying(100) |           |          |
age    | integer                |           |          | 18

(END)

mydb=# insert into foo(name, age) values('gog', 50), ('maria', 38), ('gena', 41);
INSERT 0 3
mydb=# select * from foo;
 id | name  | age
----+-------+-----
  1 | gog   |  18
  2 | maria |  18
  3 | gena  |  18
  4 | gog   |  50
  5 | maria |  38
  6 | gena  |  41
(6 rows)
---------------VIDEO #5---------------


---------------VIDEO #6---------------
Ограничения

CHECK (проверять). Проверяет вносимые значения на условие.

Создание ограничений на уровне столбца:
CREATE TABLE table_name(attribute_name type CHECK(условие));

Создание ограничений на уровне таблицы:
CREATE TABLE table_name(
 attribute_name1 type,
 attribute_name2 type,
 attribute_name3 type,
 CHECK(условие)
);


Оператор CONSTRAINT(англ. Ограничение).- устанавливает имя ограничений

CREATE TABLE table_name(
 attribute_name1 type,
 CONSTRAINT имя_ограничения CHECK(attribute_name1);
);


Ограничения уникальности.
UNIQUE (англ. уникальный) - данные(Значения) в определённом столбце или группе столбцов уникальны среди всех строк таблицы:

Ограничение уникальности на уровне столбца:
CREATE TABLE table_name(
 attribute_name1 type
 attribute_name2 type UNIQUE
);

Ограничение уникальности на уровне таблицы:
CREATE TABLE table_name(
 attribute_name1 type,
 attribute_name2 type,
 attribute_name3 type,
 UNIQUE(attribute_name1)
);

Ограничение уникальности для группы столбцов:
CREATE TABLE table_name (
 a int,
 b int,
 c int,
 UNIQUE (a, c)
);


Первичный ключ PRIMARY KEY

PRIMARY KEY (англ. первичный ключ)- обозначает, что столбец или группы столбцов может быть уникальным идентификатором строк в таблице. Значения должны быть уникальными и отличными от NULL значения.

CREATE TABLE table_name(
 attribute_name1 type PRIMARY KEY,
 attribute_name2 type
);

CREATE TABLE table_name(
 attribute_name1 type,
 attribute_name2 type,
 PRIMARY KEY(attribute_name1)
);

Могут включать несколько столбцов:

CREATE TABLE table_name(
 a type PRIMARY KEY,
 b type,
 c type,
 PRIMARY KEY(a,b)
);

При добавлении первичного ключа автоматически создаётся уникальный индекс-B-дерево для
столбца или группы столбцов, перечисленных в первичном ключе, и данные столбцы помечаются
как NOT NULL. Таблица может иметь максимум один первичный ключ. Теория реляционных баз данных
говорит, что первичный ключ должен быть в каждой таблице.


mydb=# create table six(name varchar, age int check (age > 0 and age < 30));
CREATE TABLE
mydb=# \d six
                     Table "public.six"
 Column |       Type        | Collation | Nullable | Default
--------+-------------------+-----------+----------+---------
 name   | character varying |           |          |
 age    | integer           |           |          |
Check constraints:
    "six_age_check" CHECK (age > 0 AND age < 30)


mydb=# insert into six(age) values (33), (22);
ERROR:  new row for relation "six" violates check constraint "six_age_check"
DETAIL:  Failing row contains (null, 33).


mydb=# insert into six(age) values(29), (22);
INSERT 0 2
mydb=# select * from six;
name | age
------+-----
      |  29
      |  22
(2 rows)


mydb=# create table seven(name varchar(100), age int, check(age > 0));
CREATE TABLE
mydb=# \d seven;
                       Table "public.seven"
 Column |          Type          | Collation | Nullable | Default
--------+------------------------+-----------+----------+---------
 name   | character varying(100) |           |          |
 age    | integer                |           |          |
Check constraints:
    "seven_age_check" CHECK (age > 0)


mydb=# create table seven(name varchar(100), age int, weigth int, check(age > 0 and weigth > 0));
CREATE TABLE
mydb=# \d seven;
                       Table "public.seven"
 Column |          Type          | Collation | Nullable | Default
--------+------------------------+-----------+----------+---------
name   | character varying(100) |           |          |
age    | integer                |           |          |
weigth | integer                |           |          |
Check constraints:
    "seven_check" CHECK (age > 0 AND weigth > 0)


mydb=# create table eight(name char(100), age int, constraint my_super_attribute check(age > 0));
CREATE TABLE
mydb=# \d eight;
                   Table "public.eight"
Column |      Type      | Collation | Nullable | Default
--------+----------------+-----------+----------+---------
name   | character(100) |           |          |
age    | integer        |           |          |
Check constraints:
    "my_super_attribute" CHECK (age > 0)


mydb=# drop table eight;
DROP TABLE
mydb=# create table eight(name char(100), age int, email varchar(100), unique(email));
CREATE TABLE
mydb=# \d eight;
                       Table "public.eight"
 Column |          Type          | Collation | Nullable | Default
--------+------------------------+-----------+----------+---------
name   | character(100)         |           |          |
age    | integer                |           |          |
email  | character varying(100) |           |          |
Indexes:
    "eight_email_key" UNIQUE CONSTRAINT, btree (email)


.mydb=# drop table eight;
DROP TABLE
mydb=# create table eight(name char(100), age int, email varchar(100), unique(email));
CREATE TABLE
mydb=# \d eight;
                       Table "public.eight"
 Column |          Type          | Collation | Nullable | Default
--------+------------------------+-----------+----------+---------
 name   | character(100)         |           |          |
 age    | integer                |           |          |
 email  | character varying(100) |           |          |
Indexes:
    "eight_email_key" UNIQUE CONSTRAINT, btree (email)


mydb=# insert into eight(name, email) values('bob', 'bob@gmail.com'), ('andrey', 'andrey@gmail.com');
INSERT 0 2
mydb=# select * from eight;
mydb=# insert into eight(name, email) values('gog', 'bob@gmail.com');
ERROR:  duplicate key value violates unique constraint "eight_email_key"
DETAIL:  Key (email)=(bob@gmail.com) already exists.


mydb=# alter table eight drop constraint eight_email_key;
ALTER TABLE

mydb=# create table table_name(a int, b int, c int, unique(a, c));
CREATE TABLE


mydb=# \d table_name;
             Table "public.table_name"
 Column |  Type   | Collation | Nullable | Default
--------+---------+-----------+----------+---------
 a      | integer |           |          |
 b      | integer |           |          |
 c      | integer |           |          |
Indexes:
    "table_name_a_c_key" UNIQUE CONSTRAINT, btree (a, c)


mydb=# insert into table_name(a, c) values(1,2), (2, 1), (1, 3);
INSERT 0 3
mydb=# select * from table_name;
 a | b | c
---+---+---
 1 |   | 2
 2 |   | 1
 1 |   | 3
(3 rows)

mydb=# insert into table_name(a, c) values(2,2), (2, 2), (1, 3);
ERROR:  duplicate key value violates unique constraint "table_name_a_c_key"
DETAIL:  Key (a, c)=(2, 2) already exists.


mydb=# create table table_name(name varchar(100), age int, email varchar(100), primary key(email));
CREATE TABLE
mydb=# \d table_name;
                    Table "public.table_name"
 Column |          Type          | Collation | Nullable | Default
--------+------------------------+-----------+----------+---------
 name   | character varying(100) |           |          |
 age    | integer                |           |          |
 email  | character varying(100) |           | not null |
Indexes:
    "table_name_pkey" PRIMARY KEY, btree (email)
---------------VIDEO #6---------------


---------------VIDEO #7---------------
NOT NULL

Изменение(удаление) ограничения NOT NULL:

ALTER TABLE имя_таблицы
ALTER COLUMN имя_атрибута
SET NOT NULL;

Удаление(изменение) ограничений NOT NULL:

ALTER TABLE имя_таблицы
ALTER COLUMN имя_атрибута
DROP NOT NULL;



CHECK

Добавление ограничения CHECK:

ALTER TABLE table_name
ADD CHECK (attribute_name условие);

Добавление ограничения с помощью оператора CONSTRAINT:

ALTER TABLE table_name
ADD CONSTRAINT constraint_name CHECK(attribute_name условие);

Удалить ограничение CHECK:

ALTER TABLE table_name
DROP CONSTRAINT constraint_name;



UNIQUE

Добавление ограничения UNIQUE:

ALTER TABLE table_name
ADD UNIQUE (attribute_name);

Добавление ограничения с помощью оператора CONSTRAINT:

ALTER TABLE table_name
ADD CONSTRAINT constraint_name UNIQUE(attribute_name);

Удалить ограничение UNIQUE:

ALTER TABLE table_name
DROP CONSTRAINT constraint_name;



PRIMARY KEY

Добавление ограниечения:

ALTER TABLE table_name
ADD PRIMERY KEY (attribute_name);

Добавление ограничения с помощью оператора CONSTRAINT::

ALTER TABLE table_name
CONSTRAINT constraint_name PRIMARY KEY(attribute_name)

Удаление PRIMARY_KEY:

ALTER TABLE имя_таблицы,
DROP CONSTRAINT имя_первичного_ключа;

mydb=# create table ten(id serial, name varchar(100), email varchar(100), comment text default 'no comment'::text, age int, check(age > 0 and age < 100), primary key(id), unique(email));
CREATE TABLE
mydb=# \d ten;
                                    Table "public.ten"
 Column  |          Type          | Collation | Nullable |             Default
---------+------------------------+-----------+----------+---------------------------------
 id      | integer                |           | not null | nextval('ten_id_seq'::regclass)
 name    | character varying(100) |           |          |
 email   | character varying(100) |           |          |
 comment | text                   |           |          | 'no comment'::text
 age     | integer                |           |          |
Indexes:
    "ten_pkey" PRIMARY KEY, btree (id)
    "ten_email_key" UNIQUE CONSTRAINT, btree (email)
Check constraints:
    "ten_age_check" CHECK (age > 0 AND age < 100)


mydb=# alter table ten alter column name set not null;
ALTER TABLE
mydb=# \d ten;
                                    Table "public.ten"
Column  |          Type          | Collation | Nullable |             Default
---------+------------------------+-----------+----------+---------------------------------
id      | integer                |           | not null | nextval('ten_id_seq'::regclass)
name    | character varying(100) |           | not null |
email   | character varying(100) |           |          |
comment | text                   |           |          | 'no comment'::text
age     | integer                |           |          |
Indexes:
    "ten_pkey" PRIMARY KEY, btree (id)
    "ten_email_key" UNIQUE CONSTRAINT, btree (email)
Check constraints:
    "ten_age_check" CHECK (age > 0 AND age < 100)


.mydb=# alter table ten alter column name drop not null;
ALTER TABLE


.mydb=# alter table ten drop constraint ten_age_check;
ALTER TABLE
mydb=# \d ten;
                                    Table "public.ten"
 Column  |          Type          | Collation | Nullable |             Default
---------+------------------------+-----------+----------+---------------------------------
 id      | integer                |           | not null | nextval('ten_id_seq'::regclass)
 name    | character varying(100) |           |          |
 email   | character varying(100) |           |          |
 comment | text                   |           |          | 'no comment'::text
 age     | integer                |           |          |
Indexes:
    "ten_pkey" PRIMARY KEY, btree (id)
    "ten_email_key" UNIQUE CONSTRAINT, btree (email)


.mydb=# alter table ten add constraint limitation check(age > 0 and age < 100);
ALTER TABLE
mydb=# \d ten;
                                    Table "public.ten"
 Column  |          Type          | Collation | Nullable |             Default
---------+------------------------+-----------+----------+---------------------------------
 id      | integer                |           | not null | nextval('ten_id_seq'::regclass)
 name    | character varying(100) |           |          |
 email   | character varying(100) |           |          |
 comment | text                   |           |          | 'no comment'::text
 age     | integer                |           |          |
Indexes:
    "ten_pkey" PRIMARY KEY, btree (id)
    "ten_email_key" UNIQUE CONSTRAINT, btree (email)
Check constraints:
    "limitation" CHECK (age > 0 AND age < 100)


.mydb=# alter table ten add check(age > 0 and age < 100);
ALTER TABLE
mydb=# \d ten;
                                    Table "public.ten"
 Column  |          Type          | Collation | Nullable |             Default
---------+------------------------+-----------+----------+---------------------------------
 id      | integer                |           | not null | nextval('ten_id_seq'::regclass)
 name    | character varying(100) |           |          |
 email   | character varying(100) |           |          |
 comment | text                   |           |          | 'no comment'::text
 age     | integer                |           |          |
Indexes:
    "ten_pkey" PRIMARY KEY, btree (id)
    "ten_email_key" UNIQUE CONSTRAINT, btree (email)
Check constraints:
    "ten_age_check" CHECK (age > 0 AND age < 100)


.mydb=# alter table ten drop constraint ten_email_key;
ALTER TABLE
mydb=# \d ten;
                                    Table "public.ten"
 Column  |          Type          | Collation | Nullable |             Default
---------+------------------------+-----------+----------+---------------------------------
 id      | integer                |           | not null | nextval('ten_id_seq'::regclass)
 name    | character varying(100) |           |          |
 email   | character varying(100) |           |          |
 comment | text                   |           |          | 'no comment'::text
 age     | integer                |           |          |
Indexes:
    "ten_pkey" PRIMARY KEY, btree (id)
Check constraints:
    "ten_age_check" CHECK (age > 0 AND age < 100)


.mydb=# alter table ten add constraint unique_email unique(email);
ALTER TABLE
mydb=# \d ten;
                                    Table "public.ten"
 Column  |          Type          | Collation | Nullable |             Default
---------+------------------------+-----------+----------+---------------------------------
 id      | integer                |           | not null | nextval('ten_id_seq'::regclass)
 name    | character varying(100) |           |          |
 email   | character varying(100) |           |          |
 comment | text                   |           |          | 'no comment'::text
 age     | integer                |           |          |
Indexes:
    "ten_pkey" PRIMARY KEY, btree (id)
    "unique_email" UNIQUE CONSTRAINT, btree (email)
Check constraints:
    "ten_age_check" CHECK (age > 0 AND age < 100)


.mydb=# alter table ten drop constraint unique_email;
ALTER TABLE


.mydb=# alter table ten add unique(email);
ALTER TABLE
mydb=# \d ten;
                                    Table "public.ten"
 Column  |          Type          | Collation | Nullable |             Default
---------+------------------------+-----------+----------+---------------------------------
 id      | integer                |           | not null | nextval('ten_id_seq'::regclass)
 name    | character varying(100) |           |          |
 email   | character varying(100) |           |          |
 comment | text                   |           |          | 'no comment'::text
 age     | integer                |           |          |
Indexes:
    "ten_pkey" PRIMARY KEY, btree (id)
    "ten_email_key" UNIQUE CONSTRAINT, btree (email)
Check constraints:
    "ten_age_check" CHECK (age > 0 AND age < 100)


.mydb=# alter table ten drop constraint ten_pkey;
ALTER TABLE
mydb=# \d ten;
                                    Table "public.ten"
 Column  |          Type          | Collation | Nullable |             Default
---------+------------------------+-----------+----------+---------------------------------
 id      | integer                |           | not null | nextval('ten_id_seq'::regclass)
 name    | character varying(100) |           |          |
 email   | character varying(100) |           |          |
 comment | text                   |           |          | 'no comment'::text
 age     | integer                |           |          |
Indexes:
    "ten_email_key" UNIQUE CONSTRAINT, btree (email)
Check constraints:
    "ten_age_check" CHECK (age > 0 AND age < 100)


.mydb=# alter table ten add constraint key primary key(id);
ALTER TABLE
mydb=# \d ten;
                                    Table "public.ten"
 Column  |          Type          | Collation | Nullable |             Default
---------+------------------------+-----------+----------+---------------------------------
 id      | integer                |           | not null | nextval('ten_id_seq'::regclass)
 name    | character varying(100) |           |          |
 email   | character varying(100) |           |          |
 comment | text                   |           |          | 'no comment'::text
 age     | integer                |           |          |
Indexes:
    "key" PRIMARY KEY, btree (id)
    "ten_email_key" UNIQUE CONSTRAINT, btree (email)
Check constraints:
    "ten_age_check" CHECK (age > 0 AND age < 100)
---------------VIDEO #7---------------



---------------VIDEO #8---------------
Ограничение внешнего ключа FOREIGN KEY.

ОГРАНИЧЕНИЕ внешнего ключа(FOREIGN KEY) указывает, что значения столбца (или группы столбцов) таблицы должны со-
ответствовать значениям в некоторой строке другой таблицы. Это называется ссылочной целост-
ностью двух связанных таблиц.

Связь между таблицами.

Виды связей(отношений):

1 Один к одному;
2 Одни ко многим;
3 Многие ко многим;

Для связи между таблицами применяются внешние ключи(FOREIGN KEY).

Внешний ключ устанавливается для столбца из зависимой, подчиненной таблицы,
Указывает на один из столбцов главной таблицы (referenced table)


Синтаксис:


CREATE TABLE имя_таблицы (
atribute_name_1,
atribute_name_2,
atribute_name_3 integer REFERENCES имя_главной_таблицы (атрибут_главной таблицы),
);



CREATE TABLE имя_таблицы (
atribute_name_1,
atribute_name_2,
atribute_name_3,
FOREIGN KEY (atribute_name_3) REFERENCES имя_главной_таблицы (атрибут_главной таблицы)
);



если опустить список столбцов, внешний ключ будет неявно связан с первичным ключом
главной таблицы.

CREATE TABLE имя_таблицы (
atribute_name_1,
atribute_name_2,
atribute_name_3 integer REFERENCES имя_главной_таблицы
);




Один к одному(One to one)

Пример:

orders называют подчинённой таблицей, а products — главной.

CREATE TABLE products (
product_no integer PRIMARY KEY,
name text,
price numeric
);

INSERT INTO products
VALUES(0, 'мыло детское', 82.6),
(1, 'шампунь детский', 88.7),
(2, 'зубная щетка', 22);


CREATE TABLE orders (
order_id integer PRIMARY KEY,
product_no integer REFERENCES products (product_no),
quantity integer
);

С таким ограничением создать заказ со значением product_no, отсутствующим в таблице products
(и не равным NULL), будет невозможно.


mydb=# create table products(product_no integer primary key, name text, price numeric);
CREATE TABLE
mydb=# \d products;
                Table "public.products"
   Column   |  Type   | Collation | Nullable | Default
------------+---------+-----------+----------+---------
 product_no | integer |           | not null |
 name       | text    |           |          |
 price      | numeric |           |          |
Indexes:
    "products_pkey" PRIMARY KEY, btree (product_no)


.mydb=# insert into products values(0, 'child soap', 82.6), (1, 'child shampoo', 88.7), (2, 'tooth paste', 22);
INSERT 0 3
mydb=# select * from products;
 product_no |     name      | price
------------+---------------+-------
          0 | child soap    |  82.6
          1 | child shampoo |  88.7
          2 | tooth paste   |    22
(3 rows)


.mydb=# create table orders(order_id integer primary key, product_no integer references products(product_no));
CREATE TABLE
mydb=# \d orders;
                 Table "public.orders"
   Column   |  Type   | Collation | Nullable | Default
------------+---------+-----------+----------+---------
 order_id   | integer |           | not null |
 product_no | integer |           |          |
Indexes:
    "orders_pkey" PRIMARY KEY, btree (order_id)
Foreign-key constraints:
    "orders_product_no_fkey" FOREIGN KEY (product_no) REFERENCES products(product_no)


.mydb=# alter table orders add column quality integer;
ALTER TABLE
mydb=# \d orders;
                 Table "public.orders"
   Column   |  Type   | Collation | Nullable | Default
------------+---------+-----------+----------+---------
 order_id   | integer |           | not null |
 product_no | integer |           |          |
 quality    | integer |           |          |
Indexes:
    "orders_pkey" PRIMARY KEY, btree (order_id)
Foreign-key constraints:
    "orders_product_no_fkey" FOREIGN KEY (product_no) REFERENCES products(product_no)


.mydb=# insert into orders values(7412, 0, 2);
INSERT 0 1
mydb=# select * from orders;
 order_id | product_no | quality
----------+------------+---------
     7412 |          0 |       2
(1 row)


.mydb=# insert into orders values(9087, 6, 2);
ERROR:  insert or update on table "orders" violates foreign key constraint "orders_product_no_fkey"
DETAIL:  Key (product_no)=(6) is not present in table "products".


.mydb=# \d products;
                Table "public.products"
   Column   |  Type   | Collation | Nullable | Default
------------+---------+-----------+----------+---------
 product_no | integer |           | not null |
 name       | text    |           |          |
 price      | numeric |           |          |
Indexes:
    "products_pkey" PRIMARY KEY, btree (product_no)
Referenced by:
    TABLE "orders" CONSTRAINT "orders_product_no_fkey" FOREIGN KEY (product_no) REFERENCES products(product_no)


.mydb=# \d orders;
                 Table "public.orders"
   Column   |  Type   | Collation | Nullable | Default
------------+---------+-----------+----------+---------
 order_id   | integer |           | not null |
 product_no | integer |           |          |
 quality    | integer |           |          |
Indexes:
    "orders_pkey" PRIMARY KEY, btree (order_id)
Foreign-key constraints:
    "orders_product_no_fkey" FOREIGN KEY (product_no) REFERENCES products(product_no)
---------------VIDEO #8---------------










---------------SETERATE VIDEO---------------
Пример для работы с таблицей:

CREATE TABLE products (
product_no integer PRIMARY KEY,
manufacturing_company varchar(255) DEFAULT('no name'),
name text,
price numeric(9,2)
);


Insert Into products
Values
('1500510', 'RITTAL', 'KL Клеммн. коробка RAL7035 150x150x120mm', '26.21'),
('1501510', 'RITTAL', 'KL Клеммн. коробка RAL7035 300x150x120mm', '33.65'),
('1502510', 'RITTAL', 'KL Клеммн. коробка RAL7035 200x200x120mm', '29.4'),
('1503510', 'RITTAL', 'KL Клеммн. коробка RAL7035 300x200x120mm', '33.04'),
('1504510', 'RITTAL', 'KL Клеммн. коробка RAL7035 400x200x120mm', '36.87'),
('1505510', 'RITTAL', 'KL Клеммн. коробка RAL7035 500x200x120mm', '46.5'),
('1506510', '', 'KL Клеммн. коробка RAL7035 600x200x120mm', '50.54'),
('1507510', '', 'KL Клеммн. коробка RAL7035 300x300x120mm', '39.28'),
('1508510', 'SIEMENS', 'KL Клеммн. коробка RAL7035 400x300x120mm', '43.54'),
('1509510', 'SIEMENS', 'KL Клеммн. коробка RAL7035 500x300x120mm', '54.93'),
('1510510', 'SIEMENS', 'KL Клеммн. коробка RAL7035 600x300x120mm', '61.24'),
('1511510', 'SIEMENS', 'KL Клеммн. коробка RAL7035 400x400x120mm', '58.81'),
('1512510', 'SIEMENS', 'KL Клеммн. коробка RAL7035 600x400x120mm', '69.74')
;

-----------------------------------------------------------------------------
Запросы SQL в Postgres

1) DISTINCT(отчетливый)

Оператор DISTINCT позволяет выбрать уникальные данные по определенным столбцам.

SELECT DISTINCT attribute_name
FROM table_name;


2) ORDER BY(СОРТИРОВАТЬ ПО)

Позволяет отсортировать значения по определенному столбцу.

SELECT attribute_name FROM table_name
ORDER BY attribute_name;

C помощью оператора DESC можно задать сортировку по убыванию, по умолчанию используется оператор ASC

Операторы:
ASC(по возрастанию)
DESC(по убыванию)

SELECT attribute_name FROM table_name
ORDER BY attribute_name DESC;


Сотировка по нескольким столбцам(показать пример на сущуствующей таблицы):

SELECT brand, price FROM table_name
ORDER BY brand DESC, price ASC;


3) LIMIT(ПРЕДЕЛ), OFFSET(SET -задать)
LIMIT - это количество
OFFSET - с какой строки наччинаем создавать список

Позволяет извлечь определенное количество строк.

SELECT DISTINCT attribute_name
FROM table_name LIMIT 4;

Оператор OFFSET
позволяет указать, с какой строки надо начинать выборку. Например, выберем 4 строки, начиная с 3-eй:

SELECT attribute_name
FROM table_name LIMIT 4 OFFSET 3;


Выбрать все строки, начиная с какой-то определенной, то оператор LIMIT можно опустить:

SELECT attribute_name
FROM table_name LIMIT ALL OFFSET 3;


---------------SETERATE VIDEO---------------
