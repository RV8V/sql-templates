\! clear

SELECT ||/27;
       char_length('post'||'gres'),
       position('th' IN ';tank'),
       ASCII('\0'),
       REVERSE(CONCAT('hello', ' world')),
       REPEAT(INITCAP('smth '), 2),
       current_timestamp; -- SELECT NOW();

CREATE TYPE IF NOT EXISTS MOOD AS ENUM('sad', 'ok', 'normal');

CREATE TABLE IF NOT EXISTS person(name text,
                                    current_mood MOOD);
INSERT INTO person VALUES
                                    ('jake', 'normal');
SELECT MAX(current_mood) FROM person;

CREATE TABLE IF NOT EXISTS geometry(id    BIGSERIAL NOT NULL,
                                    _circ CIRCLE,  -- ((3, 4), 6)
                                    _pt   POINT,   -- (1, 2)
                                    _ln   LINE,    -- (2, 4, -1)
                                    _poly POLYGON, -- ((2, 4), (4, 5), (6, 8), (1, 8))
                                          PRIMARY KEY(id));

CREATE TABLE IF NOT EXISTS json_data(id INT PRIMARY KEY,
                                     doc JSON);
INSERT INTO json_data VALUES(NULL, '{
                                        "name":       "bob",
                                        "address":    "local address",
                                        "lane1":      "Jal",
                                        "lane2":      "Tog",
                                        "local-code": "2121"
                                    }');

SELECT doc->>'address'->>'local-code' FROM json_data;
SELECT doc#>>'{address, local-code}' FROM json_data;

CREATE TABLE IF NOT EXISTS _ssl_exm(id INT PRIMARY KEY,
                                    _pay INTEGER[],
                                    _schedule TEXT[][]);

INSERT INTO ssl_exm VALUES
                                    (1, '{10000, 100000, 100000}', '{{"meeting", "lunch"}, {"destination", "home"}}');

SELECT name, array_dims(_schedule) FROM _ssl_exm WHERE _pay[1] <> _pay[2];
UPDATE _ssl_exm SET _pay = array_cat(_pay, ARRAY[200000, 800000]);

EXPLAIN SELECT ARRAY_AGG(name), JSON_AGG(current_mood), JSON_OBJECT_AGG(name, current_mood) FROM person;

CREATE VIEW person_view AS SELECT name, current_mood FROM person;

CREATE INDEX name_index ON person(name);

CREATE OR REPLACE FUNCTION total()
RETURNS INTEGER AS $total$
DECLARE
       total INTEGER;
BEGIN
       SELECT COUNT(*) INTO total FROM person;
       return total;
END
$total$ language plpgsql;

CREATE OR REPLACE FUNCTION PUBLIC.total()
RETURNS INTEGER AS $$
BEGIN return (SELECT COUNT(*) FROM person);
END $$ LANGUAGE plpgsql IMMUTABLE LEAKRPOOF;
COMMENT ON FUNCTION PUBLIC.total() IS 'Count total value from PUBLIC.person table';

CREATE OR REPLACE FUNCTION PUBLIC.inc(IN value INTEGER DEFAULT 1)
RETURNS INTEGER AS $$
BEGIN return value + 1;
END $$ LANGUAGE plpgsql VOLATILE LEAKRPOOF;
COMMENT ON FUNCTION PUBLIC.inc(IN INTEGER) IS 'Increment a particular integer value by n';

CREATE OR REPLACE FUNCTION _sum(IN value1 INTEGER, IN value2 INTEGER)
RETURNS INTEGER AS $$
BEGIN return value1 + value2;
END $$ LANGUAGE plpgsql IMMUTABLE LEAKRPOOF;
COMMENT ON FUNCTION PUBLIC._sum(IN INTEGER, IN INTEGER) IS 'Add to values';

CREATE FUNCTION min_max(IN a INTEGER, IN b INTEGER, IN c INTEGER, OUT min INTEGER, OUT max INTEGER)
AS $$
BEGIN max = GREATEST(a, b, c);
      min = LEAST(a, b, c);
END $$ LANGUAGE plpgsql IMMUTABLE NOT LEAKRPOOF;
COMMENT ON FUNCTION PUBLIC.min_max(IN INTEGER, IN INTEGER, IN INTEGER, OUT INTEGER, OUT INTEGER) IS 'return greatest and least of 3 paramaters';

CREATE FUNCTION sq(INOUT value NUMERIC)
AS $$
BEGIN value = value * value;
END $$ LANGUAGE plpgsql VOLATILE LEAKRPOOF;
COMMENT ON FUNCTION PUBLIC.sq(INOUT NUMERIC) IS 'storage procedure multiply input value';

CREATE FUNCTION PUBLIC.get_emp(IN age_in INTEGER, IN location VARCHAR)
RETURNS TABLE(
    identity INTEGER,
    name TEXT) AS $info$
BEGIN return query SELECT id, name FROM company WHERE age = age_in AND address = location;
END $info$ LANGUAGE plpgsql IMMUTABLE NOT LEAKRPOOF;
COMMENT ON FUNCTION PUBLIC.sq(IN INTEGER, IN VARCHAR) IS 'returns new table';

do $$
DECLARE num1 INTEGER = 50;
        num2 INTEGER = 60;
BEGIN
       IF num1 > num2 THEN RAISE NOTICE 'num1 is greater than num2';
       ELSIF num1 < num2 THEN RAISE NOTICE 'num1 is less than num2';
       ELSE RAISE NOTICE 'num1 is equal to num2'; END IF;
