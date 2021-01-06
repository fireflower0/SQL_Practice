CREATE TABLE SomeTable (
  p_key CHAR(1) PRIMARY KEY,
  col_1 INTEGER NOT NULL, 
  col_2 CHAR(2) NOT NULL
);

INSERT INTO SomeTable
VALUES ('a', 1, 'あ'),
       ('b', 2, 'い'),
       ('c', 3, 'う');

SELECT * FROM SomeTable FOR UPDATE;

UPDATE SomeTable
SET p_key = CASE WHEN p_key = 'a' THEN 'b'
                 WHEN p_key = 'b' THEN 'a'
                 ELSE p_key END
WHERE p_key IN ('a', 'b');

SELECT * FROM SomeTable;

DROP TABLE SomeTable;
