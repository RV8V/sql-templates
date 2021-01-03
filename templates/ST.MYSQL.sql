INSERT INTO book VALUES(NULL, 'title', 'author', 10, 1);

SELECT title,
       price,
       CHAR_LENGTH(title) AS title_len,
       CONCAT(CONV(price, 10, 2), ' abstract money') AS b_price,
       ceiling(4.1) AS more,
       floor(4.1) AS less,
       round(price*0.7) AS new_price,
       round((price*18/100)/(1+18/100), 2) AS tax,
       round(price/(1+18/100), 2) AS price_tax,
       author,
       round(((sum(price*amount)*(0.18))/(1 + 0.18)), 2) AS 'NDS',
       round(((sum(price*amount))/(1 + 0.18)), 2) AS 'WITHOUTNDS',
       round(if(amount < 4, price*0.5, if(amount < 11, price*0.7, price*0.9)), 2) AS sale,
       if(amount < 4, 'discont is 50%', if(amount < 11, 'discont is 30%', 'discont is 10%')) AS discont,
       round(if(author = 'first', price*1.1, if(author = 'second one', price*1.05, price)), 2) AS disc
FROM book
WHERE (author = 'Булгаков М.А.' OR author = 'Есенин С.А.')
      AND (price > 600 OR price*amount >= 5000)
      OR amount BETWEEN 2 AND 6
      OR  5 < amount < 14;
      OR title LIKE '%_____%'
      OR author NOT LIKE '_% _%'
      GROUP BY author
      OR price < 750 ORDER BY title ASC, author DESC;

SELECT CONCAT(b1.title, ' & ', b2.title) AS set_title,
       b1.author,
       round(((b1.price+b2.price)*0.9), 2) AS set_price,
       if(b1.amount < b2.amount, b1.amount, b2.amount) AS set_amount
FROM book AS b1
     CROSS JOIN book AS b2
WHERE b1.author = b2.author
      AND b1.title > b2.title;

CREATE TABLE booking
SELECT (book_id-(SELECT MAX(book_id) FROM book)-1)*(-1) AS book_id1,
       title AS title1, author AS author1,
       price AS price_new,
       amount AS amount_new
FROM book;
SELECT book.book_id, book.title, book.author, booking.price_new, booking.amount_new FROM book
       RIGHT OUTER JOIN booking ON book_id = book_id1
ORDER BY book_id ASC;
DROP TABLE booking

UPDATE
      book
          SET
          title  = CONCAT(CONCAT(author, ' and '), title) AS result_title,
          author = CONCAT('author: ', author)
          ;
SELECT
      author,
      title,
      price * 1.2 AS price,
                          FROM
                              book
                              ;
DROP TABLE IF EXISTS book;
CREATE TABLE IF NOT EXISTS book(
    book_id INT(10)       UNSIGNED NOT NULL AUTO_INCREMENT,
    title   VARCHAR(50)   DEFAULT NULL,
    author  VARCHAR(30)   DEFAULT NULL,
    price   DECIMAL(8, 2) DEFAULT NULL,
    amount  INT(10)       DEFAULT NULL,
    PRIMARY KEY(book_id)
) ENGINE = MyISAM AUTO_INCREMENT = 7 DEFAULT CHARSET = utf8;

DELETE FROM `book`;
-- !40000 ALTER TABLE `book` DISABLE KEYS
INSERT INTO `book`(`book_id`, `title`, `author`, `price`, `amount`) VALUES
    (1, 'Мастер и Маргарита', 'Булгаков М.А.', 670.99, 3),
    (2, 'Белая гвардия', 'Булгаков М.А.', 540.50, 5),
    (3, 'Идиот', 'Достоевский Ф.М.', 460.00, 10),
    (4, 'Братья Карамазовы', 'Достоевский Ф.М.', 799.01, 2),
    (5, 'Игрок', 'Достоевский Ф.М.', 480.50, 10),
    (6, 'Стихотворения и поэмы', 'Есенин С.А.', 650.00, 15);
-- !40000 ALTER TABLE `book` ENABLE KEYS

