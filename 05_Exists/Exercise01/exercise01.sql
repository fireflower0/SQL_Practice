CREATE TABLE ArrayTbl2 (
  key CHAR(1) NOT NULL,
  i INTEGER NOT NULL,
  val INTEGER,
  PRIMARY KEY (key, i)
);

/* AはオールNULL、Bは一つだけ非NULL、Cはオール非NULL */
INSERT INTO ArrayTbl2
VALUES ('A', 1, NULL),
       ('A', 2, NULL),
       ('A', 3, NULL),
       ('A', 4, NULL),
       ('A', 5, NULL),
       ('A', 6, NULL),
       ('A', 7, NULL),
       ('A', 8, NULL),
       ('A', 9, NULL),
       ('A', 10, NULL),
       ('B', 1, 3),
       ('B', 2, NULL),
       ('B', 3, NULL),
       ('B', 4, NULL),
       ('B', 5, NULL),
       ('B', 6, NULL),
       ('B', 7, NULL),
       ('B', 8, NULL),
       ('B', 9, NULL),
       ('B', 10, NULL),
       ('C', 1, 1),
       ('C', 2, 1),
       ('C', 3, 1),
       ('C', 4, 1),
       ('C', 5, 1),
       ('C', 6, 1),
       ('C', 7, 1),
       ('C', 8, 1),
       ('C', 9, 1),
       ('C', 10, 1);

SELECT DISTINCT key
FROM ArrayTbl2 AT1
WHERE NOT EXISTS (
  SELECT * FROM ArrayTbl2 AT2
  WHERE AT1.key = AT2.key
  AND (
    AT2.val <> 1 OR AT2.val IS NULL
  )
);

-- 別解 (ALL述語)
SELECT DISTINCT key
FROM ArrayTbl2 AT1
WHERE 1 = ALL(
  SELECT val FROM ArrayTbl2 AT2
  WHERE AT1.key = AT2.key
);

-- 別解 (HAVING句)
SELECT key FROM ArrayTbl2
GROUP BY key
HAVING SUM(
  CASE WHEN val = 1 THEN 1 ELSE 0 END
) = 10;

-- 別解 (HAVING句で極値関数)
SELECT key FROM ArrayTbl2
GROUP BY key
HAVING MAX(val) = 1
AND MIN(val) = 1;

DROP TABLE ArrayTbl2;
