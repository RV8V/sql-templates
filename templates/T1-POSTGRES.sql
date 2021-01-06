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

SELECT total(), inc(), _sum();
