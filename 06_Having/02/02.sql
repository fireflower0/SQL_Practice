CREATE TABLE SeqTbl (
  seq INTEGER NOT NULL PRIMARY KEY
);

-- ### 歯抜けなし：開始値が1
INSERT INTO SeqTbl
VALUES (1), (2), (3), (4), (5);

-- 結果が返れば歯抜けあり：数列の連続性のみ調べる
SELECT '歯抜けあり' AS gap
FROM SeqTbl
HAVING COUNT(*) <> MAX(seq) - MIN(seq) + 1;

-- 欠番があっても無くても1行返す
SELECT CASE WHEN COUNT(*) = 0 THEN 'テーブルが空です'
            WHEN COUNT(*) <> MAX(seq) - MIN(seq) + 1 THEN '歯抜けあり'
            ELSE '連続' END AS gap
FROM SeqTbl;

-- 歯抜けの最小値を探す：テーブルに1がない場合は、1を返す
SELECT CASE WHEN COUNT(*) = 0 OR MIN(seq) > 1 THEN 1 -- 下限が1でない場合、1を返す
            ELSE (
              SELECT MIN(seq + 1) -- 下限が1の場合、最小の欠番を返す
              FROM SeqTbl S1
              WHERE NOT EXISTS (
                SELECT * FROM SeqTbl S2
                WHERE S2.seq = S1.seq + 1
              )
            )
            END
FROM SeqTbl;

-- ##################################################

-- ### 歯抜けあり：開始値が1
DELETE FROM SeqTbl;
INSERT INTO SeqTbl
VALUES (1), (2), (4), (5), (8);

-- 結果が返れば歯抜けあり：数列の連続性のみ調べる
SELECT '歯抜けあり' AS gap
FROM SeqTbl
HAVING COUNT(*) <> MAX(seq) - MIN(seq) + 1;

-- 欠番があっても無くても1行返す
SELECT CASE WHEN COUNT(*) = 0 THEN 'テーブルが空です'
            WHEN COUNT(*) <> MAX(seq) - MIN(seq) + 1 THEN '歯抜けあり'
            ELSE '連続' END AS gap
FROM SeqTbl;

-- 歯抜けの最小値を探す：テーブルに1がない場合は、1を返す
SELECT CASE WHEN COUNT(*) = 0 OR MIN(seq) > 1 THEN 1 -- 下限が1でない場合、1を返す
            ELSE (
              SELECT MIN(seq + 1) -- 下限が1の場合、最小の欠番を返す
              FROM SeqTbl S1
              WHERE NOT EXISTS (
                SELECT * FROM SeqTbl S2
                WHERE S2.seq = S1.seq + 1
              )
            )
            END
FROM SeqTbl;

-- ##################################################

-- ### 歯抜けなし：開始値が1ではない
DELETE FROM SeqTbl;
INSERT INTO SeqTbl
VALUES (3), (4), (5), (6), (7);

-- 結果が返れば歯抜けあり：数列の連続性のみ調べる
SELECT '歯抜けあり' AS gap
FROM SeqTbl
HAVING COUNT(*) <> MAX(seq) - MIN(seq) + 1;

-- 欠番があっても無くても1行返す
SELECT CASE WHEN COUNT(*) = 0 THEN 'テーブルが空です'
            WHEN COUNT(*) <> MAX(seq) - MIN(seq) + 1 THEN '歯抜けあり'
            ELSE '連続' END AS gap
FROM SeqTbl;

-- 歯抜けの最小値を探す：テーブルに1がない場合は、1を返す
SELECT CASE WHEN COUNT(*) = 0 OR MIN(seq) > 1 THEN 1 -- 下限が1でない場合、1を返す
            ELSE (
              SELECT MIN(seq + 1) -- 下限が1の場合、最小の欠番を返す
              FROM SeqTbl S1
              WHERE NOT EXISTS (
                SELECT * FROM SeqTbl S2
                WHERE S2.seq = S1.seq + 1
              )
            )
            END
FROM SeqTbl;

-- ##################################################

-- ### 歯抜けあり：開始値が1ではない
DELETE FROM SeqTbl;
INSERT INTO SeqTbl
VALUES (3), (4), (7), (8), (10);

-- 結果が返れば歯抜けあり：数列の連続性のみ調べる
SELECT '歯抜けあり' AS gap
FROM SeqTbl
HAVING COUNT(*) <> MAX(seq) - MIN(seq) + 1;

-- 欠番があっても無くても1行返す
SELECT CASE WHEN COUNT(*) = 0 THEN 'テーブルが空です'
            WHEN COUNT(*) <> MAX(seq) - MIN(seq) + 1 THEN '歯抜けあり'
            ELSE '連続' END AS gap
FROM SeqTbl;

-- 歯抜けの最小値を探す：テーブルに1がない場合は、1を返す
SELECT CASE WHEN COUNT(*) = 0 OR MIN(seq) > 1 THEN 1 -- 下限が1でない場合、1を返す
            ELSE (
              SELECT MIN(seq + 1) -- 下限が1の場合、最小の欠番を返す
              FROM SeqTbl S1
              WHERE NOT EXISTS (
                SELECT * FROM SeqTbl S2
                WHERE S2.seq = S1.seq + 1
              )
            )
            END
FROM SeqTbl;

-- ##################################################

DROP TABLE SeqTbl;
