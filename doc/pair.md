pair 0.1.2
==========

Synopsis
--------

    % CREATE EXTENSION pair;
    CREATE EXTENSION

    % SELECT pair('foo', 'bar');
        pair
    ------------
     (foo,bar)

    % SELECT 'foo' ~> 'bar';
        pair
    ------------
     (foo,bar)

Description
-----------

This library contains a single PostgreSQL extension, a key/value pair data
type called `pair`, along with a convenience function for constructing
key/value pairs. It's just a simple thing, really: a two-value composite type
that can store any type of value in its slots, which are named `k` and `v`.

So what's it good for? Well, say you have a custom function to which you'd like
to be able to pass any number of key/value pairs. You could use
[hstore](https://www.postgresql.org/docs/current/static/hstore.html) of course,
but maybe it's overkill, or you need to guarantee the order in which the pairs
are passed. [JSON](https://www.postgresql.org/docs/current/datatype-json.html)
can also do the trick, but then what's to stop someone from passing a JSON
object rather than an array of arrays. If all you need is pairs, this extension
is for you.

The `pair` data type was created as an inspiration, as documented in
[this blog post](https://justatheory.com/2010/08/postgres-key-value-pairs/).
Give it a read if you're interested in the context for its creation.

Usage
-----
There are two ways to construct key/value pairs: Via the `pair()` function:

    % SELECT pair('foo', 'bar');
        pair    
    ------------
     (foo,bar)

Or by using the `~>` operator:

    % SELECT 'foo' ~> 'bar';
        pair    
    ------------
     (foo,bar)

To access the values, just use the `k` and `v` column names:

    SELECT ('foo' ~> 'bar').k;
      k  
    -----
     foo
    (1 row)

    SELECT ('foo' ~> 'bar').v;
      v  
    -----
     bar

Kind of ugly, huh? Well pairs aren't very useful on their own. Where they
really come into their own is when used as the last parameter to a variadic
function.

For example, say you wanted a function to store any number of key/value pairs
in a table. Here's what it might look like:

    CREATE OR REPLACE FUNCTION store(
        params variadic pair[]
    ) RETURNS VOID LANGUAGE plpgsql AS $$
    DECLARE
        param pair;
    BEGIN
        FOR param IN SELECT * FROM unnest(params) LOOP
            UPDATE kvstore
               SET value = param.v,
             WHERE key = param.k;
            CONTINUE WHEN FOUND;
            INSERT INTO kvstore (key, value) VALUES (param.k, param.v);
        END LOOP;
    END;
    $$;

And to use it, pass in any number of pairs you like:

    SELECT store( 'foo' ~> 'bar', 'baz' ~> 1 );

Support
-------

This library is stored in an open
[GitHub repository](https://github.com/theory/kv-pair). Feel free to fork and
contribute! Please file bug reports via
[GitHub Issues](https://github.com/theory/kv-pair/issues/).

Author
------

[David E. Wheeler](https://justatheory.com/)

Copyright and License
---------------------

Copyright (c) 2010-2020 David E. Wheeler.

This module is free software; you can redistribute it and/or modify it under
the [PostgreSQL License](https://www.opensource.org/licenses/postgresql).

Permission to use, copy, modify, and distribute this software and its
documentation for any purpose, without fee, and without a written agreement is
hereby granted, provided that the above copyright notice and this paragraph
and the following two paragraphs appear in all copies.

In no event shall David E. Wheeler be liable to any party for direct,
indirect, special, incidental, or consequential damages, including lost
profits, arising out of the use of this software and its documentation, even
if David E. Wheeler has been advised of the possibility of such damage.

David E. Wheeler specifically disclaims any warranties, including, but not
limited to, the implied warranties of merchantability and fitness for a
particular purpose. The software provided hereunder is on an "as is" basis,
and David E. Wheeler has no obligations to provide maintenance, support,
updates, enhancements, or modifications.
