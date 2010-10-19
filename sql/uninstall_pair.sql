-- Adjust this setting to control where the objects get created.
SET search_path = public;

SET client_min_messages = warning;

BEGIN;

DROP OPERATOR ~> (text, text);
DROP OPERATOR ~> (anyelement, anyelement);
DROP OPERATOR ~> (anyelement, text);
DROP OPERATOR ~> (text, anyelement);

DROP FUNCTION pair(text, text);
DROP FUNCTION pair(anyelement, anyelement);
DROP FUNCTION pair(text, anyelement);
DROP FUNCTION pair(anyelement, text);

DROP TYPE pair CASCADE;

COMMIT;