-- COUNT(*) —  подсчитывает  все записи, относящиеся к группе, в том числе и со значением NULL;
-- COUNT(имя_столбца) — возвращает количество записей конкретного столбца (только NOT NULL), относящихся к группе.

-- когда в GROUP BY пишут author. title, то SQL  принимает в SUM(amount) каждую строку, где встречаются данные комбинации .

-- COUNT(*) — означает то, что функция COUNT подсчитывает  все записи в таблице, относящиеся к группе;
-- COUNT(column_name) — функция COUNT возвращает количество записей конкретного столбца (только NOT NULL), относящихся к группе.

-- | FROM
-- | WHERE
-- | GROUP BY
-- | HAVING
-- | SELECT (Групповые функции типа COUNT, SUM и т.д. здесь) ?
-- | ORDER BY ?
-- | DISTINCT ?

-- SELECT in 5-th place
--> язык является декларативным, а не императивным! Следовательно, разработчики это сделали, в первую очередь, с "прицелом" на удобочитаемость,
--> а не на фактическую последовательность выполнения операторов

-- DISTINCT можно использовать только для того, чтобы выделить РАЗЛИЧНЫЕ записи. Если в запросе нужны групповые функции, тогда обязательно нужен GROUP BY.

-- Сначала определяется таблица, из которой выбираются данные (FROM),
-- затем из этой таблицы отбираются записи в соответствии с условием  WHERE
-- выбранные данные агрегируются (GROUP BY), из агрегированных записей выбираются те, которые удовлетворяют условию после HAVING
-- Потом формируются данные результирующей выборки, как это указано после SELECT ( вычисляются выражения, присваиваются имена и пр. )
-- Результирующая выборка сортируется, как указано после ORDER BY.

-- SELECT [DISTINCT | ALL]{*
--  | [<выражение для столбца> [[AS] <псевдоним>]] [,…]}
-- FROM <имя таблицы> [[AS] <псевдоним>] [,…]
-- [WHERE <предикат>]
-- [[GROUP BY <список столбцов>]
-- [HAVING <условие на агрегатные значения>] ]
-- [ORDER BY <список столбцов>]

-- ==================================   Порядок операций SQL – В каком порядке MySQL выполняет запросы?   ==================================

-- 1. FROM, включая JOINs
-- 2. WHERE
-- 3. GROUP BY
-- 4. HAVING
-- 5. Функции WINDOW
-- 6. SELECT
-- 7. DISTINCT
-- 8. UNION
-- 9. ORDER BY
-- 10.LIMIT и OFFSET

SELECT author
FROM book
GROUP BY author
HAVING sum(amount) > 10 AND author <> 'new one';

SELECT author
FROM book
WHERE author <> 'new one'
GROUP BY author
HAVING sum(amount) > 10

SELECT DISTINCT author, min(price) FROM book; -- -
SELECT author, min(price) FROM book GROUP BY author;

SELECT
    author AS [author - author],
    COUNT(DISTINCT title),
    SUM(amount) AS amount,
    SUM(amount * price) AS value
FROM book
GROUP BY author;

SELECT
      author,
      round(_sum, 2) AS summing,
      round(_sum*18/100/(1+18/100), 2) AS DNS,
      round(_sum/(1+18/100), 2) AS WITHOUT_NDS
FROM
    SELECT
          author,
          sum(price*amount) AS _sum,
    FROM book;
    GROUP BY author;

SELECT
      _.mi AS [min price],
      _.ma AS [max price],
      round(_av, 2) AS [average price]
FROM
    SELECT min(price) AS mi, max(price) AS ma, avg(price) AS av _;

SELECT
      author,
      min(price) AS [min price],
      max(price) AS [max price]
FROM
        book
GROUP BY
        author
HAVING
        sum(price * amount) > 5000
ORDER BY
        [min price] DESC;

SELECT author,
       min(price) AS [min price],
       max(price) AS [max price]
FROM book
GROUP BY author
HAVING sum(price * amount) > 5000
ORDER BY [min price] DESC;

