-- book – связанной или подчиненной. (╯°益°)╯彡┻━┻
-- составление ER-модели (схемы данных) должно основываться на описании конкретной предметной области, чем адекватнее Вы опишите предметную область, тем больше Ваша модель будет подходить для тех бизнес-процессов, которые должны быть автоматизированы с помощью СУБД (как пример).
-- Может - неможет, но, по-моему, не все СУБД поддерживают такой тип данных. В MS SQL Server, как минимум, до 2008  - точно не было типов данных UNSIGNED. UNSIGNED - не является стандартом SQL, это расширение языка добавленное некоторыми производителями СУБД, и, по мнению многих экспертов, бессмысленное. Скорее маркетинг, чем реальная необходимость.
-- иногда лучше опираться на логику и здравый смысл, нежели на различные системы стандартизации. Зачем резервировать отрицательные значения, если они не используются? )

-- | каждый внешний ключ должен иметь такой же тип данных, как связанное поле главной таблицы (в наших примерах это INT);
-- | необходимо указать главную для нее таблицу и столбец, по которому осуществляется связь:

DROP TABLE IF EXISTS author;
DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS genre;

CREATE TABLE IF NOT EXISTS book(
      book_id   INT PRIMARY KEY AUTO_INCREMENT,
      title     VARCHAR(50),
      author_id INT,
      price     DECIMAL(8,2),
      amount    INT,
      genre_id  INT,
      FOREIGN KEY(author_id) REFERENCES author (author_id) ON DElETE CASCADE,
      FOREIGN KEY(genre_id) REFERENCES genre (genre_id) ON DElETE CASCADE
);
CREATE TABLE IF NOT EXISTS genre(
      genre_id   INT PRIMARY KEY AUTO_INCREMENT,
      name_genre VARCHAR(30),
      FOREIGN KEY(genre_id) REFERENCES book(genre_id) ON DElETE CASCADE -- ?
);

-- CASCADE: автоматически удаляет строки из зависимой таблицы при удалении  связанных строк в главной таблице.
-- SET NULL: при удалении  связанной строки из главной таблицы устанавливает для столбца внешнего ключа значение NULL. (В этом случае столбец внешнего ключа должен поддерживать установку NULL).
-- SET DEFAULT похоже на SET NULL за тем исключением, что значение  внешнего ключа устанавливается не в NULL, а в значение по умолчанию для данного столбца.
-- RESTRICT: отклоняет удаление строк в главной таблице при наличии связанных строк в зависимой таблице.

-- Операция соединения JOIN предназначена для обеспечения выборки данных из двух таблиц и включения этих данных в один результирующий набор. При необходимости соединения не двух, а нескольких таблиц, операция соединения применяется несколько раз (последовательно).

-- каждая строка одной таблицы сопоставляется с каждой строкой второй таблицы;
-- для полученной «соединённой» строки проверяется условие соединения;
-- если условие истинно, в таблицу результата добавляется соответствующая «соединённая» строка;

SELECT title, name_author
FROM
    author INNER JOIN book
    ON author.author_id = book.author_id;

SELECT title, name_genre, price
FROM book
     INNER JOIN genre ON genre.genre_id = book.genre_id
WHERE book.amount > 8
ORDER BY price DESC;

SELECT title, name_genre, price
FROM
    author INNER JOIN genre USING(genre_id)
WHERE book.amount > 8
ORDER BY price DESC;

SELECT title, name_genre, price
FROM book AS b, (SELECT * FROM genre) AS g
WHERE b.genre_id = g.genre_id AND b.amount > 8;

-- соединение главной таблицы author и зависимой таблицы book

-- используется вложенный запрос (который, если возможно лучше не использовать, поскольку происходит двойное обращение к базе). Дальше отобранные записи таблицы genre связываются с записями таблицы book внешним соединением CROSS JOIN (получается количество записей, равное произведению количества записей в каждой таблице). Затем  в WHERE  отбираются нужные записи из соединенного множества - для этого просматриваются все соединенные записи и проверяется выражение - это достаточно медленная операция.
-- При использовании INNER JOIN сразу отбираются записи, количество которых равно количеству строк в book (причем очень эффективно, поскольку это реляционная операция). И в этих записях уже проверяется условие отбора.

-- ! не указан атрибут (поле), по которому происходит соединение таблиц. Поэтому получилось не внутреннее соединение, а декартово произведение. INNER JOIN genre g ON b.genre_id = g.genre_id

-- | в результат включается внутреннее соединение (INNER JOIN) первой и второй таблицы в соответствии с условием;
-- | затем в результат добавляются те записи первой таблицы, которые не вошли во внутреннее соединение на шаге 1, для таких записей соответствующие поля второй таблицы заполняются значениями NULL.

-- Вывести название всех книг каждого автора, если книг некоторых авторов в данный момент нет на складе – вместо названия книги указать Null.

SELECT name_author, title FROM author LEFT JOIN book USING(author_id) ORDER BY name_author;

-- Вывести все жанры, которые не представлены в книгах на складе.

SELECT name_genre FROM genre LEFT JOIN book USING(genre_id) WHERE book.title IS NULL;
SELECT name_genre FROM genre WHERE NOT EXISTS(
                                              SELECT * FROM book WHERE book.genre_id = genre.genre_id);
SELECT name_genre
FROM genre LEFT JOIN book
ON genre.genre_id = book.genre_id
WHERE genre.genre_id NOT IN (SELECT DISTINCT genre_id from book);

-- каждому автору из таблицы author поставит в соответствие все возможные жанры из таблицы genre:

SELECT name_author, name_genre FROM author, genre;

