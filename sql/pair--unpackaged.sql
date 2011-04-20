ALTER EXTENSION pair ADD TYPE pair;
ALTER EXTENSION pair ADD FUNCTION pair(anyelement, text);
ALTER EXTENSION pair ADD FUNCTION pair(text, anyelement);
ALTER EXTENSION pair ADD FUNCTION pair(anyelement, anyelement);
ALTER EXTENSION pair ADD FUNCTION pair(text, text);
ALTER EXTENSION pair ADD OPERATOR ~>(text, anyelement);
ALTER EXTENSION pair ADD OPERATOR ~>(anyelement, text);
ALTER EXTENSION pair ADD OPERATOR ~>(anyelement, anyelement);
ALTER EXTENSION pair ADD OPERATOR ~>(text, text);