-- Если в запросе с групповыми функциями отсутствует GROUP BY, то для отбора записей используется ключевое слово WHERE.
-- Если есть GROUP BY и нужно условие, то используется HAVING
-- Group by выполняется после select, where - до, соответственно в group by можем использовать вычисляемые агрегаты.
-- where и having используются для наложения ограничений, но where используются при ограничении на исходные значения в строках нашей таблицы, а having на уже агрегированные значения.
-- вывести данные у которых минимальная цена больше средней цены по базе:

SELECT author,
       min(price) AS [min price],
       max(price) AS [max price]
FROM book
GROUP BY author
HAVING min(price) > (SELECT avg(price) FROM book);

SELECT
      author,
      COUNT(title) AS [title count],
      MIN(price) AS [min price],
      MAX(price) AS [max price],
      SUM(amount) AS [amount of books]
FROM book
WHERE author IN
               SELECT author FROM book
               WHERE price > 500 AND amount > 1
               GROUP BY author
GROUP BY author
HAVING COUNT(DISTINCT title) > 1;

-- Вывести информацию о самых дешевых книгах, хранящихся на складе.
-- Вложенный запрос, возвращающий одно значение

SELECT title, author, price, amount
FROM book
WHERE price = (SELECT min(price) FROM book);

-- Вывести информацию (автора, название и цену) о  книгах, цены которых меньше или равны средней цене книг на складе. Информацию вывести в отсортированном по убыванию цены виде. Среднее вычислить как среднее по цене книги.

SELECT title, author, price
FROM book
WHERE price <= (SELECT avg(price) FROM book)
ORDER BY price DESC;

-- Вывести информацию о книгах, количество которых отличается от среднего количества книг на складе более чем на 3. То есть нужно вывести и те книги, количество которых меньше среднего на 3, и больше среднего на 3.

SELECT title, author, price, amount
FROM book
WHERE ABS(amount - (SELECT avg(price) FROM book)) > 3;

-- Вывести информацию (автора, название и цену) о тех книгах, цены которых превышают минимальную цену книги на складе не более чем на 150 рублей в отсортированном по возрастанию цены виде.

SELECT title, author, price
FROM book
WHERE ABS(amount - (SELECT min(price) FROM book)) < 150
      OR price <= (SELECT MIN(price) FROM book) + 150
      OR price BETWEEN (SELECT min(price) FROM book)) AND (SELECT min(price) FROM book) + 150
ORDER BY price ASC;

-- Вывести информацию о книгах тех авторов, общее количество экземпляров книг которых не менее 12.

SELECT title, author, amount, price
FROM book
WHERE author IN(SELECT author FROM book GROUP BY author HAVING SUM(amount) >= 12);

-- Вывести информацию (автора, книгу и количество) о тех книгах, количество которых в таблице book не повторяется.

SELECT author, title, amount
FROM book
WHERE amount IN(SELECT amount FROM book GROUP BY amount HAVING count(amount) = 1)
      OR amount IN(SELECT amount FROM book GROUP by 1 HAVING count(1) > 1);
      OR NOT amount IN(SELECT amount FROM book GROUP BY amount HAVING count(*) > 1)
      OR NOT amount IN(SELECT amount FROM book GROUP BY amount HAVING count(amount) <> 1);

SELECT
    author,
    title,
    amount
FROM
    book
GROUP BY amount
HAVING count(amount) = 1
;

-- Вложенный запрос, операторы ANY и ALL
-- Операторы ANY и ALL используются  в SQL для сравнения некоторого значения с результирующим набором вложенного запроса,
-- состоящим из одного столбца. При этом тип данных столбца, возвращаемого вложенным запросом, должен совпадать с типом данных столбца (или выражения), с которым происходит сравнение.

-- amount > ANY (10, 12) эквивалентно amount > 10
-- amount < ANY (10, 12) эквивалентно amount < 12
-- amount = ANY (10, 12) эквивалентно (amount = 10) OR (amount = 12), а также amount IN(10,12)
-- amount <> ANY (10, 12) вернет все записи с любым значением amount, включая 10 и 12

