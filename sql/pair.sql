-- Adjust this setting to control where the objects get created.
SET search_path = @extschema@;

SET client_min_messages = warning;

BEGIN;

CREATE TYPE pair AS ( k text, v text );

CREATE OR REPLACE FUNCTION pair(anyelement, text)
RETURNS pair LANGUAGE SQL AS 'SELECT ROW($1, $2)::pair';

CREATE OR REPLACE FUNCTION pair(text, anyelement)
RETURNS pair LANGUAGE SQL AS 'SELECT ROW($1, $2)::pair';

CREATE OR REPLACE FUNCTION pair(anyelement, anyelement)
RETURNS pair LANGUAGE SQL AS 'SELECT ROW($1, $2)::pair';

CREATE OR REPLACE FUNCTION pair(text, text)
RETURNS pair LANGUAGE SQL AS 'SELECT ROW($1, $2)::pair;';

CREATE OPERATOR ~> (
	LEFTARG   = text,
	RIGHTARG  = anyelement,
	PROCEDURE = pair
);

CREATE OPERATOR ~> (
	LEFTARG   = anyelement,
	RIGHTARG  = text,
	PROCEDURE = pair
);

CREATE OPERATOR ~> (
	LEFTARG   = anyelement,
	RIGHTARG  = anyelement,
	PROCEDURE = pair
);

CREATE OPERATOR ~> (
	LEFTARG   = text,
	RIGHTARG  = text,
	PROCEDURE = pair
);

COMMIT;
