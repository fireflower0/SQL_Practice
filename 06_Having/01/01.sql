CREATE TABLE SeqTbl (
  seq INTEGER PRIMARY KEY,
  name VARCHAR(16) NOT NULL
);

INSERT INTO SeqTbl
VALUES (1, 'ディック'),
       (2, 'アン'),
       (3, 'ライル'),
       (5, 'カー'),
       (6, 'マリー'),
       (8, 'ベン');

-- 結果が返れば歯抜けあり
SELECT '歯抜けあり' AS gap
FROM SeqTbl
HAVING COUNT(*) <> MAX(seq);

-- 歯抜けの最小値を探す
SELECT MIN(seq + 1) AS gap
FROM SeqTbl
WHERE (seq + 1) NOT IN (
  SELECT seq FROM SeqTbl
);

DROP TABLE SeqTbl;