-- amount > ALL (10, 12) эквивалентно amount > 12
-- amount < ALL (10, 12) эквивалентно amount < 10
-- amount = ALL (10, 12) не вернет ни одной записи, так как эквивалентно (amount = 10) AND (amount = 12)
-- amount <> ALL (10, 12) вернет все записи кроме тех, в которых amount равно 10 или 12

-- Вывести информацию о книгах тех авторов, общее количество экземпляров книг которых не меньше 12.

SELECT title, author, price, amount
FROM book
WHERE author = ANY(SELECT author FROM book GROUP BY author HAVING sum(amount) >= 12)
      OR author IN(SELECT author FROM book GROUP BY author HAVING sum(amount) >= 12);

-- В условии отбора основного запроса фамилия автора с помощью = ANY сравнивается с результатом вложенного запроса (Достоевский и Есенин)
-- Если фамилия автора из основного запроса совпадет с какой-нибудь фамилией результата, то соответствующая запись включается в итоговую таблицу запроса.

-- Вывести информацию о книгах(автор, название, цена) только тех авторов, средняя цена книг которых выше, чем средняя цена книг на складе в целом.

SELECT ...
FROM ...
WHERE author = ... (SELECT ...
                              (SELECT ...));
SELECT author, title, price
FROM book
WHERE author = ANY(SELECT author FROM book GROUP BY author HAVING AVG(price) >
                                                                              (SELECT AVG(price) FROM book));
SELECT author, title, price
FROM book
WHERE author = ANY(SELECT author FROM book GROUP BY author HAVING avg(price) >
                                                                              ALL(SELECT sum(price)/count(book_id) FROM book));
-- Вложенный запрос после SELECT

SELECT title, author, amount,
       FLOOR((SELECT avg(amount) AS 'Среднее_количество'))
FROM book
WHERE abs(amount - (SELECT avg(amount) FROM book) > 3);

-- Посчитать сколько и каких книг нужно заказать поставщикам, чтобы на складе было одинаковое количество каждой книги,
-- равное максимальному значению из всех количеств книг, хранящихся на складе. Столбцу с количеством заказываемых книг присвоить имя Заказ.
-- Пояснение. Поскольку книгу с максимальным количеством экземпляров заказывать не нужно, в условии отбора запроса укажите, что книгу с максимальным значением количества в результирующую таблицу не включать.

SELECT title, author, amount,
       ((SELECT max(amount) FROM book) - amount) AS 'order'
FROM book
WHERE amount <> (SELECT max(amount) FROM book)
      OR ((SELECT MAX(amount) FROM book) - amount) <> 0;

-- Если в запросе нет GROUP BY нужно использовать WHERE.

WITH cte AS (SELECT max(amount) max_amount FROM book)
SELECT title, author, amount, cte.max_amount - amount AS order
FROM cte, book
WHERE cte.max_amount - amount > 0;

-- tables

INSERT INTO supply (title,    author,    price, amount)
VALUES
        (`Лирика`,     `Пастернак Б.Л.`,     518.99,     2),
        (`Черный человек`,      `Есенин С.А.`,     570.20,     6),
        (`Белая гвардия`,     `Булгаков М.А.`,     540.50,     7),
        (`Идиот`,     `Достоевский Ф.М.`,     360.80,     3);

INSERT INTO book(title, author, price, amount)
       SELECT title, author, price, amount
       FROM supply;
SELECT * FROM book;

INSERT INTO book (title, author, price, amount)
       SELECT title, author, price, amount
       FROM supply
       WHERE title <> ALL (SELECT title FROM book)
             OR title NOT IN (SELECT title FROM book)
             OR concat(supply.author, supply.title) not in(select concat(author, title) from book)
             OR author NOT REGEXP '.*(Булгаков|Достоевский).*';
SELECT * FROM book;

-- Добавление записей, вложенные запросы

INSERT INTO book(title, author, price, amount)
       SELECT title, author, price, amount
       FROM supply
       WHERE title NOT IN(SELECT title FROM book)
             OR title <> ALL(SELECT title FROM book)
             AND author NOT IN(SELECT DISTINCT author FROM book)
             OR author <> ALL(SELECT author from book);

