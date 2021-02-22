# SQL_Practice

Use PostgreSQL

Create role and db.

```
$ psql postgres
postgres=# CREATE ROLE fireflower0 LOGIN CREATEDB PASSWORD 'xxxxxxxxxx';
$ createdb test -U fireflower0 -W
```

```
$ psql --version                         
psql (PostgreSQL) 13.1
```
