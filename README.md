pair 0.1.8
==========

[![PGXN version](https://badge.fury.io/pg/pair.svg)](https://badge.fury.io/pg/pair)
[![Build Status](https://github.com/theory/kv-pair/workflows/CI/badge.svg)](https://github.com/theory/kv-pair/actions)

This library contains a single PostgreSQL extension, a key/value pair data
type called `pair`, along with a convenience function for constructing
key/value pairs. It's just a simple thing, really: a two-value composite type
that can store any type of value in its slots, which are named `k` and `v`.

The `pair` data type was created as an inspiration, as documented in
[this blog post](https://justatheory.com/2010/08/postgres-key-value-pairs/).
Give it a read if you're interested in the context for its creation.

To build it, just do this:

```sh
make
make installcheck
make install
```

If you encounter an error such as:

```
"Makefile", line 8: Need an operator
```

You need to use GNU make, which may well be installed on your system as
`gmake`:

```sh
gmake
gmake install
gmake installcheck
```

If you encounter an error such as:

```
make: pg_config: Command not found
```

Be sure that you have `pg_config` installed and in your path. If you used a
package management system such as RPM to install PostgreSQL, be sure that the
`-devel` package is also installed. If necessary tell the build process where
to find it:

```sh
env PG_CONFIG=/path/to/pg_config make && make installcheck && make install
```

If you encounter an error such as:

```
ERROR:  must be owner of database regression
```

You need to run the test suite using a super user, such as the default
"postgres" super user:

```sh
make installcheck PGUSER=postgres
```

To install the extension in a custom prefix on PostgreSQL 18 or later, pass
the `prefix` argument to `install` (but no other `make` targets):

    make install prefix=/usr/local/extras

Then ensure that the prefix is included in the following [`postgresql.conf`
parameters]:

```ini
extension_control_path = '/usr/local/extras/postgresql/share:$system'
dynamic_library_path   = '/usr/local/extras/postgresql/lib:$libdir'
```

Once pair is installed, you can add it to a database simply by connecting as
a super user and running:

```sql
CREATE EXTENSION pair;
```

If you want to install pair and all of its supporting objects into a specific
schema, use the `SCHEMA` clause to specify the schema, like so:

```sql
CREATE EXTENSION pair SCHEMA extensions;
```

If you've upgraded your cluster from PostgreSQL 9.0 or earlier and already had
pair installed, you can upgrade it to a properly packaged extension with:

```sql
CREATE EXTENSION pair FROM unpackaged;
```

Dependencies
------------
The `pair` data type has no dependencies other than PostgreSQL.

Copyright and License
---------------------

Copyright (c) 2010-2025 David E. Wheeler.

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