INSERT INTO
  book
  (
    title,
    author,
    price,
    amount
  )
  SELECT
    title,
    author,
    price,
    amount
  FROM
    supply
  WHERE
    author NOT IN
      (
        SELECT author
        FROM book
      );

INSERT INTO book(title, author, price, amount)
SELECT s.title, s.author, s.price, s.amount
FROM supply AS s
LEFT JOIN (SELECT author FROM book GROUP BY author) AS b
     ON s.author = b.author
WHERE b.author IS NULL;

-- Запросы на обновление

UPDATE book SET price = price * 0.7,
                amount = amount - buy,
                buy = 0
WHERE amount < 5;

-- В таблице book необходимо скорректировать значение для покупателя в столбце buy таким образом, чтобы оно не превышало допустимый остаток в столбце amount. А цену тех книг, которые покупатель не заказывал, снизить на 10%, округлив полученную цену до двух знаков после запятой.

WITH a AS (SELECT * FROM book)
UPDATE book SET buy = LEAST(buy, amount),
                price = (SELECT GREATEST(a.price*0,9, a,price*LEAST(a.buy, 1)))
                        FROM a
                        WHERE a.book_id = book.book_id; -- ?

UPDATE book SET buy = amount WHERE amount - buy < 0
                                   OR amount < buy;
UPDATE book SET price = round(price * 0.9) WHERE buy = 0;

UPDATE book SET buy = (
                CASE WHEN buy > amount
                     THEN amount
                     ELSE buy
                     END),
                price = (
                CASE WHEN buy = 0
                THEN round(price*0.9, 2)
                ELSE price
                );

UPDATE book SET buy   = COALESCE((SELECT amount FROM book WHERE buy > amount), buy),
                price = COALESCE((SELECT price * 0.9 FROM book WHERE buy = 0), price);

UPDATE book SET buy   = IF(buy > amount, amount, buy),
                price = IF(buy = 0, round(price*0,9, 2), price);

-- Если в таблице supply  есть те же книги, что и в таблице book, добавлять эти книги в таблицу book не имеет смысла. Необходимо увеличить их количество на значение столбца amountтаблицы supply.

UPDATE book, supply SET book.amount = book.amount + supply.amount,
                        book.price = if(book.price <> supply.price, (book.price + supply.price) / 2, book.price)
WHERE book.title = supply.title AND book.author = supply.author;

-- Запросы на удаление

DELETE FROM supply
WHERE title IN(SELECT title FROM book);

-- Удалить из таблицы supply книги тех авторов, общее количество экземпляров книг которых в таблице book превышает 10.

DELETE FROM supply
WHERE author IN(SELECT author
                FROM book
                GROUP BY author
                HAVING 10 < SUM(amount));

-- "копию" таблицы supply :  "FROM book b INNER JOIN (SELECT * FROM supply) s"

DELETE FROM supply
WHERE (title, price) IN(SELECT title, price FROM book)
      OR title IN(SELECT title FROM book WHERE book.price = supply.price);

DELETE FROM supply
WHERE
  title IN (SELECT title
            FROM book
            where
            price = supply.price
            );

DELETE FROM supply
    WHERE supply.title IN(SELECT title
                                 FROM book) AND
          supply.price = ANY(SELECT price
                                 FROM book);

DELETE FROM supply
WHERE (title, price) = ANY(SELECT title, price FROM book);

DELETE FROM supply
INNER JOIN book ON book.title = supply.title AND book.price = supply.price;

-- Запросы на создание таблицы
-- Создать таблицу заказ (ordering), куда включить авторов и названия тех книг, количество которых в таблице book меньше 4. Для всех книг указать одинаковое количество 5.

CREATE TABLE ... AS
SELECT ...;

CREATE TABLE ordering AS
SELECT author, title,
       (SELECT round(avg(amount), 2) FROM book) AS amount
FROM book
WHERE amount < 4;

