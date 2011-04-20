\set ECHO 0
BEGIN;
\i sql/pair.sql
\set ECHO all

      SELECT pair('foo', 'bar')
UNION SELECT pair('HEY'::text, 'bar')
UNION SELECT pair('foo'::text, 'woah'::text)
UNION SELECT pair('ick', 'foo'::text)
UNION SELECT pair('foo'::text, 1)
UNION SELECT pair(12.3, 'foo'::text)
UNION SELECT pair(1, 12)
ORDER BY pair;

      SELECT 'foo' ~> 'bar' AS arrowop
UNION SELECT 'HEY'::text ~> 'bar'
UNION SELECT 'foo'::text ~> 'woah'::text
UNION SELECT 'ick' ~> 'foo'::text
UNION SELECT 'foo'::text ~> 1
UNION SELECT 12.3 ~> 'foo'::text
UNION SELECT 1 ~> 12
ORDER BY arrowop;

CREATE TABLE kv (
    pair pair
);

INSERT INTO kv VALUES('foo' ~> 'bar'), (1 ~> 2);
SELECT (pair).k, (pair).v FROM kv ORDER BY (pair).k;

SELECT (pair('foo', 'bar')).k;
SELECT (pair('foo', 'bar')).v;

SELECT ('foo' ~> 'bar').k;
SELECT ('foo' ~> 'bar').v;
ROLLBACK;
