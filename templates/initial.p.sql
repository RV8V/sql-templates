CREATE DATABASE IF NOT EXISTS shop;

CREATE TABLE IF NOT EXISTS customer(
    id           SERIAL PRIMARY KEY,
    name         VARCHAR(255),
    phone_number VARCHAR(30),
    email        VARCHAR(25)
);

CREATE TABLE IF NOT EXISTS product(
    id           SERIAL PRIMARY KEY,
    name         VARCHAR(255),
    description  TEXT,
    price        INTEGER
);

CREATE TABLE IF NOT EXISTS product_photo(
    id           SERIAL PRIMARY KEY,
    url          VARCHAR(255),
    product_id   INTEGER REFERENCES product(id)
);

CREATE TABLE IF NOT EXISTS cart(
    id           SERIAL PRIMARY KEY,
    customer_id  INTEGER REFERENCES customer(id)
);

CREATE TABLE IF NOT EXISTS cart_product(
    id           SERIAL PRIMARY KEY,
    product_id   INTEGER REFERENCES product(id),
    cart_id      INTEGER REFERENCES cart(id)
);

INSERT INTO customer(name, phone_number, email) VALUES
    ('Jake', '0823', 'jake@jake.com'),
    ('Bob',  '0124', 'bob@bob.com'),
    ('Lod',  '0443', 'lod@lod.com');

SELECT * FROM customer;

INSERT INTO product(name, description, price) VALUES
    ('phone',  'new phone',  2000),
    ('tv',     'new tv',     3000),
    ('fridge', 'new fridge', 4000),
    ('car',    'new car',    5000);

SELECT * FROM product;

INSERT INTO product_photo(url, product_id) VALUES
    ('phone photo',  1),
    ('tv photo',     2),
    ('fridge photo', 3),
    ('car photo',    4);

SELECT * FROM product_photo;
SELECT pp.*, p.name FROM product_photo pp LEFT JOIN product p ON p.id = pp.product_id;
ALTER TABLE product_photo DROP CONSTRAINT product_photo_product_id_fkey;
INSERT INTO product_photo(url, product_id) VALUES('void 2', 20);
SELECT pp.* FROM product_photo pp;
DELETE FROM product_photo WHERE id = 2;
UPDATE product_photo SET url = 'new phone image' WHERE id = 1;
SELECT c.* FROM cart c;
SELECT c.* FROM customer c;
INSERT INTO cart(customer_id) VALUES(1);
INSERT INTO cart_product(cart_id, product_id) VALUES(1, 1), (1, 2);
SELECT cp.* FROM cart_product cp;
SELECT c.* FROM customer c;
SELECT c.name, cart.id as cart_id, cp.product_id, COALESCE(SUM(product.price), 0) AS orders_sum FROM customer c
    LEFT OUTER JOIN cart ON cart.customer_id = c.id
    LEFT OUTER JOIN cart_product cp ON cp.cart_id = cart.id
    LEFT OUTER JOIN product ON product.id = cp.product_id
    GROUP BY c.name
    HAVING SUM(p.price) > 0
    ORDER BY orders_sum DESC;
SELECT * FROM customer ORDER BY name using ~<~ LIMIT 1 OFFSET 1;

-- ==============================        ==============================
SELECT FROM MOCK_DATA;
SELECT * FROM mock_data WHERE gender = 'Female' OFFSET 5 LIMIT 5;
SELECT * FROM mock_data WHERE gender = 'Female' OFFSET 5 FETCH FIRST 5 ROW ONLY;
SELECT * FROM mock_data WHERE date_of_birth BETWEEN '2004-05-04' AND '2008-09-02';
SELECT gender, COUNT(*) FROM mock_data GROUP BY gender;
SELECT first_name, COUNT(*) FROM mock_data GROUP BY first_name HAVING COUNT(*) > 2;
SELECT ROUND(AVG(price)) FROM holiday;
SELECT destination_country, destination_city, MAX(price) FROM holiday GROUP BY destination_city, destination_country;
SELECT destination_city, COALESCE(MAX(price), 0) AS price FROM holiday GROUP BY destination_city ORDER BY price DESC;
SELECT 100 + 2;
SELECT 100 - 2;
SELECT 100 * 2;
SELECT 100 / 2;
SELECT 100 % 2;
SELECT 5!;
SELECT NOW()::DATE;
SELECT NOW()::TIME;
SELECT NOW() - INTERVAL '1 YEAR';
SELECT EXTRACT(YEAR FROM NOW());
SELECT EXTRACT(MONTH FROM NOW());
SELECT EXTRACT(DAY FROM NOW());
SELECT EXTRACT(DOW FROM NOW());
SELECT firstname, AGE(NOW() - date_of_birth) AS age from users;
SELECT email, COUNT(*) FROM mock_data GROUP BY email HAVING COUNT(*) > 1;
INSERT INTO mock_data(id, first_name, email, date_of_birth) VALUES(2, 'jake', 'jake@.com', DATE '2001-09-02') ON CONFLICT(id) DO NOTHING;
INSERT INTO mock_data(id, first_name, email, date_of_birth) VALUES(2, 'jake', 'jake@.com', DATE '2001-09-02') ON CONFLICT(id) DO UPDATE SET email = EXCLUDED.email;
-- UPSERT = UPDATE AND INSERT
SELECT * FROM mock_data INNER JOIN bicycle ON mock_data.bicycle_id = bicycle.id;
SELECT * FROM mock_data LEFT OUTER JOIN bicycle ON mock_data.bicycle_id = bicycle.id WHERE bicycle_id IS NOT NULL;
SELECT * FROM mock_data RIGHT OUTER JOIN bicycle ON mock_data.bicycle_id = bicycle.id WHERE bicycle_id IS NOT NULL;
SELECT * FROM mock_data FULL OUTER JOIN bicycle ON mock_data.bicycle_id = bicycle.id WHERE bicycle_id IS NOT NULL;
\copy (SELECT * FROM mock_data LEFT OUTER JOIN bicycle ON mock_data.bicycle_id = bicycle.id WHERE bicycle_id IS NOT NULL) /home/ruslan/Documents/projects/sql/templates/DUMP delimiter ', ' CSV HEADER;