-- Создать таблицу заказ (ordering), куда включить авторов и названия тех книг, количество которых в таблице book меньше среднего количества книг в таблице book.
-- Для всех книг указать одинаковое значение - среднее количество книг в таблице book.

CREATE TABLE ordering AS
SELECT author,
       title,
       (SELECT ROUND(AVG(amount), 2) FROM book) AS amount
FROM book
WHERE amount - (SELECT ROUND(AVG(amount), 2) FROM book) < 0
GROUP BY author, title
HAVING ROUND(AVG(amount), 2) - amount < 0;

CREATE TABLE ordering AS
       SELECT author,
              title,
              (SELECT round(AVG(amount)) FROM book) AS amount
               FROM book
               WHERE amount < (SELECT round(AVG(amount)) FROM book
              );

CREATE TABLE ordering AS
SELECT author, title,
      (SELECT round
           (AVG(amount))
           FROM book) AS amount
FROM book
WHERE amount < (SELECT
                AVG(amount)
                FROM book);

SELECT *
FROM ordering;

-- Обычно в квадратные скобки берутся имена, которые заняты языком. Но в данном случае можно без [  ]

CREATE TABLE trip
(
    trip_id    INT PRIMARY KEY Identity(1,1),
    [name]     VARCHAR(30),
    city       VARCHAR(25),
    per_diem   DECIMAL(8,2),
    date_first DATE,
    date_last  DATE
)

INSERT INTO trip([name],
                 city,
                 per_diem,
                 date_first,
                 date_last)
VALUES
    ('Баранов П.Е.','Москва',700 , '2020-01-12', '2020-01-17'),
    ('Абрамова К.А.','Владивосток',450 , '2020-01-14', '2020-01-27'),
    ('Семенов И.В.','Москва',700 , '2020-01-23', '2020-01-31'),
    ('Ильиных Г.Р.','Владивосток', 450, '2020-01-12', '2020-02-02'),
    ('Колесов С.П.','Москва',700 , '2020-02-01', '2020-02-06'),
    ('Баранов П.Е.','Москва', 700, '2020-02-14', '2020-02-22'),
    ('Абрамова К.А.','Москва', 700, '2020-02-23', '2020-03-01'),
    ('Лебедев Т.К.','Москва', 700, '2020-03-03', '2020-03-06'),
    ('Колесов С.П.','Новосибирск',450 , '2020-02-27', '2020-03-12'),
    ('Семенов И.В.','Санкт-Петербург',700 , '2020-03-29', '2020-04-05'),
    ('Абрамова К.А.','Москва',700 , '2020-04-06', '2020-04-14'),
    ('Баранов П.Е.','Новосибирск',450 , '2020-04-18', '2020-05-04'),
    ('Лебедев Т.К.','Томск',450 , '2020-05-20', '2020-05-31'),
    ('Семенов И.В.','Санкт-Петербург',700 , '2020-06-01', '2020-06-03'),
    ('Абрамова К.А.','Санкт-Петербург', 700, '2020-05-28', '2020-06-04'),
    ('Федорова А.Ю.','Новосибирск',450 , '2020-05-25', '2020-06-04'),
    ('Колесов С.П.','Новосибирск', 450, '2020-06-03', '2020-06-12'),
    ('Федорова А.Ю.','Томск', 450, '2020-06-20', '2020-06-26'),
    ('Абрамова К.А.','Владивосток', 450, '2020-07-02', '2020-07-13'),
    ('Баранов П.Е.','Воронеж', 450, '2020-07-19', '2020-07-25');

-- Вывести из таблицы trip информацию о командировках тех сотрудников, фамилия которых заканчивается на букву «а», в отсортированном по убыванию даты последнего дня командировки виде. В результат включить столбцы name, city, per_diem, date_first, date_last.

SELECT name, city, per_diem, date_first, date_last FROM trip WHERE name LIKE '%a %' ORDER BY date_last DESC;

