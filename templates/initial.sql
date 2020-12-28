CREATE DATABASE IF NOT EXISTS shop;
-- DROP DATABASE IF EXISTS shop;

CREATE TABLE IF NOT EXISTS users(
    id INT
);
-- DROP TABLE IF EXISTS users;

CREATE TABLE IF NOT EXISTS people(
    id    INT NOT NULL AUTO_INCREMENT,
    name  VARCHAR(20) NOT NULL,
    email VARCHAR(20) NOT NULL,
    bio   TEXT NOT NULL,
    birth DATE,
    PRIMARY KEY(id)
);

-- ALTER TABLE people ADD COLUMN IF NOT EXISTS password VARCHAR(32);
-- ALTER TABLE users DROP COLUMN IF EXISTS password;

INSERT INTO people(name, bio, birth, email) VALUES('Jake', 'Bio here', '2004-05-06', 'jake@jake.com');
INSERT INTO people(name, email, birth) VALUES('Bob', 'bob@bob.com', '2003-05-09');

ALTER TABLE people CHANGE COLUMN birth birth DATE NOt NULL;

INSERT INTO people(birth, name) VALUES
    ('2005-09-09', 'Name first one'),
    ('2004-07-07', 'Name second');

UPDATE people SET name = 'new name', email = 'new email' WHERE id > 5;
UPDATE shop.people SET bio = 'new bio for user' WHERE name = 'name' AND id = 3;

CREATE TABLE test(
    id INT NOT NULL,
    some_text TEXT,
    some_field VARCHAR(255),
    PRIMARY KEY(id)
);

INSERT INTO test(id, some_text, some_field) VALUES
    (1, 'some text', 'some field'),
    (2, 'test',      'field'),
    (3, 'some',      'some'),
    (4, 'some txt',  'some field');

DELETE FROM people.test WHERE people.id > 0 and people.name = 'name';
TRUNCATE shop.test;

UPDATE people SET email = 'new email' WHERE people.id = 0;
DROP TABLE IF EXISTS shop.test;

SELECT name, email FROM people WHERE id >= 6 AND id <= 32 OR id <> 0 AND id <> 3 AND name = 'new name' OR bio IS NULL;
SELECT DISTINCT name FROM people ORDER BY DESC id LIMIT 2, 3;
SELECT DISTINCT name FROM people WHERE name = 'new name' ORDER BY ASC id LIMIT 3 OFFSET 2;
SELECT name, email, bio FROM people WHERE id > 0 AND id < 9;
SELECT email FROM people WHERE id BETWEEN 0 AND 9 AND id <> 4 ORDER BY id DESC LIMIT 4;
SELECT bio FROM people WHERE id IN(1, 4, 6);
SELECT * from people WHERE name LIKE 'n%';

CREATE INDEX IF NOT EXISTS nI ON people(people.name);
DROP INDEX IF EXISTS nI ON people;

CREATE TABLE IF NOT EXISTS shop(
    id    INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255),
    price INT,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS orders(
    id           INT NOT NULL AUTO_INCREMENT,
    order_number INT,
    shop_id      INT,
    person_id    INT,
    data_time    DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id),
    FOREIGN KEY(orders.shop_id)   REFERENCES shop(id),
    FOREIGN KEY(orders.person_id) REFERENCES people(id)
);
