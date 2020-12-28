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
