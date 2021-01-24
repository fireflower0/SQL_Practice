# SQL_Practice

Create role and db.

```
$ psql postgres
postgres=# CREATE ROLE fireflower0 LOGIN CREATEDB PASSWORD 'xxxxxxxxxx';
$ createdb test -U fireflower0 -W
```