-- Distinct - выводит уникальные данные, Group by - группирует. Странное сравнение в части скорости, не находите? Это как сравнить, кто быстрее работает парикмахер или повар?
-- Вывести информацию о командировках во все города кроме Москвы и Санкт-Петербурга (фамилии и инициалы сотрудников, город ,
-- длительность командировки в днях, при этом первый и последний день относится к периоду командировки). Информацию вывести в упорядоченном по убыванию длительности поездки, а потом по убыванию названий городов (в обратном алфавитном порядке).

-- city NOT IN ('...' ,'...') работает, а city <> ALL ('...' ,'...') не работает, так как по логике это одно и то же. Но потом вспомнила, что ALL работает только с вложенными запросами, а NOT IN и без них прекрасно себя чувствует, вдруг кто-то тоже запутался)

SELECT name,
       city,
       ABS(DATEDIFF(date_first, date_last)) + 1 AS 'duration'
FROM trip
WHERE city <> ALL(ARRAY('M', 'ST'))
ORDER BY ABS(DATEDIFF(date_first, date_last)) + 1 DESC, city DESC;

-- Вывести информацию о командировках сотрудника(ов), которые были самыми короткими по времени.

SELECT name,
       city,
       date_first,
       date_last
FROM trip
GROUP BY name,
         city,
         date_first,
         date_last
HAVING MIN(ABS(DATEDIFF(date_first, date_last)))
ORDER BY (SELECT ABS(DATEDIFF(date_first, date_last))) ASC
LIMIT 1;

SELECT name,
       city,
       date_first,
       date_last
FROM trip
WHERE ABS(DATEDIFF(date_first, date_last)) = (SELECT MIN(ABS(DATEDIFF(date_first, date_last)))
                                              FROM trip);

-- Вывести информацию о командировках, начало и конец которых относятся к одному месяцу. Результат отсортировать сначала  в алфавитном порядке по названию города, а затем по фамилии сотрудника .

SELECT name, city, date_first, date_last
FROM trip
GROUP BY name, city, date_first, date_last
HAVING MONTH(date_first) = MONTH(date_last)
ORDER BY city ASC, name ASC;

SELECT name, city, date_first, date_last
FROM trip
WHERE MONTH(date_first) = MONTH(date_last)
ORDER BY city, name;

SELECT name, city, date_first, date_last
FROM trip
WHERE EXTRACT(month FROM date_first) - EXTRACT(month FROM date_last) = 0
ORDER BY city ASC, name ASC;

SELECT name n, city c, date_first, date_last
FROM trip
WHERE MONTH(date_first) = Month(date_last)
ORDER BY LEFT(city, 1), left(name,1);

-- week(date) и QUARTER(date) аналогично
-- откуда бедная машина узнает, из какой таблицы тащить поля?
-- ладно,так уж и быть, помогу машине

-- Вывести название месяца и количество командировок для каждого месяца. Считаем, что командировка относится к некоторому месяцу, если она началась в этом месяце.
-- Информацию вывести сначала в отсортированном по убыванию количества, а потом в алфавитном порядке по названию месяца виде. Название столбцов – Месяц и Количество.

SET @@lc_time_names = 'ru_UA';
SELECT MONTHNAME(date_first) AS month
       COUNT(MONTHNAME(date_first)) AS amount
FROM trip
GROUP BY MONTHNAME(date_first)
ORDER BY COUNT(MONTHNAME(date_first)) DESC, MONTHNAME(date_first) ASC;

SELECT MONTHNAME(date_first) AS Месяц, Count(1) AS Количество FROM trip
GROUP BY Месяц
ORDER BY Количество DESC, Месяц;

SELECT
      Месяц,
      COUNT(*) AS Количество
FROM (SELECT *, MONTHNAME(date_first) AS Месяц FROM trip) AS trip_month
GROUP BY Месяц
ORDER BY Количество DESC, Месяц;

SELECT
    monthname(date_first)
                      AS Месяц,
    COUNT(999)
                      AS Количество
FROM
    trip
GROUP BY
    1
ORDER BY
    2 DESC,
    1;

-- Вывести сумму суточных (произведение количества дней командировки и размера суточных) для командировок, первый день
-- которых пришелся на февраль или март 2020 года. Информацию отсортировать сначала  в алфавитном порядке по фамилиям сотрудников, а затем по убыванию суммы суточных.