-- Необходимо в каждом городе провести выставку книг каждого автора в течение 2020 года. Дату проведения выставки выбрать случайным образом. Создать запрос, который выведет город, автора и дату проведения выставки. Последний столбец назвать Дата. Информацию вывести, отсортировав сначала в алфавитном порядке по названиям городов, а потом по убыванию дат проведения выставок.

-- SET @seed = 42; -- инициализируем переменную seed
SELECT name_city, name_author, DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND(42) * 365)) AS Data -- -- применяем: @seed вместо 42
FROM city, author
ORDER BY name_city, Data DESC;

SELECT ...
FROM first_table
     INNER JOIN second_table USING(first_id)
           INNER JOIN third_table USING(second_id)
               ...;

SELECT title, name_author, name_genre, price, amount
FROM
    author INNER JOIN book USING(author_id)
       INNER JOIN genre USING(genre_id)
WHERE price = (SELECT price FROM book WHERE price BETWEEN 500 AND 700;)

-- Вывести информацию о книгах (жанр, книга, автор), относящихся к жанру, включающему слово «роман» в отсортированном по названиям книг виде.

SELECT title, name_genre, name_author
FROM
    author INNER JOIN book USING(author_id)
        INNER JOIN genre USING(genre_id)
WHERE name_genre IN(SELECT name_genre FROM genre WHERE name_genre = 'roman');

SELECT title, name_author, name_genre, price, amount
FROM
    author INNER JOIN book
    ON author.author_id = book.author_id
        INNER JOIN genre
        ON genre.genre_id = book.genre_id
WHERE price BETWEEN 500 AND 700;

SELECT title, name_genre, name_author
FROM author
     INNER JOIN book USING(author_id)
     INNER JOIN genre USING(genre_id)
WHERE LOWER(name_genre) RLIKE '[[:<:]]roman[[:>:]]'
ORDER BY title;

-- Вывести количество различных книг каждого автора. Информацию отсортировать в алфавитном порядке по фамилиям  авторов.

SELECT name_author, count(title) AS amount
FROM author
     INNER JOIN book USING(author_id)
GROUP BY name_author
ORDER BY name_author;

-- Посчитать количество экземпляров  книг каждого автора на складе.  Вывести тех авторов,  количество книг которых меньше 10, в отсортированном по возрастанию количества виде. Последний столбец назвать Количество.

SELECT name_author, COALESCE(SUM(amount), NULL) AS general_amount
FROM author
     LEFT JOIN book USING(author_id)
GROUP BY name_author
HAVING SUM(amount) < 10
       AND COUNT(title) = 0
       OR SUM(IF(amount IS NULL, 0, amount)) < 10
ORDER BY Количество;

SELECT name_author, COALESCE(SUM(amount), NULL) AS general_amount
FROM author
     LEFT JOIN (SELECT author_id, SUM(amount) AS amount
                FROM book
                GROUP BY author_id) book
     USING(author_id)
WHERE COALESCE(amount, 0) < 10
ORDER BY Количество;

-- COUNT - считает количество строк, а SUM сумму ячеек. Поэтому для подсчета общего количества книг COUNT не подходит.

-- В запросах, построенных на нескольких таблицах, можно использовать вложенные запросы.
-- Вложенный запрос может быть включен:
--> после ключевого слова SELECT,
--> после FROM и в условие отбора
--> после WHERE (HAVING).

-- Вывести авторов, общее количество книг которых на складе максимально.

SELECT MAX(sum_amount) AS max_sum_amount
FROM (SELECT author_id, SUM(amount) AS sum_amount
      FROM book GROUP BY author_id) AS query_in;

SELECT name_author, SUM(amount) AS general_amount
FROM author INNER JOIN book USING(author_id)
GROUP BY name_author
HAVING SUM(amount) =
      (SELECT MAX(sum_amount) AS max_sum_amount
       FROM (SELECT author_id, SUM(amount) AS sum_amount
             FROM book GROUP BY author_id) AS query_in
);

-- Вывести в алфавитном порядке всех авторов, которые пишут только в одном жанре. Поскольку у нас в таблицах так занесены данные, что у каждого автора книги только в одном жанре,  для этого запроса внесем изменения в таблицу book. Пусть у нас  книга Есенина «Черный человек» относится к жанру «Роман», а книга Булгакова «Белая гвардия» к «Приключениям» (эти изменения в таблицы уже внесены).
SELECT author_id
FROM book
     INNER JOIN author
     USING(author_id)
GROUP BY author_id
HAVING COUNT(distinct genre_id) = 1;

-- COUNT(столбец)          - количество значений в столбце
-- COUNT(DISTINCT столбец) - количество уникальных значений в столбце

SELECT name_author FROM author
WHERE author_id = ANY(SELECT author_id FROM book
                      GROUP BY author1
                      HAVING COUNT(DISTINCT genre_id) = 1);

SELECT name_author FROM (SELECT DISTINCT author_id, genre_id FROM book) tmp
       INNER JOIN author ON author.author_id = tmp.author_id
GROUP BY name_author
HAVING COUNT(1) = 1;

SELECT name_author
FROM author INNER JOIN (SELECT author_id, COUNT(DISTINCT genre_id) AS genre_amount
                        FROM book
                        GROUP BY author_id) AS query_in
            ON author.author_id = query_in.author_id
WHERE query_in.genre_amount = 1;

SELECT name_author
FROM author JOIN (SELECT author_id, COUNT(DISTINCT(genre_id)) AS genre_cnt
     FROM book
     GROUP BY author_id
     HAVING genre_cnt = 1) AS Q_in USING(author_id)
