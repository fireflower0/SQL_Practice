CREATE TABLE SomeTable (
  p_key CHAR(1) PRIMARY KEY,
  col_1 INTEGER NOT NULL, 
  col_2 CHAR(2) NOT NULL
);

INSERT INTO SomeTable
VALUES ('a', 1, 'あ'),
       ('b', 2, 'い'),
       ('c', 3, 'う');

SELECT * FROM SomeTable WHERE col_1 * 1.1 > 100;

SELECT * FROM SomeTable WHERE col_1 > 100 / 1.1;

-- PostgreSQLにSUBSTRは無い模様
-- SELECT * FROM SomeTable WHERE SUBSTR(col_1, 1, 1) = 'a';

-- インデックスを利用するときは、列は裸

-- インデックス列にNULLが存在する場合は注意
-- IS NULLやIS NOT NULLを使用するとインデックスが使用されなかたり
-- NULLが多い列ではインデックスが利用されなかったりと制限をうける事がある
SELECT * FROM SomeTable WHERE col_1 IS NULL;

-- IS NOT NULLの代用案
-- コードの意味を混乱させるため積極的には推奨されない
-- いざというときの応急処置として使う
SELECT * FROM SomeTable WHERE col_1 > 0;

-- 否定形を使っているとインデックスが使用できない
-- <>, !=, NOT INなど
SELECT * FROM SomeTable WHERE col_1 <> 100;

-- ORを使っているとインデックスが利用できなくなるか、ANDに比べ非効率な検索になる
SELECT * FROM SomeTable WHERE col_1 > 100 OR col_2 = 'abc';

DROP TABLE SomeTable;
