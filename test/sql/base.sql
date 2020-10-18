BEGIN;
CREATE EXTENSION pair;

SELECT pair('foo', 'bar')
     , pair('HEY'::text, 'bar')
     , pair('foo'::text, 'woah'::text)
     , pair('ick', 'foo'::text)
     , pair('foo'::text, 1)
     , pair(12.3, 'foo'::text)
     , pair(1, 12)
;

SELECT 'foo' ~> 'bar' AS arrowop
     , 'HEY'::text ~> 'bar'
     , 'foo'::text ~> 'woah'::text
     , 'ick' ~> 'foo'::text
     , 'foo'::text ~> 1
     , 12.3 ~> 'foo'::text
     , 1 ~> 12
;

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