SELECT name, city, date_first, sum(per_diem * DATEDIFF(date_last, date_first) + 1) AS _sum
FROM trip
WHERE MONTH(date_first) = 2 OR MONTH(date_first) = 3
GROUP BY name, city, date_first
ORDER BY name ASC, _sum DESC;

SELECT name, city, date_first, per_diem * (DATEDIFF(date_last, date_first) + 1) AS Сумма
FROM trip
WHERE date_first BETWEEN '2020-02-01' AND '2020-03-31'
      OR date_first LIKE '2020-02-%' OR date_first LIKE '2020-03-%'
      OR MONTHNAME(date_first) in ('February','March')
      OR date_first >='2020-02-01' AND date_first < '2020-04-01'
      OR EXTRACT(YEAR FROM date_first) = 2020 AND EXTRACT(MONTH FROM date_first) IN (2, 3)
      OR (SELECT month(date_first)) BETWEEN 2 AND 3
ORDER BY name, Сумма DESC;

SELECT name, city, date_first,
       (per_diem * (DATEDIFF(date_last, date_first) + 1)) AS Сумма
FROM trip
WHERE MONTH(date_first) = ANY(SELECT MONTH(date_first)
                       FROM trip
                       WHERE MONTH(date_first) IN (2, 3))
ORDER BY name, сумма DESC;

-- Вывести фамилию с инициалами и общую сумму суточных, полученных за все командировки для тех сотрудников,
-- которые были в командировках больше чем 3 раза, в отсортированном по убыванию сумм суточных виде. Только для этого задания изменена строка таблицы trip:

SELECT name, sum(per_diem * (DATEDIFF(date_last, date_first) + 1)) AS Сумма
FROM trip
GROUP BY name
HAVING COUNT(name) > 3
ORDER BY name ASC;

SELECT name,
SUM(((DATEDIFF(date_last, date_first) + 1) * per_diem)) AS Сумма
FROM trip
WHERE name IN(
    SELECT name
    FROM trip
    GROUP BY name
    HAVING count(name) > 3)
GROUP BY name
ORDER BY Сумма DESC

-- SELECT count(name) FROM trip
--вычисляет общее количество записей в trip, а не по каждому человеку.

-- COUNT() считает количество строк, а укажете вы там звездочку- все столбцы, или один конкретный, количество строк не изменится, потому что таблицы прямоугольные (в этом в принципе суть реляционности, насколько я понимаю)

SELECT name, SUM((DATEDIFF(date_last, date_first ) + 1) * per_diem ) AS "Сумма"  FROM trip
GROUP BY name
HAVING name = ANY(SELECT name FROM trip
               GROUP BY name
               HAVING COUNT(name) > 3)

SELECT
	    t.name,
	    SUM((DATEDIFF(t.date_last, t.date_first) + 1) * t.per_diem) AS "Сумма"
FROM
	    trip t
GROUP BY
	    t.name
HAVING
	    t.name IN (
	               SELECT
		                   DISTINCT t2.name
	               FROM
		                   trip t2
	               GROUP BY
		                   t2.name
	               HAVING
		                   COUNT(t2.name) > 3)
ORDER BY
	   2 DESC

SELECT name,
       SUM(per_diem * (DATEDIFF(date_last, date_first) + 1)) as 'Сумма'
FROM trip
WHERE name IN (
          SELECT name
          FROM (
                SELECT name,
                       COUNT(name) as amount_of_trip
                FROM trip
                GROUP BY 1
                HAVING amount_of_trip > 3) as table_1)
GROUP BY 1
ORDER BY 2 DESC;

SELECT
      name,
      SUM(
          (
           datediff(date_last,
                    date_first)
           + 1
          )
           * per_diem
      ) AS Сумма
FROM
        trip
GROUP BY
        name
HAVING
        name IN (
                SELECT
                      name
                FROM
                      trip
                GROUP BY
                      name
                HAVING
                      COUNT(name) > 3
                );
