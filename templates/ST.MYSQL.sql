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
-- | SELECT (Групповые функции типа COUNT, SUM и т.д. здесь)
-- | DISTINCT

SELECT
    author AS [author - author],
    COUNT(DISTINCT title)
FROM book
GROUP BY author;