END $$;

CREATE OR REPLACE FUNCTION PUBLIC.fibonaci(iN n INTEGER)
RETURNS INTEGER AS $$
DECLARE counter INTEGER = 0;
        i INTEGER = 0;
        j INTEGER = 1;
BEGIN
     IF (n < 1) THEN return 0;
     END IF;

     LOOP EXIT WHEN counter = n;
     counter = counter + 1;
     SELECT j, i + j INTO i, j;
     END LOOP;
     return i;
END $$ LANGUAGE plpgsql VOLATILE;
COMMENT ON FUNCTION PUBLIC.fibonaci(IN INTEGER) IS 'returns fibonaci value';
ALTER FUNCTION PUBLIC.fibonaci(INTEGER) OWNER TO postgres;

CREATE FUNCTION PUBLIC._loop(INOUT n INTEGER)
RETURNS INTEGER AS $$
DECLARE counter INTEGER = 0;
BEGIN LOOP EXIT WHEN counter = n;
      counter = counter + 1;
      RAISE NOTICE 'hello, world';
      END LOOP;
      return n;
END $$ LANGUAGE plpgsql;
COMMENT ON FUNCTION PUBLIC._loop(INOUT INTEGER) IS 'returns input value';

CREATE OR REPLACE FUNCTION PUBLIC.while_fib(IN n INTEGER)
RETURNS INTEGER AS $PUBLIC.while_fib$
DECLARE counter INTEGER = 0;
        i INTEGER = 0;
        j INTEGER = 1;
BEGIN
        IF(n < 1) THEN return 0;
        END IF;

        while counter < n LOOP
        counter = counter + 1;
        SELECT j, i + 1 INTO i, j;
        END LOOP
        return i;
END $PUBLIC.while_fib$ LANGUAGE plpgsql IMMUTABLE LEAKRPOOF;
COMMENT ON FUNCTION PUBLIC.while_fib(IN INTEGER) IS 'returns fibonaci value';
ALTER FUNCTION PUBLIC.while_fib(INTEGER) OWNER TO postgres;

CREATE OR REPLACE FUNCTION PUBLIC.fetcher(IN n INTEGER)
RETURNS VOID AS $$
DECLARE _table RECORD;
BEGIN for _table IN SELECT name FROM person ORDER BY name LIMIT n
      LOOP RAISE NOTICE '%', _table.name;
      END LOOP;
END $$ LANGUAGE plpgsql;
COMMENT ON FUNCTION PUBLIC.fetcher(IN INTEGER) IS 'returns records from table person';

SELECT PUBLIC.total(), PUBLIC.inc(), PUBLIC._sum(), PUBLIC.fibonaci(2), PUBLIC.while_fib(3);

BEGIN;
CREATE TABLE IF NOT EXISTS test(n INTEGER);
INSERT INTO test VALUES(1);
END transaction;

BEGIN;
DELETE FROM test;
DROP TABLE IF EXISTS test;
ROLLBACK;

BEGIN;
CREATE TABLE IF NOT EXISTS my_table(n INTEGER);
INSERT INTO my_table VALUES(1);
SAVEPOINT my_savepoint;
INSERT INTO my_table VALUES(2);
INSERT INTO my_table VALUES(3);
SELECT * from my_table;
ROLLBACK TO my_savepoint;
SELECT * from my_table;
COMMIT;

BEGIN TRANSACTION WRITE ONLY ISOLATION LEVEL SERIALIZABLE;
CREATE TABLE IF NOT EXISTS _test(n INTEGER);
SELECT * FROM does_not_exists_table;
SELECT "hello, world";
ROLLBACK TRANSACTION;

BEGIN TRANSACTION READ ONLY ISOLATION LEVEL READ COMMITTED;
CREATE TABLE IF NOT EXISTS _test(n INTEGER);
INSERT INTO _test VALUES(1);
SAVEPOINT my_point;
INSERT INTO my_table VALUES(2);
INSERT INTO my_table VALUES(3);
INSERT INTO does_not_exists_table VALUES(1);
INSERT INTO my_table VALUES(4);
ROLLBACK TO my_point;
SELECT * FROM my_table;
COMMIT TRANSACTION;

CREATE TABLE IF NOT EXISTS _user
(
    "name" TEXT
);

CREATE TABLE IF NOT EXISTS _log
(
    "_text" TEXT,
    "added" TIMESTAMP WITHOUT TIME ZONE
);

CREATE OR REPLACE FUNCTION PUBLIC.add_to_log() RETURNS TRIGGER AS $PUBLIC.add_to_log$
DECLARE
    mstr   VARCHAR(30);
    astr   VARCHAR(100);
    retstr VARCHAR(254);
BEGIN
    IF    TG_OP = 'INSERT' THEN
        astr := NEW.name;
        mstr := 'Add new user ';
        retstr := mstr || astr;
        INSERT INTO _log(_text, added) VALUES(retstr, NOW());
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        astr := NEW.name;
        mstr := 'Update user ';
        retstr := mstr || astr;
        INSERT INTO _log(_text, added) VALUES(retstr, NOW());
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        astr = OLD.name;
        mstr := 'Remove user ';
        retstr := mstr || astr;
        INSERT INTO _log(_text, added) VALUES(retstr, NOW());
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t_user AFTER INSERT OR UPDATE OR DELETE ON _user FOR EACH ROW EXECUTE PROCEDURE add_to_log();
