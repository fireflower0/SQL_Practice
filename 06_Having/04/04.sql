CREATE TABLE NullTbl (col_1 INTEGER);

INSERT INTO NullTbl
VALUES (NULL), (NULL), (NULL);

-- NULLを含む列に適用した場合、COUNT(*)とCOUNT(列名)の結果は異なる
SELECT COUNT(*), COUNT(col_1) FROM NullTbl;

DROP TABLE NullTbl;
