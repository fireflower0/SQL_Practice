CREATE TABLE ArrayTbl (
  keycol CHAR(1) PRIMARY KEY,
  col1  INTEGER,
  col2  INTEGER,
  col3  INTEGER,
  col4  INTEGER,
  col5  INTEGER,
  col6  INTEGER,
  col7  INTEGER,
  col8  INTEGER,
  col9  INTEGER,
  col10 INTEGER
);

INSERT INTO ArrayTbl
VALUES -- オールNULL
       ('A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
       ('B', 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
       -- オール1
       ('C', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
       -- 少なくとも一つは9
       ('D', NULL, NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
       ('E', NULL, 3, NULL, 1, 9, NULL, NULL, 9, NULL, NULL);

-- 列方向への全称量化 : 芸のない答え
SELECT * FROM ArrayTbl
WHERE col1 = 1
AND col2 = 1
AND col3 = 1
AND col4 = 1
AND col5 = 1
AND col6 = 1
AND col7 = 1
AND col8 = 1
AND col9 = 1
AND col10 = 1;

-- 列方向への全称量化 : 芸のある答え (PostgreSQL)
SELECT * FROM ArrayTbl
WHERE 1 = ALL(
  array[
    col1, col2, col3, col4,
    col5, col6, col7, col8,
    col9, col9, col10
  ]
);

-- 少なくとも一つは9 (ANY)
SELECT * FROM ArrayTbl
WHERE 9 = ANY(
  array[
    col1, col2, col3, col4,
    col5, col6, col7, col8,
    col9, col9, col10
  ]
);

-- 少なくとも一つは9 (IN)
SELECT * FROM ArrayTbl
WHERE 9 IN (
  col1, col2, col3, col4,
  col5, col6, col7, col8,
  col9, col9, col10
);

-- オールNULLの行を探す : 間違った答え
SELECT * FROM ArrayTbl
WHERE NULL = ALL(
  array[
    col1, col2, col3, col4,
    col5, col6, col7, col8,
    col9, col9, col10
  ]
);

-- オールNULLの行を探す : 正しい答え
SELECT * FROM ArrayTbl
WHERE COALESCE(
  col1, col2, col3, col4,
  col5, col6, col7, col8,
  col9, col9, col10
) IS NULL;

DROP TABLE ArrayTbl;
